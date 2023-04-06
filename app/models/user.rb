class User < ApplicationRecord
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password

  # callbacks extentions
  before_destroy :ensure_admin_email
  before_update :ensure_admin_email
  after_create_commit do
    UserMailer.welcome_mail(self).deliver_later
  end
  
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

    def ensure_admin_email 
      throw :abort if User.find(id).email == 'admin@depot.com'
    end
end
