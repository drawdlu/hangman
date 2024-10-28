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
      @wrong_guess = []
      @right_guess = []
      @guesses = 0
    end

    def new_word
      words = File.read('assets/google-10000-english-no-swears.txt').split
      @word = words.sample until @word.length < 13 && @word.length > 4
    end
  end
end
