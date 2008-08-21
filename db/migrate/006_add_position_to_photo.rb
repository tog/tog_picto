class AddPositionToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :position, :integer
    change_column_default :photos, :position, 1
    Picto::Photoset.find(:all).each{|set|
      set.photos.each_with_index{|photo, i|
        photo.position = i + 1
        photo.save!
      }
    }
  end

  def self.down
    remove_column :photos, :position
  end
end
