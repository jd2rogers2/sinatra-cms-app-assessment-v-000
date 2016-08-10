class TeamController < ApplicationController

  get '/team/new' do
    if is_logged_in?
      @player = Player.find_by_id(session[:id])
      erb :'/team/new'
    else
      redirect '/'
    end
  end

  get '/team/edit' do
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
      @roster = @team.players
      erb :'/team/index'
    else
      redirect '/'
    end
  end

  post '/team' do
    if is_logged_in?
      if params.has_key?("existing_team_name") && params[:new_team_name] == ""
        @player = Player.find_by_id(session[:id])
        @team = Team.find_by(name: params[:existing_team_name])
        @player.team = @team
        @team.players << @player
        @player.save
        @team.save
        redirect "/team/#{@team.name}"
      elsif params[:new_team_name] != "" && !params.has_key?("existing_team_name")
        if Team.find_by(name: params[:new_team_name])
          flash[:message] = "team name already exists in database"
          redirect '/team/new'
        else
          @player = Player.find_by_id(session[:id])
          @team = Team.create(name: params[:new_team_name])
          @player.team = @team
          @team.players << @player
          @player.save
          @team.save
          redirect "/team/#{@team.name}"
        end
      end
    else
      redirect '/'
    end
  end
end