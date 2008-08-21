class AddPrivateColumnToPhotoset < ActiveRecord::Migration
  def self.up
    add_column :photosets, :privacy, :integer
    change_column_default :photosets, :privacy, Picto::Photoset::IS_PUBLIC
    Picto::Photoset.find(:all).each{|set|
      set.privacy = Picto::Photoset::IS_PUBLIC 
      set.save!
    }
  end

  def self.down
    remove_column :photosets, :privacy
  end
end
