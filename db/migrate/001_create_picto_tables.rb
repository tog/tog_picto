class CreatePictoTables < ActiveRecord::Migration
  def self.up
    create_table :photosets do |t|
      t.string :title
      t.string :description
      t.integer :main_photo_id
      t.timestamps
    end
    create_table :photos do |t|
      t.string :title
      t.string :description
      t.string :image
      t.timestamps
    end
  end

  def self.down
    drop_table :photosets
    drop_table :photos
  end
end
