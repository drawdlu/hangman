# frozen_string_literal: true

require_relative 'lib/game'

def yes?(prompt)
  puts prompt
  valid_reponse = %w[yes no].freeze
  response = choice(valid_reponse, ' or')
  puts
  response == 'yes'
end

def choice(valid_response, separator)
  loop do
    print_choices(valid_response, separator)
    choice = gets.chomp.downcase
    valid_response.each do |value|
      return value if value.slice(0..(choice.length - 1)) == choice
    end
  end
end

def print_choices(choices, separator)
  choices.each do |choice|
    if choice == choices.last
      print choice.capitalize
    else
      print "#{choice.capitalize}#{separator} "
    end
  end
  print ': '
end

def choose_file
  start = 'assets/saves/'.length
  last = '.yaml'.length + 1
  files = Dir['assets/saves/*'].map { |name| name.slice(start..-last) }
  print 'Choose a file to load -> '
  choice(files, ',')
end

def load_save(file_name)
  YAML.load_file(
    "assets/saves/#{file_name}.yaml",
    permitted_classes: [Hangman::Game, Hangman::Player],
    aliases: true
  )
end

def start_game
  load = Dir.exist?('assets/saves') ? yes?("\nDo you want to load a game?") : false

  if load
    file_name = choose_file
    game = load_save(file_name)
  else
    game = Hangman::Game.new
    game.new_word
  end

  game.play
end

loop do
  start_game
  break unless yes?("\nWould you like to play again?")
end
