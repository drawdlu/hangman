# frozen_string_literal: true

require_relative 'player'
require_relative 'hangman'
require 'yaml'

# Hangmane game on terminal
module Hangman
  # Handles game loop
  class Game
    include Hangman
    attr_reader :wrong_guess, :right_guess

    MAX_WRONG_GUESS = 6

    def initialize
      @guesser = Player.new(self)
      @word = ''
      @letters = nil
      @wrong_guess = []
      @right_guess = []
      @wrong_guesses = MAX_WRONG_GUESS
    end

    def play
      while @wrong_guesses.positive?
        print_hint
        guess = @guesser.guess_or_save
        return save if guess == 'save'

        record_guess(guess)
        return puts 'You have guessed the word' if @right_guess.sort ==
                                                   @letters.sort
      end
      player_lost
    end

    def new_word
      words = File.read('assets/google-10000-english-no-swears.txt').split
      @word = words.sample until @word.length < 13 && @word.length > 4
      @letters = @word.split('').uniq
    end

    def print_hint
      print_hangman(@wrong_guesses)
      print_word
      print_guesses('Wrong', @wrong_guess)
      print_guesses('Right', @right_guess)
      print "You have #{@wrong_guesses} wrong guesses left\n\n"
    end

    private

    def player_lost
      print_hangman(@wrong_guesses)
      puts "You have failed to guess the word: \"#{@word}\""
    end

    def record_guess(letter)
      if @letters.include?(letter)
        @right_guess << letter
      else
        @wrong_guesses -= 1
        @wrong_guess << letter
      end
    end

    def print_word
      puts
      print ' '
      @word.split('').each do |letter|
        print @right_guess.include?(letter) ? "#{letter} " : '_ '
      end
      print "\n\n"
    end

    def print_guesses(category, array)
      print "#{category}: "
      array.each { |letter| print "#{letter} " }
      puts
    end

    def save
      file_name = choose_name
      create_save_directory
      save_to_file(file_name)
      puts 'Successfully saved the game'
    end

    def choose_name
      puts
      print 'Type a file name for your save file: '
      gets.chomp
    end

    def create_save_directory
      Dir.mkdir 'assets/saves' unless Dir.exist? 'assets/saves'
    end

    def save_to_file(file_name)
      serialized = YAML.dump self
      file = if File.exist?("assets/saves/#{file_name}.yaml")
               File.open("assets/saves/#{file_name}.yaml", 'w')

             else
               File.new("assets/saves/#{file_name}.yaml", 'w')
             end
      file.write(serialized)
      file.close
    end
  end
end
