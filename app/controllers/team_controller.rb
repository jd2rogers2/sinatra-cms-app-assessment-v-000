class TeamController < ApplicationController

  get '/team/new' do
    if is_logged_in?
      @player = Player.find_by_id(session[:id])
      erb :'/team/new'
    else
      redirect '/'
    end
  end

  get '/team/:name' do
    if is_logged_in?
      @player = Player.find_by_id(session[:id])
      @team = Team.find_by(name: params[:name])
      erb :'/team/index'
    else
      redirect '/'
    end
  end

  post '/team' do
    if is_logged_in?
      @player = Player.find_by_id(session[:id])
      @team = Team.find_or_create_by(name: params[:name])
      @player.team = @team
      @team.players << @player
      @player.save
      @team.save
      redirect "/team/#{@team.name}"
    else
      redirect '/'
    end
  end
end