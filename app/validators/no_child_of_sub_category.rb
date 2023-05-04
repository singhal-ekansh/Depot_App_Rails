class NoChildOfSubCategory < ActiveModel::Validator
  def validate(record)
    record.errors.add(:base, "sub category cannot have any child category") if parent && parent.parent
  end
end