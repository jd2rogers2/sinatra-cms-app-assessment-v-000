require './config/environment'
require 'sinatra/base'
require 'rack-flash3'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, 'app/views'
  set :public_folder, 'public'
  enable :sessions
  set :session_secret, "arcticmonkeys"
  use Rack::Flash

  get '/' do
    if is_logged_in?
      @player = Player.find_by_id(session[:id])
      redirect "/player/#{@player.username}"
    else
      erb :index
    end
  end

  helpers do
    def is_logged_in?
      session.has_key?(:id) ? true : false
    end

    def current_user
      Player.find_by_id(session[:id])
    end
  end
end