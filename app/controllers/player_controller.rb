require 'pry'

class PlayerController < ApplicationController
  
  get '/player/:username' do
    if is_logged_in?
      @player = Player.find_by(username: params[:username])
      erb :'/player/index'
    else
      erb :index
    end
  end

  post '/login' do
    if is_logged_in?
      @player = Player.find_by(username: params[:username])
      if params[:password] == @player.password
        session[:id] = @player.id
        redirect "/player/#{@player.username}"
      else
        #flash[:message] = "incorrect username or password"
        redirect '/'
      end
    else
      redirect '/'
    end
  end

  post '/signup' do
      @session = session
      @player = Player.create(params)
      @session[:id] = @player.id
      @player.save
      redirect "/player/#{@player.username}"
  end

  get '/logout' do
    session.delete(:id)
    redirect '/'
  end
end