# frozen_string_literal: true

module Hangman
  # Handles game loop
  class Game
    MAX_TURNS = 6

    def initialize
      @guesser = 'test'
      @word = ''
      @wrong_guesses = []
      @correct_guesses = []
      @guesses = 0
    end

    def new_word
      words = File.read('assets/google-10000-english-no-swears.txt').split
      @word = words.sample until @word.length < 13 && @word.length > 4
    end
  end
end
