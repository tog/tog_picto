ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")
require 'test_help'
require 'test/unit'
require "shoulda"

require 'factory_girl'
require File.expand_path(File.dirname(__FILE__) + '/factories')
