require 'spec_helper'

describe Movie do
  describe "#similar" do
    it "should find movies by the same director" do
        # create some movies and add them to the database
        @movies = [Movie.create(title: 'thor', director: 'stan lee'), Movie.create(title: 'hulk', director: 'stan lee')]

        # return movies from movie model method by searching for defined director
        @results = Movie.search_similar_director('stan lee')

        # expect results to include created movies
        # * character refers to splatting the arguments when comparing arrays
        # https://stackoverflow.com/questions/14890375/rspec-how-could-i-use-the-array-include-matcher-in-the-expect-syntax
        expect(@results).to include(*@movies)
    end

    it "should not find movies by different directors" do
        # create some movies and add them to the database
        @movies = [Movie.create(title: 'thor', director: 'stan lee'), Movie.create(title: 'hulk', director: 'stan lee')]

        # create some other mvies to compare against returned movies
        @other_movies = [Movie.create(title: 'tiger king', director: 'joe exotic'), Movie.create(title: 'big cat', director: 'carole baskin')]

        # return movies from movie model method by searching for defined director
        @results = Movie.search_similar_director('stan lee')

        # expect results returned to not include other movies created
        # splatting array again, refer to stackoverflow link above
        expect(@results).not_to include(*@other_movies)
    end
  end
end