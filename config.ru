require 'bundler'
Bundler.require
require 'json'
require 'sinatra/reloader'

require './app'
run Sinatra::Application
