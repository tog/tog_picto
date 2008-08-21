# Add your custom routes here.  If in config/routes.rb you would 
# add <tt>map.resources</tt>, here you would add just <tt>resources</tt>

# resources :pictos

namespace(:picto) do |picto| 
  picto.resources :photosets
  picto.resources :photos, :member => {:all_sizes => :get}, :collection => {:tags => :get}
end

namespace(:admin) do |admin| 
  admin.namespace(:picto) do |picto| 
    picto.dashboard  "/", :controller => "photos"
    picto.resources :photos
    picto.resources :photosets, :member => {:set_main_photo => :post, :add_photo => :post, :remove_photo => :post}
  end
end
