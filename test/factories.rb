Factory.sequence :login do |n|
  "person#{n}"
end

Factory.sequence :email do |n|
  "person#{n}@example.com"
end

Factory.define :user do |u|
  u.login { |a| Factory.next :login }
  u.salt '7e3041ebc2fc05a40c60028e2c4901a81035d3cd'
  u.crypted_password '00742970dc9e6319f8019fd54864d3ea740f04b1'
  u.activation_code '8f24789ae988411ccf33ab0c30fe9106fab32e9a'
  u.state 'pending'
  u.email { |a| Factory.next :email }
end

Factory.define :photo, :class => Picto::Photo do |photo|
  photo.title "Last summer"
  photo.description "Our trip to Thailand was a magnificent one"
  photo.association :owner, :factory => :user
end

Factory.define :photoset, :class => Picto::Photoset do |photoset|
  photoset.title "Trips"
  photoset.description "All our trips to this date"
  photoset.association :owner, :factory => :user
end

