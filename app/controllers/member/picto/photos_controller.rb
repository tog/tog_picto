class Member::Picto::PhotosController < Member::BaseController

  helper "picto/base"

  def index
    @my_photos = current_user.photos.paginate(:page => params[:page], :order => "created_at DESC")
  end

  def new
    @photo = current_user.photos.new
    @owned_photosets = current_user.owned_photosets
  end

  def create
    @photos = current_user.photos.build(params[:photo].values)
    @common_photoset = params[:common][:photoset]
    @common_tags = params[:common][:tag_list]

    if @common_photoset=="0" && !params[:photoset][:title].blank?
      @photoset = current_user.owned_photosets.build(params[:photoset])
      @photoset.save!
    else
      @photoset = current_user.owned_photosets.find @common_photoset unless @common_photoset.blank?
    end

    @photos.each do |p|
      if p.image?
        unless @photoset.nil?
          p.photoset = @photoset
          @photoset.main_photo = p if @photoset.main_photo.blank?
        end
        p.tag_list = %(#{p.tag_list.to_s},#{@common_tags})
        p.title = p.image.original_filename if p.title.blank?
        p.save!
      end
    end

    flash[:ok] = I18n.t("tog_picto.member.photos_uploaded")

    unless @photoset.nil?
      @photoset.save!
      redirect_to edit_member_picto_photoset_path(@photoset)
    else
      redirect_to member_picto_photos_path
    end
  end

  def edit
    @photo = current_user.photos.find(params[:id])
  end

  def update
    @photo = current_user.photos.find(params[:id])
    respond_to do |wants|
      if @photo.update_attributes(params[:photo])
        wants.html do
          flash[:ok]=I18n.t("tog_picto.member.photo_updated")
          redirect_to member_picto_photos_path
        end
      else
        wants.html do
          flash.now[:error]=I18n.t("tog_picto.member.photo_update_error")
          render :action => :edit
        end
      end
    end
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    @photo.destroy
    respond_to do |wants|
      wants.html do
        flash[:ok]=I18n.t("tog_picto.member.photo_deleted")
        redirect_to member_picto_photos_path
      end
    end
  end

end