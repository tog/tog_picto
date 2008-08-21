class CreatePhotosetMemberships < ActiveRecord::Migration
  def self.up
    add_column :photosets, :user_id, :integer
    create_table :photoset_memberships do |t|
      t.integer :user_id
      t.integer :photoset_id
      t.timestamps
    end
  end

  def self.down
    drop_table :photoset_memberships
    remove_column :photosets, :user_id
  end
end