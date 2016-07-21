require 'pry'

class PlayerController < ApplicationController
  use Rack::Flash
  
  get '/player/:username' do
    if is_logged_in?
      @player = Player.find_by(username: params[:username])
      if !@player.team
        flash[:message] = "First you'll need to join or add a team"
      else
        flash[:message] = "Would you like to add a game or a goal?"
      end
      erb :'/player/index'
    else
      erb :index
    end
  end

  post '/login' do
    @player = Player.find_by(username: params[:username])
    session[:id] = @player.id
    redirect "/player/#{@player.username}"
  end

  post '/signup' do
    @session = session
    @player = Player.create(params)
    @session[:id] = @player.id
    @player.save
    binding.pry
    redirect "/player/#{@player.username}"
  end
end