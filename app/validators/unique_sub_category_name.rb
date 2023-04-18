class UniqueSubCategoryName < ActiveModel::Validator
  def validate(record)
    return unless record.parent_id

    sub_categories_names = Category.find(record.parent_id).sub_categories.pluck(:name)
    record.errors.add(:name, "name of sub categories should be unique for each category") if sub_categories_names.include?(record.name)
  end
end
