# Learning Objectives
- Review data structures
- Navigate advanced hashes
- Understand Single Responsibility Principle
- Appreciate smaller methods

# Game Hash
- Our goal is to represent a real world object as a data structure
- What is the overall object: A game
- What information/data types do we need to store: location, team_name, colors, players

```ruby
{ home: {
    team_name: "Brooklyn Nets",
    colors: ["Black", "White"],
    players: [
      ...{}
    ]
  },
  away: {
  team_name: "Charlotte Hornets",
  colors: ["Turquoise", "Purple"],
  players: [
    ...{}
  ]
  }
}
```

- What data structure should each player represented by: hash
- What attributes does each player have: player_name, number, shoe, points, rebounds, assists, steals, blocks, slam_dunks
- Wrap it all in a method. How do we return this value from a Ruby method?

# Num Points Scored
- Method takes a name argument and returns a player’s points.
- Use Pry to examine what you are iterating through at each level.

>With hash structures as with APIs, don’t make assumptions about the data you are looking it. You need to get your hands dirty. Would you go to a surgeon who only read a book about surgery? No, you want a surgeon who has poked around in some bodies.

```ruby
def num_points_scored(name)
  game_hash.each do |key, value|
    binding.pry
  end
end
```

- Write your code for the other people who are reading it. Name your block variables descriptively and succinctly.

>Write some messy code and then refactor.

```ruby
def num_points_scored(name)
  result = nil
  game_hash.each do |team_location, team_hash|
    team_hash[:players].each do |player|
      if player[:player_name] == name
        result = player
      end
    end
  end
  result[:points]
end
```

### Breaking Methods Up
- What three things are we doing in this method?
    - Finding all the players
    - Searching for one specific player
    - Returning that player's score

```ruby
def players
  game_hash[:home][:players] + game_hash[:away][:players]
end

def find_player(name)
  players.find {|player| player[:player_name] == name}
end

def num_points_scored(name)
  find_player(name)[:points]
end
```

- Now we might be able to reuse some of this code for other methods
- We can still do better

### Failing Loudly
> Comment out Jeff Adrien's points key and value.
Then run add `puts num_points_scored("Jeff Adrien")` to the file and run the code.
Result is nothing.

- What just happened?
   - We don't know what happened because it failed silently
   - We want to know when it breaks

> Google `Ruby fetch` and read the documentation

- Documentation is your friend
- You will frequently have doubts about what a method returns or if it mutates the original data

 ```ruby
 def players
   home_players = game_hash.fetch(:home).fetch(:players)
   away_players = game_hash.fetch(:away).fetch(:players)
   home_players + away_players
 end

 def find_player(name)
   players.find {|player| player.fetch(:player_name) == name}
 end

 def num_points_scored(name)
   find_player(name).fetch(:points)
 end
 ```

# Shoe Size
- Using what we just learned, how do we construct this method
```ruby
def shoe_size(name)
  find_player(name).fetch(:shoe)
end
```
- That was simple because we already had helper methods in place

# Team Colors
- We have multiple steps again
    - Find a team by name
    - Find that team's colors
- Ideal code looks like find_player
    - let's find a way to make that work for our data

```ruby
def find_team(name)
  teams.find {|team| team.fetch(:team_name) == name}
end
```

- To make this code work, we need to create teams
- What type of data is teams?
    - Teams is an array of hashes
    - Those hashes already exist as the values of our game hash

```ruby
def teams
  game_hash.values
end

def team_colors(name)
  find_team(name).fetch(:colors)
end
```

# Team Names
- We want an array of team names
- We already have an array of team hashes
- What method do we use to take an array and return something different for each element?

```ruby
def team_names
  teams.map{|team| team.fetch(:team_name)}
end
```

# Player Numbers
- Find a team
- Find the players for the team
- Return an array of jersey numbers for the players

```ruby
def player_numbers(name)
  find_team(name).fetch(:players).map{|player| player.fetch(:number)}
end
```

# Player Stats
- Find a player
- Return a hash of player stats
    - Exclude the name

> Take five minutes and rewrite this method with the person sitting next to you. Use the hash documentation to see if there are any helpful hash methods you can use.

```ruby
def player_stats(name)
  find_player(name).reject{|key, value| key == :player_name}
end
```

# Big Shoe Rebounds
- Find the player with the largest shoe size
- Return the rebounds for that player
- How do we find the player with the largest shoe size
- Easiest to let Ruby sort for us
- Check out Ruby `sort` documentation and Google `spaceship operator ruby`

```ruby
def big_shoe_rebounds
  players.sort{|p1, p2| p1.fetch(:shoe) <=> p2.fetch(:shoe)}.last.fetch(:rebounds)
end
```
- Hard for other programmers to read
- How do we break this up

```ruby
def player_biggest_shoes
  players.sort{|p1, p2| p1.fetch(:shoe) <=> p2.fetch(:shoe)}.last
end

def big_shoe_rebounds
  player_biggest_shoes.fetch(:rebounds)
end
```
