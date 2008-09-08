class Picto::PhotosetsController < ApplicationController

  helper "picto/base"
  
  #after_filter :filter_photosets

  def index
    @photosets = filter(Picto::Photoset.find(:all))
    
  end
  def show
    @photoset = Picto::Photoset.find(params[:id])
    unless @photoset.authorized(current_user, :read)
      redirect_to denied_path
    end
  end
  
  def filter(photosets)
    if photosets
      photosets = photosets.delete_if{|set| 
        !set.authorized(current_user, :read)
      }
    end
  end
end