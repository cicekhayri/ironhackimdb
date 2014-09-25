require_relative "../ironhackmdb"

describe TVShow do
  before do 
    @tvshow = TVShow.new
    @tvshow.name = "Friends"
    @tvshow.own_rating = 6
    @tvshow.own_comments = "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor" 
  end

  it "should not be empty string in name field" do
    expect(@tvshow.name="Friends").not_to eql(false)
  end

  it "should not be empty the rating, you should be passing your rating" do
    expect(@tvshow.own_rating=5).not_to eql(false)
  end

  it "should have your comments which is longer than 100 characters" do
    expect(@tvshow.own_comments="Lorem ipsum dolor Lorem ipsum dolor").not_to eql(true)
  end

  it "should have a method which gets the IMDB rating for the movie" do
    expect(@tvshow.imdb_rating).to eql(9.0)
  end

  it "should have a method which gets the IMDB seasons for the serie" do
    expect(@tvshow.imdb_number_of_seasons).to eql(10)
  end

  it "should have a method which gets the IMDB poster for the movie" do
    expect(@tvshow.imdb_get_movie_poster).to eql("http://ia.media-imdb.com/images/M/MV5BMzgxMzcxMjYzMl5BMl5BanBnXkFtZTcwMzE3NTEyMQ@@.jpg")
  end
end
