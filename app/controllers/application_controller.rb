# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'rss/2.0'
require 'open-uri'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :load_club

  helper_method :current_admin
 
  private
 
  def feed_list_length
    return 5
  end

  def feed_rss_length
    return 10
  end
  
  def feed_add_length
    return 3
  end

  def feed_output(feeds, feed_length, feed_type, find_hash)
    feed_out = []
    feeds.each do |feed|
       feed_out = feed_out + feed.find(feed_type, :limit => find_hash[:limit], :order => find_hash[:order], :conditions => find_hash[:conditions])
    end
    feed_out = feed_out.sort_by{|t| t.created_at}.reverse
    feed_out = feed_out[0..feed_length-1]
    
    return feed_out
  end

  def feed_earliest_time(feed)
    if feed[0] != nil
      earliest_time = feed[-1].created_at.utc.to_s(:db)
    else
      earliest_time = 0
    end
 
    return earliest_time
  end
  
  def feed_eat_external(feed_url, length=2, perform_validation=false)
    feed_out = []
    open(feed_url) do |rss|
      feed_out = RSS::Parser.parse(rss, perform_validation).items
    end
    if feed_out.length > length
      return feed_out[0..length-1]
    else
      return feed_out
    end
  end
  
  def feed_pull_external(club_id)

    club = Club.find(club_id)
    feed_out = feed_eat_external(club.rss_link, feed_rss_length)

    feed_out.reverse.each do |entry|
      last_external_post = club.external_posts.find(:last)

      if (last_external_post == nil) ||(entry.pubDate.utc.to_i > last_external_post.created_at.utc.to_i)
        
       #deep copy outside feed => new external post
        new_external_post = club.external_posts.new
        new_external_post.title = entry.title
        new_external_post.content = entry.description
        new_external_post.weblink = entry.link
        new_external_post.club_id = club.id
        
        new_external_post.save
        
        ####
        new_external_post.created_at = entry.pubDate.utc.strftime("%Y-%m-%d %H:%M:%S")
        ####
        
        new_external_post.save
        
      end
    end
    
  end
  
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
    elsif !current_admin.super_admin && current_admin.club_id.blank?
      redirect_to new_club_path
    elsif !current_admin.super_admin && current_admin.club_id != @club.id
      redirect_to club_path(@club.id)
    end
  end

  def auth_super_admin_only
    if current_admin.blank?
      redirect_to login_path
    elsif !current_admin.super_admin
      redirect_to root_path
    end
  end

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
end
