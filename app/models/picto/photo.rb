class Picto::Photo < ActiveRecord::Base
  before_update :update_position

  acts_as_commentable
  acts_as_taggable
  acts_as_rateable :average => true
  acts_as_list :scope => :photoset
  
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  belongs_to :photoset
  named_scope :public, :joins => "INNER JOIN photosets ON photosets.id = photos.photoset_id",:conditions => ['photosets.privacy = 0']

  file_column :image, :root_path => File.join(RAILS_ROOT, "public/system/photos"), :web_root => 'system/photos/', :magick => {
    :versions => {
      :original => {:name => "original"},
      :big      => {:size => Tog::Plugins.settings(:tog_picto, "photo.versions.big"),    :name => "big"},
      :medium   => {:size => Tog::Plugins.settings(:tog_picto, "photo.versions.medium"), :name => "medium"},
      :small    => {:size => Tog::Plugins.settings(:tog_picto, "photo.versions.small"),  :name => "small"},
      :tiny     => {:size => Tog::Plugins.settings(:tog_picto, "photo.versions.tiny"),   :name => "tiny", :crop => "1:1"}
    }
  }

  private

  def update_position
    add_to_list_bottom if position.nil? || photoset_id != Picto::Photo.find(self.id).photoset_id
  end

end