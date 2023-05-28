class Movie
  attr_reader :name,
    :vote_average,
    :movie_id,
    :genres,
    :runtime,
    :description,
    :cast_members,
    :count_of_reviews,
    :author_information,
    :raw_runtime,
    :image

  def initialize(info)
    @name = info[:original_title]
    @vote_average = info[:vote_average]
    @movie_id = info[:id]
    @genres = extract_genres(info[:genres]) unless info[:genres].nil?
    @raw_runtime = info[:runtime]
    @runtime = divmod_to_sixty(info[:runtime]) unless info[:runtime].nil?
    @description = info[:overview]
    @cast_members = get_cast(info[:cast]) unless info[:cast].nil?
    @count_of_reviews = info[:total_results] unless info[:total_results].nil?
    @author_information = author_hash(info[:results]) unless info[:results].nil?
    @image = info[:backdrop_path]
  end

  def divmod_to_sixty(info)
    info.divmod(60)
  end

  def extract_genres(info)
    info.map do |genre|
      genre[:name]
    end
  end

  def get_cast(cast_info)
    hash = {}
    cast_info.each do |indiv|
      hash[indiv[:name]] = indiv[:character]
    end
    hash.first(10).to_h
  end

  def author_hash(reviews_data)
    hash = {}
    reviews_data.each do |review|
      hash[review[:author]] = review[:author_details]
    end
    hash
  end
end
