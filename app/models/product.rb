class Product < ApplicationRecord
  MIN_THREE_WORDS_REGXP = /(\w+)-(\w+)-(\w+)/
  SPECIAL_CHAR_REGXP = /\A[\w-]+\z/
  has_many :line_items, dependent: :restrict_with_exception
  has_many :orders, through: :line_items
  has_many :carts, through: :line_items
  # before_destroy :ensure_not_referenced_by_any_line_item 

  # callbacks extentions
  before_validation do 
    self.title = 'abc' if title.blank?
    self.discount_price = price if discount_price.blank?
  end

  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true
  
  # validation extentions 
  validates :permalink, uniqueness: { case_sensitive: false }
  validates :permalink, format: {
    with: SPECIAL_CHAR_REGXP,
    message: 'spacial character and space not allowed'
  }
  validates :permalink, format: {
    with: MIN_THREE_WORDS_REGXP,
    message: 'minimum 3 words, separated by hyphen'
  }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, allow_blank: true
  validate :validate_description_length
  validates :image_url, url:true
  validates_with PriceValidator, unless: -> { price.blank? || discount_price.blank? }
  validates :price, comparison: { greater_than: :discount_price, message: 'must be greater than discount price' }, unless: -> { discount_price.blank? }
  

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


