# Write your code below game_hash
require 'pry'

def game_hash
  {
    home: {
      team_name: "Brooklyn Nets",
      colors: ["Black", "White"],
      players: [
        {
          player_name: "Alan Anderson",
          number: 0,
          shoe: 16,
          points: 22,
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1
        },
        {
          player_name: "Reggie Evans",
          number: 30,
          shoe: 14,
          points: 12,
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks: 7
        },
        {
          player_name: "Brook Lopez",
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15
        },
        {
          player_name: "Mason Plumlee",
          number: 1,
          shoe: 19,
          points: 26,
          rebounds: 11,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks: 5
        },
        {
          player_name: "Jason Terry",
          number: 31,
          shoe: 15,
          points: 19,
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks: 1
        }
      ]
    },
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise", "Purple"],
      players: [
        {
          player_name: "Jeff Adrien",
          number: 4,
          shoe: 18,
          points: 10,
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2
        },
        {
          player_name: "Bismack Biyombo",
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 22,
          blocks: 15,
          slam_dunks: 10
        },
        {
          player_name: "DeSagna Diop",
          number: 2,
          shoe: 14,
          points: 24,
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks: 5
        },
        {
          player_name: "Ben Gordon",
          number: 8,
          shoe: 15,
          points: 33,
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks: 0
        },
        {
          player_name: "Kemba Walker",
          number: 33,
          shoe: 15,
          points: 6,
          rebounds: 12,
          assists: 12,
          steals: 7,
          blocks: 5,
          slam_dunks: 12
        }
      ]
    }
  }
end

# Write code here
def num_points_scored(player_name)
  game_hash.reduce(nil){ |m1, (away_or_home, team)|
    team[:players].reduce(m1) { |m2, player|
      if player[:player_name]==player_name
        return player[:points]
      end
      m2
    }
    m1
  }
  return nil
end

def shoe_size(player_name)
  game_hash.reduce(nil){ |m1, (away_or_home, team)|
    team[:players].reduce(m1) { |m2, player|
      if player[:player_name]==player_name
        return player[:shoe]
      end
      m2
    }
    m1
  }
  return nil
end

def team_colors(team_name)
  game_hash.reduce(nil){ |memo, (away_or_home, team)|
    if team[:team_name]==team_name
      return team[:colors]
    end
    memo
  }
  return nil
end

def team_names
  game_hash.reduce([]){ |memo, (away_or_home, team)|
    memo << team[:team_name]
  }
end

def player_numbers(team_name)
  game_hash.reduce([]){ |outer_memo, (away_or_home, team)|
    if team[:team_name]==team_name
      team[:players].reduce(outer_memo){ |inner_memo, player_hash|
        inner_memo << player_hash[:number]
      }
    end
    outer_memo
  }
end

def player_stats(player_name)
  game_hash.reduce(nil){ |m1, (away_or_home, team)|
    team[:players].reduce(m1) { |m2, player|
      if player[:player_name]==player_name
        player.delete(:name)
        return player
      end
    }
  }
  nil
end

def big_shoe_rebounds
  largest_shoe_size=0
  largest_shoed_player=game_hash.reduce(nil){ |m1, (away_or_home, team)|
    m1=team[:players].reduce(m1) { |m2, player|
      if player[:shoe]>largest_shoe_size
        largest_shoe_size=player[:shoe]
        m2=player
      end
      m2
    }
  }
  return largest_shoed_player[:rebounds] 
end

def most_points_scored
  high_points=0
  high_scoring_player=game_hash.reduce(nil){ |m1, (away_or_home, team)|
    m1=team[:players].reduce(m1) { |m2, player|
      if player[:points]>high_points
        high_points=player[:points]
        m2=player
      end
      m2
    }
  }
  return high_scoring_player[:player_name] 
end

def tally_total_points(team_hash)
  team_hash[:players].reduce(0){ |memo, player|
    memo+=player[:points]
  }
end

def winning_team
  game_hash_var=game_hash
  home_score=tally_total_points(game_hash_var[:home])
  away_score=tally_total_points(game_hash_var[:away])
  away_score>=home_score ? game_hash_var[:away][:team_name] : game_hash_var[:home][:team_name]
end

def player_with_longest_name
  longest_named_player={:player_name =>""}
  longest_named_player=game_hash.reduce(longest_named_player){ |m1, (away_or_home, team)|
    m1=team[:players].reduce(m1) { |m2, player|
      if player[:player_name].length>m2[:player_name].length
        m2=player
      end
      m2
    }
  }
  return longest_named_player[:player_name] 
end

def most_steals
  high_steals=0
  high_stealing_player=game_hash.reduce(nil){ |m1, (away_or_home, team)|
    m1=team[:players].reduce(m1) { |m2, player|
      if player[:steals]>high_steals
        high_steals=player[:steals]
        m2=player
      end
      m2
    }
  }
  return high_stealing_player[:player_name] 
end

def long_name_steals_a_ton?
  most_steals==longest_named_player
end

p long_name_steals_a_ton?