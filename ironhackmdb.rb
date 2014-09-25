require 'rubygems'
require 'active_record'
require 'sinatra'
require "sinatra/reloader"
require 'imdb'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'ironhackmdb.sqlite'
)

class TVShow < ActiveRecord::Base

  # search the IMDB database
  def new_imdb_object(argument)
    @search_for_movie = Imdb::Search.new(argument).movies.first
    @the_series = Imdb::Serie.new(@search_for_movie.id)
  end

  # we have name, own_rating and own_comments available
  validates :name, presence: true, length: { in: 1..10 }
  validates :own_comments, length: { in: 100..1000 }
  validates :own_rating, presence: true, numericality: true 
 
  def imdb_rating
    @the_serie = new_imdb_object(name).rating
  end

  def imdb_number_of_seasons
    @the_serie = new_imdb_object(name).seasons.size
  end

  def imdb_get_movie_poster
    @the_serie = new_imdb_object(name).poster
  end
end




