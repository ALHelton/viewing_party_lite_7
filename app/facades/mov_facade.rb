class MovFacade
  def self.top_rated_movies
    movie_list = MovService.top_rated_movies[:results]
    #gives array of movies with [:results]
    movie_list.map do |data|
      Movie.new(data)
    end
  end
end