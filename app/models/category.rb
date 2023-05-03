class Category < ApplicationRecord
  has_many :sub_categories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Category", optional: true

  has_many :products, dependent: :restrict_with_error
  has_many :sub_category_products,  through: :sub_categories,  source: :products, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { scope: :parent_id, message: 'name of root category should be unique' }, allow_blank: true, unless: :isParentPresent?
  validates :name, uniqueness: { scope: :parent_id, message: 'name of sub categories should be unique for each category' }, allow_blank: true, if: :isParentPresent?
  validates_with NoChildOfSubCategory

  private

  def isNamePresent?
    name.blank?
  end

<<<<<<< HEAD
  def isParentPresent?
    self.parent_id
  end

=======
>>>>>>> 4ff8c7e5dd4871f5aca18a6645ab88c8dc3db91e
end