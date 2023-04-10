class PriceValidator < ActiveModel::Validator
  def validate(record)
    price_value = record.send(:price)
    discount_value = record.send(:discount_price)
    if price_value && discount_value 
      record.errors.add :price, 'must be greater than discount price' if price_value < discount_value
    end
  end
end