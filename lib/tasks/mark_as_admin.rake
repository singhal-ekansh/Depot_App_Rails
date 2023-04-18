namespace :custom_tasks do
  task :mark_as_admin, [:email] => :environment do |t, args|
      user = User.find_by_email(args[:email])
      user.update_columns(role: 'admin')
  end
end