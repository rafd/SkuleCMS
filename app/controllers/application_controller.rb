# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :load_club


  helper_method :current_admin
  
  private
  
  def load_club
    if !params[:club_id].blank?
      @club = Club.find(params[:club_id])
    end
  end
  
  def current_admin_session
    return @current_admin_session if defined?(@current_admin_session)
    @current_admin_session = AdminSession.find
  end

  def current_admin
    return @current_admin if defined?(@current_admin)
    @current_admin = current_admin_session && current_admin_session.record
  end

  def auth_admin
    if current_admin.blank?
      redirect_to login_path
    elsif current_admin.super_admin
      redirect_to admins_path
    elsif current_admin.club_id.blank?
      redirect_to new_club_path
    elsif current_admin.club_id != @club.id
      redirect_to club_path(@club.id)
    end
  end

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
end
