# frozen_string_literal: true

require_relative 'player'

# Hangmane game on terminal
module Hangman
  # Handles game loop
  class Game
    attr_reader :wrong_guess, :right_guess, :guesser

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
        guess = @guesser.guess
        record_guess(guess)
        print_hint
        if @right_guess.sort == @letters.sort
          puts 'You have guessed the word'
          return
        end
      end
      puts 'You have failed to guess the word'
    end

    def new_word
      words = File.read('assets/google-10000-english-no-swears.txt').split
      @word = words.sample until @word.length < 13 && @word.length > 4
      @letters = @word.split('').uniq
    end

    def record_guess(letter)
      if @letters.include?(letter)
        @right_guess << letter
      else
        @wrong_guesses -= 1
        @wrong_guess << letter
      end
    end

    def print_hint
      puts
      print_word
      puts
      print_guesses('Wrong', @wrong_guess)
      print_guesses('Right', @right_guess)
      puts "You have #{@wrong_guesses} wrong guesses left"
      puts
    end

    def print_word
      @word.split('').each do |letter|
        if @right_guess.include?(letter)
          print "#{letter} "
        else
          print '_ '
        end
      end
      puts
    end

    def print_guesses(category, array)
      print "#{category}: "
      array.each { |letter| print "#{letter} " }
      puts
    end
  end
end
