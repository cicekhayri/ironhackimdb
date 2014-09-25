require 'rubygems'
require 'active_record'
require 'imdb'
require 'sinatra'
require 'sinatra/reloader'



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
  validates :name, presence: true,uniqueness: true, length: { in: 1..10 }
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

  def get_imdb_id
    @the_serie = new_imdb_object(name).id
  end
end


get '/' do
  @tv_shows = TVShow.order('id DESC')
  puts "="
  puts @tv_shows
  puts "="
  erb :index
end

post '/' do
  the_show = TVShow.new
  the_show.name = params[:name]
  the_show.own_rating = params[:own_rating]
  the_show.own_comments = params[:own_comments]

  the_show.save
  redirect '/'
end

get '/our-rating/:id' do
  @tv_show = TVShow.find(params[:id])

  erb :our_rating
end




