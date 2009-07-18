xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
 xml.channel do

   xml.title       "large_posts"
   xml.link        url_for :only_path => false, :controller => 'large_posts'
   xml.description "large_posts! holy shit!"

   @large_posts.each do |large_post|
     xml.item do
       xml.title       large_post.title
       xml.link        url_for :only_path => false, :controller => 'large_posts', :action => 'show', :id => large_post.id
       xml.description large_post.content
       xml.guid        url_for :only_path => false, :controller => 'large_posts', :action => 'show', :id => large_post.id
     end
   end

 end
end