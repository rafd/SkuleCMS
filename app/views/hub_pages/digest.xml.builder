xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
 xml.channel do

   xml.title       "Skule Digest"
   xml.link        url_for :only_path => false, :controller => 'hub_pages', :action => 'digest'
   xml.description "Skule Digest! holy shit!"
   
   
   @feed_items.each do |feed_item|
     xml.item do      
       case feed_item.class.to_s
         when "SmallPost" then
           xml.title          feed_item.content
           xml.link           url_for :only_path => false, :controller=> 'clubs', :action => 'show', :id => @feed_items[0].club.id
           xml.description    feed_item.content
           xml.guid           url_for :only_path => false, :controller=> 'clubs', :action => 'show', :id => @feed_items[0].club.id
         when "LargePost" then
           xml.title          feed_item.title
           xml.link           url_for :only_path => false, :controller=> feed_item.class.to_s.tableize, :action => 'show', :id => feed_item.id, :club_id => feed_item.club.id
           xml.description    feed_item.content
           xml.guid           url_for :only_path => false, :controller=> feed_item.class.to_s.tableize, :action => 'show', :id => feed_item.id, :club_id => feed_item.club.id
         when "Event" then
           xml.title          feed_item.name
           xml.link           url_for :only_path => false, :controller=> feed_item.class.to_s.tableize, :action => 'show', :id => feed_item.id, :club_id => feed_item.club.id
           xml.description    short_time(feed_item.start) + " @ " + feed_item.location + ": " + feed_item.description
           xml.guid           url_for :only_path => false, :controller=> feed_item.class.to_s.tableize, :action => 'show', :id => feed_item.id, :club_id => feed_item.club.id
        end
      end
    end
  end
end