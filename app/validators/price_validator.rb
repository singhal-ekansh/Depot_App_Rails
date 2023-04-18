class PriceValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :price, 'must be greater than discount price' if record.price <= record.discount_price
  end
end