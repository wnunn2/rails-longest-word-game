# frozen_string_literal: true

require 'rest-client'

# leave me alone rubocop
class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('a'..'z').to_a[rand(26)] }.join(' ')
  end

  def score
    @letters = params[:letters]
    @attempt = params[:attempt]

    if @letters.include? @attempt
      return "Nice Job! #{@attempt} is a valid English word."
    elsif @letters.exclude? @attempt
      return "Sorry, but #{@attempt} cannot be built out of #{@letters}."
    else
      return "Sorry but #{@attempt} is not a valid English word."
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    response = RestClient.get(url)
    JSON.parse(response)
  end
end
