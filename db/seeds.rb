player1 = Player.create(username: "james", email: "james@james.com", password: "pass")
player2 = Player.create(username: "genesis", email: "genesis@g.com", password: "word")
player3 = Player.create(username: "player_3", email: "three@cchs.com", password: "third")
player4 = Player.create(username: "player_4", email: "four@cchs.com", password: "fourth")

bhs = Team.create(name: "bhs")
cchs = Team.create(name: "cchs")

time1 = Time.new(2016, 7, 25)
time2 = Time.new(2015, 6, 24)
game1 = Game.create(datetime: time1)
game2 = Game.create(datetime: time2)

goal1 = Goal.create(minute: 7, game_id: 1, player_id: 1, team_id: 1)
goal2 = Goal.create(minute: 47, game_id: 1, player_id: 4, team_id: 2)
goal3 = Goal.create(minute: 86, game_id: 1, player_id: 2, team_id: 1)

goal4 = Goal.create(minute: 20, game_id: 2, player_id: 2, team_id: 1)
goal5 = Goal.create(minute: 22, game_id: 2, player_id: 3, team_id: 2)

player1.team = bhs
player2.team = bhs
player3.team = cchs
player4.team = cchs

player1.goals << goal1
player2.goals << goal3
player3.goals << goal5
player4.goals << goal2
player2.goals << goal4

player1.games << game1
player2.games << game1
player3.games << game1
player4.games << game1
player1.games << game2
player2.games << game2
player3.games << game2
player4.games << game2

bhs.players << player1
bhs.players << player2
cchs.players << player3
cchs.players << player4

game1.teams << bhs
game1.teams << cchs
game2.teams << bhs
game2.teams << cchs