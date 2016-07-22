class TeamController < ApplicationController

  get '/team/new' do
    @player = Player.find_by_id(session[:id])
    erb :'/team/new'
  end

  get '/team/:name' do
    @player = Player.find_by_id(session[:id])
    @team = Team.find_by(name: params[:name])
    erb :'/team/index'
  end

  post '/team' do
    @player = Player.find_by_id(session[:id])
    @team = Team.find_or_create_by(name: params[:name])
    @player.team = @team
    @player.save
    @team.save
    redirect "/team/#{@team.name}"
  end
end