class PriceValidator < ActiveModel::Validator
  def validate(record)
    if record.price && record.discount_price
      record.errors.add :price, 'must be greater than discount price' if record.price <= record.discount_price
    end
  end
end