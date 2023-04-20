class User < ApplicationRecord
  EMAIL_REGEX = %r{/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$}
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password
  
  # callbacks extentions
  before_destroy :ensure_not_delete_if_admin_email
  before_update :ensure_not_update_if_admin_email
  after_create_commit :send_email_to_user

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

    def ensure_not_delete_if_admin_email 
      if self.email_was == 'admin@depot.com'
        errors.add(:base, 'can not delete admin')
        throw:abort
      end
    end

    def ensure_not_update_if_admin_email 
      if self.email_was == 'admin@depot.com'
        errors.add(:base, 'can not update admin')
        throw:abort
      end
    end

    def send_email_to_user
      UserMailer.welcome_mail(self).deliver_later
    end

end
