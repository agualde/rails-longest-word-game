require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @time = Time.now
  end

  def score
    @guess = params[:word]
    @letters = params[:data]
    @start_time = params[:time]
    @end_time = Time.now
    @result = @end_time - @start_time.to_i

    if @guess.chars.all? { |letter| @letters.include?(letter.upcase) }
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{@guess}")
      json = JSON.parse(response.read)
      if json['found']
        @score = "Cool guess from a cool guy, your score was: #{@guess.chars.count} and your time was #{@result}"

      else
        @score = 'Lmao not even an english word try again bozo'
      end
    else
      @score = 'You did not choose words inside the grid'
    end
  end
end

# @guess.chars.all? { |letter| @guess.count(letter.upcase) <= @letters.count(letter.upcase) }
# @letters.downcase.include?(@guess.chars)

# @guess.chars.all? { |letter| @letters.includes?(letter.upcase) }
