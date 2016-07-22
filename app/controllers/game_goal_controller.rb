class GameGoalController < ApplicationController

  get '/game/new' do
    erb :'/game_and_goal/new_game'
  end

  post '/game/:date/add_goals' do
    @player = Player.find_by_id(session[:id])
    @game = Game.create(date: params[:game_date].to_i)
    @game.teams << Team.find_by(name: params[:home_team])
    @game.teams << Team.find_by(name: params[:away_team])
    @player.games << @game
    # this is working, when pry is used 
    # @game.teams and @team.games yield each other
    erb :'/game_and_goal/add_goals'
  end

  post '/game/:date/show' do
    @game = Game.find_by(date: params[:date])
    params[:home_goal_minutes].each_with_index do |min, ind|
      @goal = Goal.create(minute: min.to_i)
      @goal.game = @game
      @game.goals << @goal
      @player = Player.find_by(username: params[:home][:goals][ind])
      @goal.player = @player
      @player.goals << @goal
      @team = @player.team
      @goal.team = @team
      @team.goals << @goal
    end
    params[:away_goal_minutes].each_with_index do |min, ind|
      @goal = Goal.create(minute: min.to_i)
      @goal.game = @game
      @game.goals << @goal
      @player = Player.find_by(username: params[:away][:goals][ind])
      @goal.player = @player
      @player.goals << @goal
      @team = @player.team
      @goal.team = @team
      @team.goals << @goal
    end
    # @game.goals << attribution should happen
    # along with team.goals etc
    # but isn't
    redirect "/game/#{@game.date}/show"
  end

  get '/game/:date/show' do
    @player = Player.find_by_id(session[:id])
    @game = Game.find_by(date: params[:date])
    erb :'/game/show'
  end
end