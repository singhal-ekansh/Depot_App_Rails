class Product < ApplicationRecord
  MIN_THREE_WORDS_REGXP = /(\w+)-(\w+)-(\w+)/
  SPECIAL_CHAR_REGXP =/[^A-Za-z0-9\-]/
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item 

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
    without: SPECIAL_CHAR_REGXP,
    message: 'spacial character and space not allowed'
  }
  validates :permalink, format: {
    with: MIN_THREE_WORDS_REGXP,
    message: 'minimum 3 words, separated by hyphen'
  }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, allow_blank: true
  validate :validate_description_length
  validates :image_url, url:true
  validates_with PriceValidator
  validates :price, comparison: { greater_than: :discount_price, message: 'must be greater than discount price' }
  


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


