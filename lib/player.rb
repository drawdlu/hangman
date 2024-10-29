# frozen_string_literal: true

module Hangman
  # Handles player guess
  class Player
    def initialize(game)
      @game = game
    end

    def guess_or_save
      loop do
        print 'Pick a letter: '
        letter = gets.chomp.downcase
        next if guess_includes?(letter)
        return letter unless letter.length != 1
      end
    end

    private

    def guess_includes?(letter)
      @game.wrong_guess.include?(letter) || @game.right_guess.include?(letter)
    end
  end
end
