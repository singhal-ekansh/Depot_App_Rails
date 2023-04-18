class Category < ApplicationRecord
  has_many :sub_categories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Category", optional: true

  has_many :products, dependent: :restrict_with_error
  has_many :sub_category_products,  through: :sub_categories,  source: :products

  validates :name, presence: true
  
  validates_with UniqueRootCategoryName, if: :isNamePresent?
  validates_with UniqueSubCategoryName, if: :isNamePresent?
  validates_with CheckNestingLevel


  private

  def isNamePresent?
    name.blank?
  end

end