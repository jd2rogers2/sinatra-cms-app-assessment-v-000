class GameGoalController < ApplicationController

  get '/game/new' do
    erb :'/game_and_goal/new_game'
  end

  post '/game/:date/add_goals' do
    @game = Game.create(params[:date])
    @game.teams << Team.find_by(name: params[:home_team])
    @game.teams << Team.find_by(name: params[:haway_team])
    erb :'/game_and_goal/add_goals'
  end

  post '/game/:date/show' do
    @game = Game.find_by(date: params[:date])
    @game.goals << params[:goals]
    redirect "/game/#{@game.date}/show"
  end

  get '/game/:date/show' do
    @game = Game.find_by(date: params[:date])
    erb :'/game/show'
  end
end