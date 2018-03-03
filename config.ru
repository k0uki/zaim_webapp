require 'bundler'
Bundler.require
require 'json'
require 'sinatra/reloader'
require 'sinatra/config_file'

require './app'
run Sinatra::Application
