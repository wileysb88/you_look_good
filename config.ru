# require 'sinatra/base'
ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

DB = if ENV['RACK_ENV'] == 'production'
  Sequel.connect(ENV['DATABASE_URL'])
else
  Sequel.sqlite('development.sqlite')
end

require './models/user'
require './models/post'


require './controllers/application'
require './controllers/users'
require './controllers/posts'




map('/') { run ApplicationController }
map('/users') { run UsersController }
