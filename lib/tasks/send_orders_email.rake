namespace :custom_tasks do
  task :send_orders_email => :environment do
    User.all.each do |user|
      OrderMailer.consolidated_email(user).deliver_now
    end
  end
end