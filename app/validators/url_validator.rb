class UrlValidator < ActiveModel::EachValidator
  VALID_URL = %r{\.(gif|jpg|png)\z}i
  def validate_each(record, attribute, value)
    record.errors.add(attribute,'must be a URL for GIF, JPG or PNG image') unless value =~ VALID_URL
  end 
end
