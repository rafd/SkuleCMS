xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
 xml.channel do

   xml.title       "small_posts"
   xml.link        url_for :only_path => false, :controller => 'small_posts'
   xml.description "small_posts! holy shit!"

   @small_posts.each do |small_post|
     xml.item do
       xml.title       small_post.id
       xml.link        url_for :only_path => false, :controller => 'small_posts', :action => 'show', :id => small_post.id
       xml.description small_post.content
       xml.guid        url_for :only_path => false, :controller => 'small_posts', :action => 'show', :id => small_post.id
     end
   end

 end
end