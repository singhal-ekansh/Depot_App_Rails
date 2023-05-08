task :set_admin, [:email] => :environment do |task, arguments|
  user = User.find_by_email(arguments[:email])
  user.update(role: 'admin') if user
end
