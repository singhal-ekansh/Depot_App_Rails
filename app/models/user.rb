class User < ApplicationRecord
  EMAIL_REGEX = %r{/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$}
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password
  
  # validation extentions
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: {
    with: EMAIL_REGEX,
    message: "syntax not valid"
  }

  class Error < StandardError
  end
  
  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end
end
