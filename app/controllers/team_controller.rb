class TeamController < ApplicationController

  get '/team' do
    @player = Player.find_by_id(session[:id])
    erb :'/team/index'
  end

  get '/team/new' do
    @player = Player.find_by_id(session[:id])
    erb :'/team/new'
  end

  post '/team' do
    @player = Player.find_by_id(session[:id])
    @team = Team.find_or_create_by(name: params[:name])
    @player.team = @team
    @player.save
    @team.save
    redirect '/team'
  end
end