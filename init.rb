require_plugin 'tog_core'
require_plugin 'tog_social'
require_plugin 'acts_as_list'


Tog::Plugins.settings :tog_picto, "photo.versions.big"    => "700x700>",
                                  "photo.versions.medium" => "500x500>",
                                  "photo.versions.small"  => "250x250>",
                                  "photo.versions.tiny"   => "75x75#",
                                  "photo.total_file_size_limit" => 10*(2**20) # 10 MB

Tog::Interface.sections(:member).add "Photos", "/member/picto/photos"
Tog::Interface.sections(:site).add "Photos", "/picto/photosets"

require "i18n" unless defined?(I18n)
Dir[File.dirname(__FILE__) + '/locale/**/*.yml'].each do |file|
  I18n.load_path << file
end

#Tog::Search.sources << Photo
#Tog::Search.sources << PhotoSet
#
#Tog::Interface.sections(:user).tabs(:photos).add_item "Your photos", "/user/picto/photos"
#Tog::Interface.sections(:user).tabs(:photos).add "Your sets", "/user/picto/photosets"
#Tog::Interface.sections(:user).tabs(:photos) << "Your sets", "/user/picto/photosets"


