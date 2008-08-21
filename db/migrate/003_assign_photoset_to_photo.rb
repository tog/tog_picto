class AssignPhotosetToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :photoset_id, :integer
  end

  def self.down
    remove_column :photos, :photoset_id
  end
end
