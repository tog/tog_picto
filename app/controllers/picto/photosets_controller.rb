class Picto::PhotosetsController < ApplicationController

  helper "picto/base"
  
  #after_filter :filter_photosets

  def index
    
    @order = params[:order] || 'created_at'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'desc'   
    @photosets = filter(Picto::Photoset.find(:all)).paginate :page => @page,
                                  :per_page => Tog::Config["plugins.tog_social.profile.list.page.size"],
                                  :order => @order + " " + @asc 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photosets }
    end    
  end
  
  def show
    @photoset = Picto::Photoset.find(params[:id])
#    if @photoset.authorized(current_user, :read)
#      redirect_to denied_path
#    else
      @order = params[:order] || 'created_at'
      @page = params[:page] || '1'
      @asc = params[:asc] || 'desc'   
      @photos = @photoset.photos.paginate :page => @page,
                                    :per_page => Tog::Config["plugins.tog_social.profile.list.page.size"],
                                    :order => @order + " " + @asc      
#    end
  end
  
  def filter(photosets)
    if photosets
      photosets = photosets.delete_if{|set| 
        !set.authorized(current_user, :read)
      }
    end
  end
end