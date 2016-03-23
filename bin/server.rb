#!/usr/bin/ruby
## server.rb - sinatra routes to be used for testing

require 'json'
require 'sinatra'

# return a list of all implemented methods
get '/meta' do
  routes = Array.new

  Sinatra::Application.routes.each_pair do |request_type, paths|
    next if request_type.eql?('HEAD')
    paths.each do |route|
      routes << route.first.to_s.gsub(/\W/, '').sub(/^mixA/, '').sub(/z$/, '')
    end
  end
  routes.delete(__method__.to_s.split('/').last)
  routes.to_json
end

get '/characters' do
  rand(97 .. 123).chr
end

get '/numbers' do
  rand(100)
end

get '/stringy_numbers' do
  sprintf("'%d'", rand(100))
end

get '/spaces_then_numbers' do
  sprintf('%s %d', ' ' * 5, rand(100))
end

get '/tabs_then_numbers' do
  sprintf('%s %d', "\t" * 2, rand(100))
end

get '/symbol' do
  rand(123 .. 155).chr
end

get '/letters_then_numbers' do
  rand(97 .. 123).chr
end

get '/empty_string' do
  nil
end

# TODO something nerdier
get '/unicode' do
  '他'
end