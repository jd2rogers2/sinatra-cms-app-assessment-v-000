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
      @player = Player.find_by_id(session[:id])
      redirect "/player/#{@player.username}"
    else # not logged in
      if !Player.find_by(username: params[:username])
        flash[:message] = "username not found"
        redirect '/'
      else # do find username
        @player = Player.find_by(username: params[:username])
        if @player.authenticate(params[:password])
          session[:id] = @player.id
          redirect "/player/#{@player.username}"
        else # incorrect password
          flash[:message] = "incorrect password"
          redirect '/'
        end
      end
    end
  end

  post '/signup' do
    #if email or username already exists
    if Player.find_by(username: params[:username])
      flash[:message] = "username already exists"
      erb :index
    elsif Player.find_by(email: params[:email])
      flash[:message] = "account already associated with this email"
      erb :index
    else
      @player = Player.create(params)
      session[:id] = @player.id
      @player.save
      redirect "/player/#{@player.username}"
    end
  end

  get '/logout' do
    session.delete(:id)
    redirect '/'
  end
end