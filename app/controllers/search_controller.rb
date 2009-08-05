class SearchController < ApplicationController
  layout 'application'

  def index
    @club = []
    if (@tagList = Tag.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"], :order => "name"))
      @tagList.each do |tag|
        (Club.find_tagged_with(tag.name)).each do |club|
          @club << Club.find(club.id, :include => :tags)
        end
      end
    end
  end

  def search
    if (params[:query]) && !(params[:search])
      if !(@club=Club.find(:first, :conditions => ['name = ?', params[:query]]))
        @clubs = Club.find_tagged_with(params[:query])
        @myAlbums = Album.find_tagged_with(params[:query])
        if params[:club_id]
          @club = Club.find(params[:club_id])
          @albums = @myAlbums & Club.find(params[:club_id]).albums
        end
      else
        redirect_to(@club)
      end
    elsif params[:club_id]
      redirect_to :controller => 'search', :action => 'search', :query => params[:search][:search], :club_id => params[:club_id]
    else
      redirect_to :controller => 'search', :action => 'search', :query => params[:search][:search]
    end
  end
end