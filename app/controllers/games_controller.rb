require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
    @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @check_for_word = check_for_word?(params[:word])
    @check_grid = check_grid?(params[:letters])
    if @check_grid == false
      @result = "Sorry the words cant be build by #{params[:letters]}"
    elsif @check_for_word["found"] == true
      @result = "That's a valid word"
    else
      @result = "not valid english word"
    end
  end

  def check_for_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_check = URI.open(url).read
    words = JSON.parse(word_check)
  end

  def check_grid?(letters)
    @word = params[:word]
    @word.chars.each do |letter|
      unless (letters.split.include?(letter))
        return false
      end
    end
  end


end
