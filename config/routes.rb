# Add your custom routes here.  If in config/routes.rb you would 
# add <tt>map.resources</tt>, here you would add just <tt>resources</tt>

# resources :pictos

with_options(:controller => 'picto/photos', :conditions => { :method => :get }) do |photo|
   photo.picto_scaled_photo   '/picto/photos/:id/:size', :action => 'show'
end

namespace(:picto) do |picto| 
  picto.resources :photosets
  picto.resources :photos, :collection => {:tags => :get}
end

namespace(:member) do |member| 
  member.namespace(:picto) do |picto| 
    picto.dashboard  "/", :controller => "photos"
    picto.resources :photos
    picto.resources :photosets, :member => {:set_main_photo => :post, :add_photo => :post, :remove_photo => :post}
  end
end
