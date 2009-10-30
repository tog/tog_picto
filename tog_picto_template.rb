plugin 'acts_as_list', :git => "git://github.com/rails/acts_as_list.git"

plugin 'tog_picto', :git => "git://github.com/tog/tog_picto.git"

route "map.routes_from_plugin 'tog_picto'"

generate "update_tog_migration"

rake "db:migrate"
rake "tog:plugins:copy_resources PLUGIN=tog_picto"