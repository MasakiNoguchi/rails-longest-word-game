require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = []
    result = ("A".."Z").to_a
    10.times { @letters << result.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    if (doesitinclude(@letters, @word) === true)
      result = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
      if(result["found"] === true)
        @answer = 'The word is valid according to the grid and is an English word'
      else
        @answer = 'The word is valid according to the grid but is not an English word'
      end
    else
      @answer = 'The word is not valid according to the grid'
    end
  end

  def doesitinclude(letters, word)
    word.downcase.chars.all? { |letter| word.count(letter) <= letters.downcase.count(letter) }
  end
end

