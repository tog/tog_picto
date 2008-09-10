Picto
=====

Picto is a plugin for photo management and sharing between users of your social network.


Resources
=========

Plugin requirements
-------------------

In case you haven't installed any of them previously you'll need the following plugins:

h3. acts_as_commentable

This is a requirement for tog, so you should have already installed it!.


h3. acts_as_taggable_on_steroids

For those of you impatient:
		
# install plugin:   
     
<pre>
ruby script/plugin install http://svn.viney.net.nz/things/rails/plugins/acts_as_taggable_on_steroids
</pre>		
				
# generate migration:   
 
<pre>				
ruby script/generate acts_as_taggable_migration
</pre>			

more: "http://svn.viney.net.nz/things/rails/plugins/acts_as_taggable_on_steroids/README":http://svn.viney.net.nz/things/rails/plugins/acts_as_taggable_on_steroids/README
	
	
h3. rateableplugin

For the impatients:

# install plugin:   
     
<pre>
ruby script/plugin install svn://rubyforge.org/var/svn/rateableplugin/trunk
</pre>		
				
# generate migration:   
 
<pre>				
ruby script/generate add_ratings
</pre>			

<pre>
class AddRatings < ActiveRecord::Migration
	def self.up
    create_table :ratings do |t|
            t.column :rating, :integer    # You can add a default value here if you wish
            t.column :rateable_id :integer, :null => false
            t.column :rateable_type, :string, :null => false
    end
    add_index :ratings, [:rateable_id, :rating]    # Not required, but should help more than it hurts
	end

	def self.down
    drop_table :ratings
	end
end
</pre>

more: "http://rateableplugin.rubyforge.org/":http://rateableplugin.rubyforge.org/

				
h3. acts_as_list

<pre>
ruby script/plugin install git://github.com/rails/acts_as_list.git
</pre>	

more: "http://github.com/rails/acts_as_list/tree/master/README":http://github.com/rails/acts_as_list/tree/master/README
			

Install
-------

* Install plugin form source:

<pre>
ruby script/plugin install git@github.com:tog/tog_pìcto.git
</pre>

* Generate installation migration:

<pre>
ruby script/generate migration install_picto
</pre>

	  with the following content:

<pre>
class InstallPicto < ActiveRecord::Migration
  def self.up
    migrate_plugin "tog_picto", 6
  end

  def self.down
    migrate_plugin "tog_picto", 0
  end
end
</pre>

* Add picto's routes to your application's config/routes.rb

<pre>
map.routes_from_plugin 'tog_picto'
</pre> 

* And finally...

<pre> 
rake db:migrate
</pre> 

More
-------

"https://github.com/tog/tog_picto":https://github.com/tog/tog_picto

"https://github.com/tog/tog_picto/wikis":https://github.com/tog/tog_picto/wikis


Copyright (c) 2008 Keras Software Development, released under the MIT license