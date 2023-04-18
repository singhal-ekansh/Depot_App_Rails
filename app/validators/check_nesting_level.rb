class CheckNestingLevel < ActiveModel::Validator
  def validate(record)
    return unless record.parent_id

    sub_categories_ids = Category.where("parent_id is not null").pluck(:id)
    record.errors.add(:base, "sub category cannot have any child category") if sub_categories_ids.include?(record.parent_id)
  end
end