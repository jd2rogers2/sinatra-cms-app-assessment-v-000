rooney = Player.create(username: "Rooney", email: "player1@email.com", password: "player1")
messi = Player.create(username: "Messi", email: "player2@email.com", password: "player2")
bale = Player.create(username: "Bale", email: "player3@email.com", password: "player3")
ozil = Player.create(username: "Ozil", email: "player4@email.com", password: "player4")
ronaldo = Player.create(username: "Ronaldo", email: "player5@email.com", password: "player5")
pogba = Player.create(username: "Pogba", email: "player6@email.com", password: "player6")
iniesta = Player.create(username: "Iniesta", email: "player7@email.com", password: "player7")
gg = Player.create(username: "Buffon", email: "player8@email.com", password: "player8")
kane = Player.create(username: "Kane", email: "player9@email.com", password: "player9")

real = Team.create(name: "Real Madrid")
manu = Team.create(name: "Man u")
barca = Team.create(name: "Barca")
bayern = Team.create(name: "Bayern")
spurs = Team.create(name: "Tottenham")
arsenal = Team.create(name: "Arsenal")
juve = Team.create(name: "Juventus")

rooney.team = manu
messi.team = barca
bale.team = real
ozil.team = arsenal
ronaldo.team = real
pogba.team = juve
iniesta.team = barca
gg.team = juve
kane.team = spurs

spurs.players << kane
real.players << bale
real.players << ronaldo
manu.players << rooney
arsenal.players << ozil
barca.players << messi
barca.players << iniesta
juve.players << gg
juve.players << pogba

# player1 = Player.create(username: "james", email: "james@james.com", password: "pass")
# player2 = Player.create(username: "genesis", email: "genesis@g.com", password: "word")
# player3 = Player.create(username: "player_3", email: "three@cchs.com", password: "third")
# player4 = Player.create(username: "player_4", email: "four@cchs.com", password: "fourth")

# bhs = Team.create(name: "bhs")
# cchs = Team.create(name: "cchs")

# time1 = Time.new(2016, 7, 25)
# time2 = Time.new(2015, 6, 24)
# game1 = Game.create(datetime: time1)
# game2 = Game.create(datetime: time2)

# goal1 = Goal.create(minute: 7, game_id: 1, player_id: 1, team_id: 1)
# goal2 = Goal.create(minute: 47, game_id: 1, player_id: 4, team_id: 2)
# goal3 = Goal.create(minute: 86, game_id: 1, player_id: 2, team_id: 1)

# goal4 = Goal.create(minute: 20, game_id: 2, player_id: 2, team_id: 1)
# goal5 = Goal.create(minute: 22, game_id: 2, player_id: 3, team_id: 2)

# player1.team = bhs
# player2.team = bhs
# player3.team = cchs
# player4.team = cchs

# player1.goals << goal1
# player2.goals << goal3
# player3.goals << goal5
# player4.goals << goal2
# player2.goals << goal4

# player1.games << game1
# player2.games << game1
# player3.games << game1
# player4.games << game1
# player1.games << game2
# player2.games << game2
# player3.games << game2
# player4.games << game2

# bhs.players << player1
# bhs.players << player2
# cchs.players << player3
# cchs.players << player4

# game1.teams << bhs
# game1.teams << cchs
# game2.teams << bhs
# game2.teams << cchs