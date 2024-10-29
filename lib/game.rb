# frozen_string_literal: true

require_relative 'player'

# Hangmane game on terminal
module Hangman
  # Handles game loop
  class Game
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
        guess = @guesser.guess_or_save
        return save if guess == 'save'

        record_guess(guess)
        print_hint
        return puts 'You have guessed the word' if @right_guess.sort ==
                                                   @letters.sort
      end
      puts "You have failed to guess the word: \"#{@word}\""
    end

    def new_word
      words = File.read('assets/google-10000-english-no-swears.txt').split
      @word = words.sample until @word.length < 13 && @word.length > 4
      @letters = @word.split('').uniq
    end

    private

    def record_guess(letter)
      if @letters.include?(letter)
        @right_guess << letter
      else
        @wrong_guesses -= 1
        @wrong_guess << letter
      end
    end

    def print_hint
      print_word
      print_guesses('Wrong', @wrong_guess)
      print_guesses('Right', @right_guess)
      print "You have #{@wrong_guesses} wrong guesses left\n\n"
    end

    def print_word
      puts
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
      puts 'Successfully saved the game'
    end
  end
end
