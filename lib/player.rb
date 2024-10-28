# frozen_string_literal: true

module Hangman
  # Handles player guess
  class Player
    def initialize(game)
      @game = game
    end

    def guess
      loop do
        print 'Pick a letter: '
        letter = gets.chomp
        next if guess_includes?(letter)
        return letter unless letter.length != 1
      end
    end

    def guess_includes?(letter)
      @game.wrong_guess.include?(letter) || @game.right_guess.include?(letter)
    end
  end
end
