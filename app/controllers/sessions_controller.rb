class SessionsController < ApplicationController
  skip_before_action :authorize
  
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      I18n.default_locale = LANGUAGES.to_h[user.language_pref.capitalize].to_sym
      session[:inactivity] = Time.now
      if user.role == 'admin'
        redirect_to admin_reports_url
      else
        debugger
        flash[:notice] = I18n.with_locale(LANGUAGES.to_h[user.language_pref.capitalize].to_sym) { t('.no_privilage') }
        redirect_to store_index_url
      end

    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_index_url, notice: "Logged out"
  end
end
