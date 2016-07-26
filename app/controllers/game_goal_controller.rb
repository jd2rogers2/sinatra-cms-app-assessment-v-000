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
      if params[:game_date][:year].to_s.match(/\b\d{4}\b/) && params[:game_date][:month].to_s.match(/\b\d{1,2}\b/) && params[:game_date][:day].to_s.match(/\b\d{1,2}\b/)
        @player = Player.find_by_id(session[:id])
        @time = Time.new(params[:game_date][:year].to_i, params[:game_date][:month].to_i, params[:game_date][:day].to_i)
        @game = Game.create(datetime: @time)
        @game.teams << Team.find_by(name: params[:home_team])
        @game.teams << Team.find_by(name: params[:away_team])
        @player.games << @game
        erb :'/game_and_goal/add_goals'
      else
        flash[:message] = "game date must be numbers in dd/mm/yyyy format"
        redirect '/game/new'
      end
    else
      redirect '/'
    end
  end

  post '/game/:date/show' do
    binding.pry
    if is_logged_in?
      @game = Game.find_by(datetime: params[:date])
      @game.teams[0].players.each do |x|
        if params.has_key?("#{x.username}_quantity")
          number = params["#{x.username}_quantity"].to_i
          #if number == 0 
            # if !params["#{x.username}_quantity"].match(/\d{1,2}/)
              # flash message and redirect back, else proceed
          minutes_array = params["#{x.username}_minutes"][0].split(", ")
          # minutes_array.each do |x|
          #   if !x.match(/\d{1,2}/)
          #     flash message redirect back, else proceed
          counter = 0
          number.times do
            @goal = Goal.create(minute: minutes_array[counter])
            counter += 1
            @goal.game = @game
            @game.goals << @goal
            @player = Player.find_by(username: "#{x.username}")
            @goal.player = @player
            @player.goals << @goal
            @team = @player.team
            @goal.team = @team
            @team.goals << @goal
          end
        end
      end

      @game.teams[1].players.each do |y|
        if params.has_key?("#{y.username}_quantity")
          number = params["#{y.username}_quantity"].to_i
          minutes_array = params["#{y.username}_minutes"][0].split(", ")
          counter = 0
          number.times do
            @goal = Goal.create(minute: minutes_array[counter])
            counter += 1
            @goal.game = @game
            @game.goals << @goal
            @player = Player.find_by(username: "#{y.username}")
            @goal.player = @player
            @player.goals << @goal
            @team = @player.team
            @goal.team = @team
            @team.goals << @goal
          end
        end
      end
      erb :'/game/show'
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