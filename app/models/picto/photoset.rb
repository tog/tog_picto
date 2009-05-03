class Picto::Photoset < ActiveRecord::Base

  IS_PUBLIC  = 0
  IS_FRIENDS = 1
  IS_PRIVATE = 2

  acts_as_commentable
  acts_as_taggable
  acts_as_rateable :average => true

  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  belongs_to :main_photo, :class_name => "Picto::Photo", :foreign_key => "main_photo_id"

  has_many   :photos, :order => "position"
  has_many   :memberships, :class_name => "Picto::PhotosetMembership"
  has_many   :members, :class_name => "User", :through => :memberships, :source => :user


  def authorized(user, permission=:all)
    case permission
    when :read
      authorized_read(user)
    when :write
      authorized_write(user)
    when :destroy
      authorized_destroy(user)
    when :all
      authorized_all(user)
    end
  end

  def authorized_read(user)
    case self.privacy
    when IS_PUBLIC
      return true
    when IS_FRIENDS
      return self.owner.profile.friends.include?(user)
    when IS_PRIVATE
      return self.owner == user
    end
  end

  def authorized_write(user)
    return self.owner == user
  end

  def authorized_destroy(user)
    return self.owner == user
  end

  def authorized_all(user)
    authorized_read(user) && authorized_write(user) && authorized_destroy(user)
  end
  
  def creation_date(format=:short)
    I18n.l(self.created_at, :format => format)
  end  

  def number_of_photos
    photos.length
  end

end