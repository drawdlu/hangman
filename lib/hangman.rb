# frozen_string_literal: true

# Hangman game drawing
module Hangman
  HANGMAN_STATES = [
    '     ||||||||||||
          |    ||
          O    ||
         /|\   ||
         / \   ||
               ||',
    '     ||||||||||||
          |    ||
          O    ||
         /|\   ||
         /     ||
               ||',
    '     ||||||||||||
          |    ||
          O    ||
         /|\   ||
               ||
               ||',
    '     ||||||||||||
          |    ||
          O    ||
         /|    ||
               ||
               ||',
    '     ||||||||||||
          |    ||
          O    ||
          |    ||
               ||
               ||',
    '     ||||||||||||
          |    ||
          O    ||
               ||
               ||
               ||',
    '     ||||||||||||
          |    ||
               ||
               ||
               ||
               ||'
  ].freeze

  def print_hangman(state)
    puts
    puts Hangman::HANGMAN_STATES[state]
  end
end
