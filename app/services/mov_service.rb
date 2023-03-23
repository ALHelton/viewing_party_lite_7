class MovService
  def self.conn
    Faraday.new(url: 'https://api.themoviedb.org') do |f|
      f.params['api_key'] = ENV['movdb_key']
    end
  end

  def self.top_rated_movies
    response = conn.get("/3/movie/top_rated")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.keywords(text)
    response = conn.get("/3/search/movie?&query=#{text}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.details(movie_id)
    response = conn.get("/3/movie/#{movie_id}")
    JSON.parse(response.body, symbolize_names: true)
  end
end