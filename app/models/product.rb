class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute,'must be a URL for GIF, JPG or PNG image') unless value =~ %r{\.(gif|jpg|png)\z}i
  end 
end

class PriceValidator < ActiveModel::Validator
  def validate(record)
    price_value = record.send(:price)
    discount_value = record.send(:discount_price)
    if price_value && discount_value 
      record.errors.add :price, 'must be greater than discount price' if price_value < discount_value
    end
  end
end

class Product < ApplicationRecord

  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item 

  # callbacks extentions
  after_initialize do 
    self.title = 'abc' if title.blank?
    self.discount_price = price if price && discount_price.blank?
  end



  validates :title, :description, :image_url, presence: true
  # validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  # validates :image_url, allow_blank: true, format: {
  #   with: %r{\.(gif|jpg|png)\z}i,
  #   message: 'must be a URL for GIF, JPG or PNG image.'
  #   }

  # validation extentions 
  validates :permalink, uniqueness: true
  validates :permalink, format: {
    without: /[^A-Za-z0-9\-]/,
    message: 'spacial character and space not allowed'
  }
  validates :permalink, format: {
    with: /(\w+)-(\w+)-(\w+)/,
    message: 'minimum 3 words, separated by hyphen'
  }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, allow_blank: true
  validate :validate_description_length
  validates :image_url, url:true
  validates_with PriceValidator
  validates :price, comparison: {greater_than: :discount_price, message: 'must be greater than discount price' }
  


  private 
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line Items present')
        throw :abort
      end
    end

    def validate_description_length
      errors.add(:description, 'length should be between 5-10') unless description && description.split.size.between?(5,10)
    end

end


