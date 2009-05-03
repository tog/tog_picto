class User < ActiveRecord::Base
  has_many :photos, :class_name => "Picto::Photo", :dependent => :destroy
  has_many :owned_photosets, :class_name => "Picto::Photoset"
  has_many :photoset_memberships, :class_name => "Picto::PhotosetMembership"
  has_many :joined_photosets, :class_name => "Picto::Photoset", :through => :photoset_memberships, :source => :user

  def public_photosets
    owned_photosets.delete_if {|set| !set.authorized(nil, :read)}
  end

  def number_of_photos
    owned_photosets.inject(0) { |sum, photoset| sum + photoset.number_of_photos }
  end
end