# ---- requirements
require 'rubygems'
require 'spec'

$LOAD_PATH << File.expand_path("../lib", File.dirname(__FILE__))


# ---- Prepare models
require 'active_record'

RAILS_ENV = "test"
ActiveRecord::Base.establish_connection({
  :adapter => "sqlite3",
  :database => ":memory:",
})

# ---- setup environment/plugin
require File.expand_path("../init", File.dirname(__FILE__))
load File.expand_path("setup_test_model.rb", File.dirname(__FILE__))