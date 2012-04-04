require 'sinatra'
require 'yaml'
require './data'

TRELLO_CONFIG = YAML.load_file("trello.yml")
auth(TRELLO_CONFIG['app_key'], TRELLO_CONFIG['app_secret'], TRELLO_CONFIG['user_token'])

get '/' do
  haml :index
end

get '/:board' do
  data = assigned_to_user_on_board(TRELLO_CONFIG['user'], params[:board])
  haml :board, :locals => { :data => data }, layout => true
end