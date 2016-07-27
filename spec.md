# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
   - i have required sinatra as a gem and used its route capabilities as well as many methods it provides
- [x] Use ActiveRecord for storing information in a database
   - see /db folder for database as well as /db/migrate folder with create_table classes. stored via controllers with .create and .save
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
   - 6 models; game, goal, player, team, player_game, and team_game
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
   - game, player, and team all include multiple has many relationships
- [x] Include user accounts
   - to signup, a user must create an account with a username, email, and password. they can then only log in if their username and password match the instance saved in the player table in the database
- [x] Ensure that users can't modify content created by other users
   - if statements around all edit links ensure user can only edit games their team was involved in
- [x] Include user input validations
   - have included if statements (mostly with regex) to ensure the input's format is correct
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
   - if the above stated input format is not correct the route redirects to the same page we were just on however this time a flash message displays the error
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
   - see readme

Confirm
- [x] You have a large number of small Git commits
   - a fair amount i think, not 1 every 3-7 minutes but the right amount for me i'd say
- [x] Your commit messages are meaningful
   - they work for me
- [x] You made the changes in a commit that relate to the commit message
   - commit messages on fleek
- [x] You don't include changes in a commit that aren't related to the commit message
   - commit messages are somewhat general to cover all work submitted, will be more specific going forward
