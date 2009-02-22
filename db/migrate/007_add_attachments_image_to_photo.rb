class AddAttachmentsImageToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :image_file_name, :string
    add_column :photos, :image_content_type, :string
    add_column :photos, :image_file_size, :integer
    add_column :photos, :image_updated_at, :datetime

    rename_column :photos, :image, :old_file_name

    add_crop("plugins.tog_picto.photo.versions.tiny")

    Picto::Photo.all.each do |p|
      unless p.old_file_name.blank?
        p.image = File.new("public/system/photos/picto/photo/image/#{p.id}/#{p.old_file_name}") if File.exists?("public/system/photos/picto/photo/image/#{p.id}/#{p.old_file_name}")
        p.save!
      end
    end
    FileUtils.rm_rf "public/system/photos/picto/"

    remove_column :photos, :old_file_name
  end

  def self.down
    add_column :photos, :image, :string

    remove_crop("plugins.tog_picto.photo.versions.tiny")

    Picto::Photo.all.each do |p|
      unless p.image_file_name.blank?
        p.image = File.new("public/system/picto/photos/images/#{p.id}/#{p.image_file_name}") if File.exists?("public/system/picto/photos/images/#{p.id}/#{p.image_file_name}")
        p.save!
      end
    end
    FileUtils.rm_rf "public/system/picto/photos"

    remove_column :photos, :image_file_name
    remove_column :photos, :image_content_type
    remove_column :photos, :image_file_size
    remove_column :photos, :image_updated_at
  end

  private
  def self.add_crop(key)
    Tog::Config[key]="#{Tog::Config[key]}#" unless Tog::Config[key] =~ /#|%|@|!|<|>|\^/
  end

  def self.remove_crop(key)
    Tog::Config[key]=Tog::Config[key].gsub("#",'')
  end
end
