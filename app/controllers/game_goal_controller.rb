class GameGoalController < ApplicationController

  get '/game/new' do
    if is_logged_in?
      @player = Player.find_by_id(session[:id])
      erb :'/game_and_goal/new_game'
    else
      redirect '/'
    end
  end

  post '/game/:date/add_goals' do
    if is_logged_in?
      if !params[:game_date].to_s.match(/\b\d{4}\b/)
        flash[:message] = "game date must be in yyyy format"
        redirect '/game/new'
      elsif params[:home_team] == params[:away_team]
        flash[:message] = "home and away teams must be different"
        redirect '/game/new'
      else #if home and away aren't the same and 4 numeral date format == true
        @player = Player.find_by_id(session[:id])
        @game = Game.create(date: params[:game_date].to_i)
        @game.teams << Team.find_by(name: params[:home_team])
        @game.teams << Team.find_by(name: params[:away_team])
        @player.games << @game
        erb :'/game_and_goal/add_goals'
      end
    else
      redirect '/'
    end
  end

  post '/game/:date/show' do
    #left off here trying to make goal minutes be entered in correct format
    #currently redirecting to the wrong place and not adding goals
    if is_logged_in?
      @game = Game.find_by(date: params[:date])
      if params[:home_goal_minutes].to_s.match(/\b\d{0,2}\b/) && params[:away_goal_minutes].to_s.match(/\b\d{0,2}\b/)# two numbers
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
        redirect "/game/#{@game.date}/show"
      else
        flash[:message] = "input error, time of goal must be in mm format"
        @player = Player.find_by_id(session[:id])
        erb :'/game_and_goal/add_goals'
      end
    else
      redirect '/'
    end
  end

  get '/game/:date/show' do
    if is_logged_in?
      @player = Player.find_by_id(session[:id])
      @game = Game.find_by(date: params[:date])
      erb :'/game/show'
    else
      redirect '/'
    end
  end
end