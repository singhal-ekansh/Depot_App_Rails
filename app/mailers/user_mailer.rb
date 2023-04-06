class UserMailer < ApplicationMailer

  def welcome_mail(user)
    mail to: user.email, subject: "Welcome #{user.name} to Depot"
  end
end
