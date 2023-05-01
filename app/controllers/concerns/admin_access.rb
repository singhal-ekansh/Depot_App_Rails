module AdminAccess

  private
  
  def is_admin?
    User.find(session[:user_id]).role == 'admin'
  end

  def only_admin_access
    unless is_admin?
      flash[:notice] = "You don't have privilege to access this section"
      redirect_to store_index_url
    end
  end
end