module ActsAsTaggableHelper
  # Create a link to the tag using restful routes and the rel-tag microformat
  def link_to_tag(tag)
    link_to(tag.name, tag_url(tag), :rel => 'tag')
  end
  
  # Generate a tag cloud of the top 100 tags by usage, uses the proposed hTagcloud microformat.
  #
  # Inspired by http://www.juixe.com/techknow/index.php/2006/07/15/acts-as-taggable-tag-cloud/
  def tag_cloud(options = {})
    options.assert_valid_keys(:limit, :conditions, :counter_cache, :show_count, :sort)
    options.reverse_merge! :limit => 100, :counter_cache => :taggings_count, :show_count => false, :sort => :name
    taggings_count = options.delete(:counter_cache)
    show_count = options.delete(:show_count)
    sort = options.delete(:sort)

    tags = Tag.find(:all, options.merge(:order => "#{taggings_count} DESC")).sort_by(&sort)
    
    # TODO: add option to specify which classes you want and overide this if you want?
    classes = %w(popular v-popular vv-popular vvv-popular vvvv-popular)
    
    max, min = 0, 0
    tags.each do |tag|
      max = tag.send(taggings_count) if tag.send(taggings_count) > max
      min = tag.send(taggings_count) if tag.send(taggings_count) < min
    end
    
    divisor = ((max - min) / classes.size) + 1
    
    html =    %(<div class="hTagcloud">\n)
    html <<   %(  <ul class="popularity">\n)
    tags.each do |tag|
      html << %(    <li>)
      linktext = tag.name
      linktext << " (#{tag.send(taggings_count)})" if show_count && tag.send(taggings_count) > 1
      html << link_to(linktext, tag_url(tag), :class => classes[(tag.send(taggings_count) - min) / divisor]) 
      html << %(</li> \n)
    end
    html <<   %(  </ul>\n)
    html <<   %(</div>\n)
  end
end