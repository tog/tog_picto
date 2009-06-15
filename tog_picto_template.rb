plugin 'acts_as_list', :git => "git://github.com/rails/acts_as_list.git"

plugin 'tog_picto', :git => "git://github.com/tog/tog_picto.git"

route "map.routes_from_plugin 'tog_picto'"

file "db/migrate/" + Time.now.strftime("%Y%m%d%H%M%S") + "_install_tog_picto.rb",
%q{class InstallTogPicto < ActiveRecord::Migration
    def self.up
      migrate_plugin "tog_picto", 7
    end

    def self.down
      migrate_plugin "tog_picto", 0 
    end
end
}

rake "db:migrate"
rake "tog:plugins:copy_resources PLUGIN=tog_picto"