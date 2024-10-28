# frozen_string_literal: true

require_relative 'lib/game'

# Hangman game on terminal
module Hangman
  game = Game.new
  game.new_word
  game.play
end
