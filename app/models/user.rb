class User < ApplicationRecord
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password
  
  # validation extentions
  validates :email, presence: true, uniqueness: true
  validates :email, format: {
    with: %r{.+@\w+\.com\z},
    message: "invalid syntax"
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
