class Picto::PhotosController < ApplicationController

  helper "picto/base"

  def index
    @your_photos = filter(current_user.photos) if current_user
    @last_photos = filter(Picto::Photo.find(:all, :limit => 20, :order => "created_at DESC"))
  end

  def show
    @size = (params[:size] || :big).to_sym     
    @photo = Picto::Photo.find(params[:id])
    auth_photo(@photo)
  end

  def tags
    @order = params[:order] || 'created_at'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'desc'    
    @tag = params[:tag]
    if params[:user].blank?
      @photos = Picto::Photo.find_tagged_with(@tag).paginate :page => @page,
                                    :per_page => Tog::Config["plugins.tog_social.profile.list.page.size"],
                                    :order => @order + " " + @asc
    else
      @user = User.find params[:user]
      @photos = @user.photos.find_tagged_with(@tag).paginate :page => @page,
                                    :per_page => Tog::Config["plugins.tog_social.profile.list.page.size"],
                                    :order => @order + " " + @asc
    end
    filter(@photos)
  end
  
  def filter(photos)
    if photos
      photos = photos.delete_if{|photo| 
        photo.photoset && !photo.photoset.authorized(current_user, :read)
      }
    end
  end
  
  def auth_photo(photo)
    if photo.photoset 
      if !photo.photoset.authorized(current_user, :read)
        redirect_to denied_path
      end
    end 
  end
end