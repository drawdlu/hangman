# frozen_string_literal: true

module Hangman
  # Handles player guess and saving
  class Player
    def initialize(game)
      @game = game
    end

    def guess_or_save
      puts 'Type "save" if you want to save the current game...'
      loop do
        print 'Pick a letter: '
        letter = gets.chomp.downcase
        next if guess_includes?(letter)

        return letter if letter.length == 1 || letter == 'save'
      end
    end

    private

    def guess_includes?(letter)
      @game.wrong_guess.include?(letter) || @game.right_guess.include?(letter)
    end
  end
end
