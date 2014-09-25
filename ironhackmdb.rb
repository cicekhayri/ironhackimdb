require 'rubygems'
require 'active_record'
require 'imdb'
require 'sinatra'
require 'sinatra/reloader'



ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'ironhackmdb_premium.sqlite'
)

class TVShow < ActiveRecord::Base

  # search the IMDB database
  #def new_imdb_object(argument)
  #  search_for_movie = Imdb::Search.new(argument).movies.first
  #  the_series = Imdb::Serie.new(search_for_movie.id)
  #end

  # we have name, own_rating and own_comments available
  validates :name, presence: true,uniqueness: true, length: { in: 1..10 }
  validates :own_comments, length: { in: 100..1000 }
  validates :own_rating, presence: true, numericality: true 
  before_create :get_imdb_info_save_to_db
 
  
#  def imdb_rating
#    the_serie = get_imdb_info_save_to_db(name).rating
#  end

#  def imdb_number_of_seasons
#    the_serie = get_imdb_info_save_to_db(name).seasons.size
#  end

#  def imdb_get_movie_poster
#    the_serie = get_imdb_info_save_to_db(name).poster
#  end

#  def get_imdb_id
#    the_serie = get_imdb_info_save_to_db(name).id
#  end

  private
  def get_imdb_info_save_to_db
    search_for_movie = Imdb::Search.new(name).movies.first
    the_series = Imdb::Serie.new(search_for_movie.id)
    self.imdb_rating = the_series.rating
    self.imdb_number_of_seasons = the_series.seasons.size
    self.imdb_link = the_series.url
    self.imdb_picture_link = the_series.poster
  end
end


get '/' do
  @tv_shows = TVShow.order(id: :desc)
  #@tv_shows = TVShow.all
  erb :index
end

post '/' do
  the_show = TVShow.new
  the_show.name = params[:name]
  the_show.own_rating = params[:own_rating].to_f
  the_show.own_comments = params[:own_comments]
  
  if the_show.save
    redirect '/'
  else
    the_show.errors.each do |e|
      puts e
    end  
  end
end

get '/our-rating/:id' do
  @tv_show = TVShow.find(params[:id])

  erb :our_rating
end

get '/delete/:id' do
  @tv_show = TVShow.find(params[:id])
  @tv_show.delete

  redirect '/'
end


