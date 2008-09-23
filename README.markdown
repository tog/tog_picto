Picto
=====

Picto is a plugin for photo management and sharing between users of your social network.

Included functionality
----------------------

* Photos grouped in photosets
* Photoset-defined privacy
* Multiple sized for each photos
* Comentable, rateable and taggable photos and photosets

Resources
=========

Plugin requirements
-------------------


In case you haven't installed any of them previously you'll need the following plugins:

* [acts\_as\_commentable](http://github.com/tog/tog/wikis/3rd-party-plugins-acts_as_commentable)
* [seo\_urls](http://github.com/tog/tog/wikis/3rd-party-plugins-seo_urls)
* [acts\_as\_taggable\_on\_steroids](http://github.com/tog/tog/wikis/3rd-party-plugins-acts_as_taggable_on_steroids)
* [acts\_as\_list](http://github.com/tog/tog/wikis/3rd-party-plugins-acts_as_list)

Follow each link above for a short installation guide incase you have to install them.			

	

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

[http://github.com/tog/tog_picto](http://github.com/tog/tog_picto)

[http://github.com/tog/tog_picto/wikis](http://github.com/tog/tog_picto/wikis)


Copyright (c) 2008 Keras Software Development, released under the MIT license