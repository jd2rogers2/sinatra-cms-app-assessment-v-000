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
      if !Team.find_by(name: params[:name])
        @player = Player.find_by_id(session[:id])
        @team = Team.create(name: params[:name])
        @player.team = @team
        @team.players << @player
        @player.save
        @team.save
        redirect "/team/#{@team.name}"
      else #if team name is already in databse
        flash[:message] = "team name already exists in database"
        redirect '/team/new'
      end
    else
      redirect '/'
    end
  end
end