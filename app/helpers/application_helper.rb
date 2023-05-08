module ApplicationHelper
  def render_if(condition, record)
    if condition
      render record
    end
  end

  def set_hit_count
    session[params[:controller]] = Hash.new unless session[params[:controller]]
    session[params[:controller]][params[:action]] = 0 unless session[params[:controller]][params[:action]]
    session[params[:controller]][params[:action]] += 1
  end
end
