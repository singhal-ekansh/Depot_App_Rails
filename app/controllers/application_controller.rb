class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  before_action :authorize
  before_action :before_elapsed_time
  after_action :after_elapsed_time
  before_action :check_inactivity

  def before_elapsed_time
    @elapsed_time = Time.now
    p "-------------------"
    p @elapsed_time
  end

  def after_elapsed_time
    @elapsed_time = Time.now - @elapsed_time
    p "-------------------"
    p @elapsed_time
  end

  protected 
    
    def authorize 
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "please log in"
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] =
            "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def check_inactivity
      if session[:user_id] && (Time.now - Time.parse(session[:inactivity]) > 30000)
        session[:user_id] = nil
        redirect_to store_index_url, notice: "logged out due to inactivity"
      else
        session[:inactivity] = Time.now
      end
    end   
end
