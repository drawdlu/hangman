# frozen_string_literal: true

require_relative 'player'

# Hangmane game on terminal
module Hangman
  # Handles game loop
  class Game
    attr_reader :wrong_guess, :right_guess, :guesser

    MAX_TURNS = 6

    def initialize
      @guesser = Player.new(self)
      @word = ''
      @letters = nil
      @wrong_guess = []
      @right_guess = []
      @guesses = 0
    end

    def play
      while @guesses < MAX_TURNS
        guess = @guesser.guess
        record_guess(guess)
      end
    end

    def new_word
      words = File.read('assets/google-10000-english-no-swears.txt').split
      @word = words.sample until @word.length < 13 && @word.length > 4
      @letters = @word.split('').uniq
      p @letters
    end

    def record_guess(letter)
      if @letters.include?(letter)
        @right_guess << letter
      else
        @wrong_guess << letter
      end
    end
  end
end
