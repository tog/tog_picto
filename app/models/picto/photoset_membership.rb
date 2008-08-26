class Picto::PhotosetMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :photoset
end