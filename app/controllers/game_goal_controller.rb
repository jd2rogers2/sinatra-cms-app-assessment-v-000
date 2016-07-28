class GameGoalController < ApplicationController

  get '/game/new' do
    if is_logged_in?
      @player = Player.find_by_id(session[:id])
      erb :'/game_and_goal/new_game'
    else
      redirect '/'
    end
  end

  get '/game/:date/add_goals' do
    @player = Player.find_by_id(session[:id])
    @game = Game.find_by(datetime: params[:date])
    erb :'/game_and_goal/add_goals'
  end

  post '/game/:date/add_goals' do
    if is_logged_in?
      if params[:game_date][:year].to_s.match(/\b\d{4}\b/) && params[:game_date][:month].to_s.match(/\b\d{1,2}\b/) && params[:game_date][:day].to_s.match(/\b\d{1,2}\b/)
        @player = Player.find_by_id(session[:id])
        @time = Time.new(params[:game_date][:year].to_i, params[:game_date][:month].to_i, params[:game_date][:day].to_i)
        @game = Game.create(datetime: @time)
        @game.teams << Team.find_by(name: params[:home_team])
        @game.teams << Team.find_by(name: params[:away_team])
        @game.players << Team.find_by(name: params[:home_team]).players
        @game.players << Team.find_by(name: params[:away_team]).players
        redirect "/game/#{@game.datetime}/add_goals"
      else
        flash[:message] = "game date must be numbers in yyyy/mm/dd format"
        redirect '/game/new'
      end
    else
      redirect '/'
    end
  end

  post '/game/:date/show' do
    if is_logged_in?
      @game = Game.find_by(datetime: params[:date])
      if @game.goals.empty? == false # if goals is not empty then we're editing...
        # not creating so delete all old goals + relationships then create new ones
        @game.goals.each do |z|
          z.player.goals.delete(z)
          z.team.goals.delete(z)
          z.destroy
        end
        @game.goals.clear
      end
      @game.players.each do |x|
        if params.has_key?("#{x.username}_quantity")
          number = params["#{x.username}_quantity"].to_i
          if params["#{x.username}_quantity"].match(/\d{1,2}/) || params["#{x.username}_quantity"].match(/\A\z/)
          else
            flash[:message] = "goal quantity entry must only be digits"
            redirect "/game/#{@game.datetime}/add_goals"
          end
          minutes_array = params["#{x.username}_minutes"][0].split(", ")
          minutes_array.each do |element|
            if !element.scan(/\D/).empty?
              flash[:message] = "goal time(s) must be digits separated by ', '"
              redirect "/game/#{@game.datetime}/add_goals"
            end
          end
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
      @player = Player.find_by_id(session[:id])
      erb :'/game/show'
    else
      redirect '/'
    end
  end

  get '/game/:date/show' do
    if is_logged_in?
      @player = Player.find_by_id(session[:id])
      @game = Game.find_by(datetime: params[:date])
      erb :'/game/show'
    else
      redirect '/'
    end
  end

  post '/game/:date/edit' do
    @game = Game.find_by(datetime: params[:date])
    @player = Player.find_by_id(session[:id])
    if params[:game_date][:year].to_s.match(/\b\d{4}\b/) && params[:game_date][:month].to_s.match(/\b\d{1,2}\b/) && params[:game_date][:day].to_s.match(/\b\d{1,2}\b/)
      @time = Time.new(params[:game_date][:year].to_i, params[:game_date][:month].to_i, params[:game_date][:day].to_i)
      @game.datetime = @time
      @game.teams.clear
      @game.teams << Team.find_by(name: params[:away_team])
      @game.teams << Team.find_by(name: @player.team.name)
      @game.players.clear
      @game.players << Team.find_by(name: params[:away_team]).players
      @game.players << Team.find_by(name: @player.team.name).players
      @game.save
      @game.players.each do |a|
        a.games.each do |z|
          if z.id == @game.id
            z.datetime = @time
          end
        end
        a.save
      end
      @game.teams.each do |x|
        x.games.each do |y|
          if y.id == @game.id
            y.datetime = @time
          end
        end
        x.save
      end
      redirect "/game/#{@game.datetime}/edit_goals"
    else
      flash[:message] = "game date must be numbers in yyyy/mm/dd format"
      redirect "/game/#{@game.datetime}/edit"
    end
  end

  get '/game/:date/edit' do
    if is_logged_in?
      @game = Game.find_by(datetime: params[:date])
      @player = Player.find_by_id(session[:id])
      erb :'/game/edit_game'
    else
      redirect '/'
    end
  end

  get '/game/:date/edit_goals' do
    if is_logged_in?
      @game = Game.find_by(datetime: params[:date])
      @player = Player.find_by_id(session[:id])
      erb :'/game/edit_goals'
    else
      redirect '/'
    end 
  end
end