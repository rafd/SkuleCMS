xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
 xml.channel do

   xml.title       "all_posts"
   xml.link        url_for :only_path => false, :controller => 'clubs', :action => 'show', :id => @all_posts[0].club.id
   xml.description "all_posts! holy shit!"
   
   
   @all_posts.each do |all_post|
     xml.item do      
       if all_post.class.to_s == "LargePost" then
         xml.title       all_post.title
       else
         xml.title       all_post.content
       end
       if all_post.class.to_s == "SmallPost" then
         xml.link      url_for :only_path => false, :controller=> 'clubs', :action => 'show', :id => @all_posts[0].club.id
       else
         xml.link        url_for :only_path => false, :controller=> all_post.class.to_s.tableize, :action => 'show', :id => all_post.id, :club_id => all_post.club.id
       end
       xml.description all_post.content
       xml.guid        url_for :only_path => false, :controller=> all_post.class.to_s.tableize, :action => 'show', :id => all_post.id, :club_id => all_post.club.id
       xml.description all_post.content
     end
   end
 end
end