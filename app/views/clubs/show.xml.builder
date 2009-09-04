xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
 xml.channel do

   xml.title       @feed[0].club.name
   xml.link        url_for :only_path => false, :controller => 'clubs', :action => 'show', :id => @feed[0].club.id
   xml.description @feed[0].club.tagline
   
   xml.image do
     xml.title     @feed[0].club.name
     xml.link      url_for :only_path => false, :controller => 'clubs', :action => 'show', :id => @feed[0].club.id
     xml.url       path_to_image(FileTest.exist?("public/images/avatars/"+@feed[0].club.web_name) ? "avatars/"+@feed[0].club.web_name : "blank.gif")
   end
 
     
@feed.each do |feed_item|
     xml.item do      
       case feed_item.class.to_s
         when "SmallPost" then
           xml.title          feed_item.content
           xml.link           url_for :only_path => false, :controller=> 'clubs', :action => 'show', :id => feed_item.club.id
           xml.description    feed_item.content
           #xml.guid           url_for :only_path => false, :controller=> 'clubs', :action => 'show', :id => feed_item.club.id
           xml.pubDate        feed_item.created_at
         when "LargePost" then
           xml.title          feed_item.title
           xml.link           url_for :only_path => false, :controller=> feed_item.class.to_s.tableize, :action => 'show', :id => feed_item.id, :club_id => feed_item.club.id
           xml.description    feed_item.content
           xml.guid           url_for :only_path => false, :controller=> feed_item.class.to_s.tableize, :action => 'show', :id => feed_item.id, :club_id => feed_item.club.id
           xml.pubDate        feed_item.created_at
         when "Event" then
           xml.title          feed_item.name
           xml.link           url_for :only_path => false, :controller=> feed_item.class.to_s.tableize, :action => 'show', :id => feed_item.id, :club_id => feed_item.club.id
           xml.description    short_time(feed_item.start) + " @ " + feed_item.location + ": " + feed_item.description
           xml.guid           url_for :only_path => false, :controller=> feed_item.class.to_s.tableize, :action => 'show', :id => feed_item.id, :club_id => feed_item.club.id
           xml.pubDate        feed_item.created_at
       end
     end
   end
   
   
   
 end
end