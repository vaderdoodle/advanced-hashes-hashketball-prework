#require "pry"

def game_hash
  infohash = {
    :home => {
      :team_name => "Brooklyn Nets", 
      :colors => ["Black", "White"],
      :players => {
        "Alan Anderson" => {
            :number => 0,
            :shoe => 16,
            :points => 22,
            :rebounds => 12,
            :assists => 12,
            :steals => 3,
            :blocks => 1,
            :slam_dunks => 1
        },
        "Reggie Evans" => {
            :number => 30,
            :shoe => 14,
            :points => 12,
            :rebounds => 12,
            :assists => 12,
            :steals => 12,
            :blocks => 12,
            :slam_dunks => 7
        },
        "Brook Lopez" => {
            :number => 11,
            :shoe => 17,
            :points => 17,
            :rebounds => 19,
            :assists => 10,
            :steals => 3,
            :blocks => 1,
            :slam_dunks => 15
        },
        "Mason Plumlee" => {
            :number => 1,
            :shoe => 19,
            :points => 26,
            :rebounds => 11,
            :assists => 6,
            :steals => 3,
            :blocks => 8,
            :slam_dunks => 5
        },
        "Jason Terry" => {  
            :number => 31,
            :shoe => 15,
            :points => 19,
            :rebounds => 2,
            :assists => 2,
            :steals => 4,
            :blocks => 11,
            :slam_dunks => 1
        }
      }  
    }, 
    :away => {
      :team_name => "Charlotte Hornets", 
      :colors => ["Turquoise", "Purple"],
      :players => {
        "Jeff Adrien" => {
            :number => 4,
            :shoe => 18,
            :points => 10,
            :rebounds => 1,
            :assists => 1,
            :steals => 2,
            :blocks => 7,
            :slam_dunks => 2
        },
        "Bismack Biyombo" => {
            :number => 0,
            :shoe => 16,
            :points => 12,
            :rebounds => 4,
            :assists => 7,
            :steals => 22,
            :blocks => 15,
            :slam_dunks => 10
        },
        "DeSagna Diop" => {
            :number => 2,
            :shoe => 14,
            :points => 24,
            :rebounds => 12,
            :assists =>12,
            :steals => 4,
            :blocks => 5,
            :slam_dunks => 5
        },
        "Ben Gordon" => {
            :number => 8,
            :shoe => 15,
            :points => 33,
            :rebounds => 3,
            :assists => 2,
            :steals => 1,
            :blocks => 1,
            :slam_dunks => 0
        },
        "Kemba Walker" => {  
            :number => 33,
            :shoe => 15,
            :points => 6,
            :rebounds => 12,
            :assists => 12,
            :steals => 7,
            :blocks => 5,
            :slam_dunks => 12
        }
      }  
    }
  }
end

def num_points_scored(player_name)
  #Hash -> Location (Home or Away) -> Team Data (name, colors, players)
  game_hash.each do |location, team_data|
      #Players -> Name and Data -> Check for player name match
      team_data[:players].each do |name, data|
        if name == player_name
          return data[:points] #return the value of points key
        end
      end
  end
end

def shoe_size(player_name)
  game_hash.each do |location, team_data|
    team_data[:players].each do |name, data|
      if name == player_name
        return data[:shoe]
      end
    end
  end
end

def team_colors(team)
  game_hash.each do |location, team_data|
    if team_data[:team_name] == team
      return team_data[:colors]
    end
  end
end

def team_names #long winded approach, def could use refactoring
  team_array = []
  game_hash.each do |location, team_data|
    team_data.each do |team_name, values|
      if !team_array.include? (team_data[:team_name])
        team_array.push(team_data[:team_name])
      end
    end
  end
  return team_array
end

def player_numbers(name_of_team)

  numbers = []
  game_hash.each do |team, chars|
    if name_of_team == game_hash[team][:team_name]
      game_hash[team][:players].each do |name, stats|
        numbers.push(stats[:number])
      end
    end
  end
  return numbers
end

def player_stats(players_name)
  game_hash.each do |location, team_data|
    team_data[:players].each do |name, player_attributes|
      if name == players_name
        return player_attributes
      end
    end
  end
end

def big_shoe_rebounds
   shoe_size = 0
   rebound = 0
   game_hash.each do |location, team_data|
      team_data[:players].each do |player_name, value|
         if value[:shoe] > shoe_size
            shoe_size = value[:shoe]
            rebound = value[:rebounds]
         end
      end
   end
   rebound
end

def most_points_scored
   most_point = 0
   player = nil
   game_hash.each do |location, team_data|
      team_data[:players].each do |player_name, value|
         if value[:points] > most_point
            most_point = value[:points]
            player = player_name
         end
     end
   end
   player
end

def winning_team
  home_team = 0
  away_team = 0
  game_hash[:home][:players].each do |name, value|
    home_team += value[:points]
  end
  game_hash[:away][:players].each do |name, value|
    away_team += value[:points]
  end
  if home_team > away_team
      game_hash[:home][:team_name]
  elsif home_team < away_team
      game_hash[:away][:team_name]
  else
      "It's a tie!"
  end
end

def player_with_longest_name
  length = 0
  name = ""
  game_hash.each do |location, data|
    data[:players].each do |names, other|
      if names.length > length
        length = names.length
        name = names
      end
    end
  end
  return name
end

def long_name_steals_a_ton?
  most_steals = 0
  player_with_most_steals = nil
  
  game_hash.each do |location, team_data|
    team_data[:players].each do |player_name, player_stats|
      if player_stats[:steals] > most_steals
        most_steals = player_stats[:steals]
        player_with_most_steals = player_name
      end
    end
  end
  
  player_with_longest_name() == player_with_most_steals ? true : false
end
