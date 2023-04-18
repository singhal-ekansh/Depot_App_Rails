class UniqueRootCategoryName < ActiveModel::Validator
  def validate(record)
    return if record.parent_id

    root_categories_names = Category.where(parent_id: nil).pluck(:name)
    record.errors.add(:name, "name of root category should be unique") if root_categories_names.include?(record.name)
  end
end