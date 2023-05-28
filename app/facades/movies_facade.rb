class MoviesFacade
  def top_rated_movies
    json = top_rated_movies_results
    json[:results].map do |movie_info|
      Movie.new(movie_info)
    end
  end

  def top_rated_movies_results
    @_top_rated_movies ||= MoviesService.new.top_rated_movies
  end

  def search_results(search_query)
    json = MoviesService.new.search_movies(search_query)

    json[:results].map do |movie_info|
      Movie.new(movie_info)
    end
  end

  def get_all_movie_info(movie_id)
    movie_info = MoviesService.new.individual_movie(movie_id)
    cast_members = MoviesService.new.get_cast_members(movie_id)
    reviews_info = MoviesService.new.get_review_info(movie_id)
    all_info = movie_info.merge(cast_members, reviews_info)

    Movie.new(all_info)
  end
end
