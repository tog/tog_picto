class Member::Picto::PhotosetsController < Member::BaseController
  
  helper "picto/base"

  def index
    @owned_photosets = current_user.owned_photosets.paginate(:page => params[:page], :order => "created_at DESC")
    @joined_photosets = current_user.joined_photosets
  end
  
  def new
    @photoset = current_user.owned_photosets.new
  end
  
  def create
    @photoset = current_user.owned_photosets.build(params[:photoset])
    @photoset.save!
    
    flash[:ok] = I18n.t("tog_picto.member.photoset_created") 
    redirect_to member_picto_photosets_path
  end
  def edit
    @photoset = current_user.owned_photosets.find(params[:id])
    
  end
  def update
    @photoset = current_user.owned_photosets.find(params[:id])
    respond_to do |wants|
      if @photoset.update_attributes(params[:photoset])
        wants.html do
          flash[:ok]= I18n.t("tog_picto.member.photoset_updated") 
          redirect_to member_picto_photosets_path
        end
      else
        wants.html do
          flash[:error]=I18n.t("tog_picto.member.photoset_update_error")
          render :action => :edit
        end
      end
    end
  end

  def add_photo
    @photoset = current_user.owned_photosets.find(params[:id])
    @photoset.photos << photo_for_xhr_id("_",params[:photo_id])
    @photoset.save!
    render :partial => 'photoset_photos', :locals => {:photos_in_the_set => @photoset.photos}
  end
  def remove_photo
    @photoset = current_user.owned_photosets.find(params[:id])
    @photoset.photos.delete(photo_for_xhr_id("photo_in_set_",params[:photo_id]))
    @photoset.save!
    render :partial => 'photoset_photos', :locals => {:photos_in_the_set => @photoset.photos}
  end

  def set_main_photo
    @photoset = current_user.owned_photosets.find(params[:id])
    @photoset.main_photo = photo_for_xhr_id("photo_in_set_", params[:photo_id])
    @photoset.save!
    render :partial => 'main_photo_in_the_set', :locals => {:photoset => @photoset}
  end
  def destroy
    @photoset = current_user.owned_photosets.find(params[:id])
    @photoset.destroy
    respond_to do |wants|
      wants.html do
        flash[:ok]=I18n.t("tog_picto.member.photoset_deleted")
        redirect_to member_picto_photosets_path
      end
    end
    
  end

  private 

  def photo_for_xhr_id(name, photo_id)
    id = photo_id.split(name)[1]
    current_user.photos.find(id)
  end

end