require "rails_helper"

RSpec.describe MoviesService do
  describe "MovieServices" do
    before :each do
      @movie_services = MoviesService.new
    end

    it "creates a Faraday connection to the URL https://api.themoviedb.org/3/" do
      expect(@movie_services.connection).to be_an_instance_of(Faraday::Connection)
      expect(@movie_services.connection.url_prefix.to_s).to include("https://api.themoviedb.org/3/")
      expect(@movie_services.connection.params["language"]).to eq("en-US")
      expect(@movie_services.connection.params["api_key"]).to eq(ENV["MoviesDB_API_KEY"])
    end

    it "returns a Ruby hash from the input with information about the top rated movies" do
      VCR.use_cassette("top_rated_movies", allow_playback_repeats: true) do
        results = @movie_services.top_rated_movies

        expect(results).to be_a(Hash)
        expect(results[:results]).to be_a(Array)
        expect(results[:results].count).to eq(20)
        required_keys = %i[id original_title overview vote_average]

        expect(results[:results].first).to include(*required_keys)
      end
    end

    it "returns a Ruby hash from the input with information about searched movie" do
      VCR.use_cassette("movie_search_bad", allow_playback_repeats: true) do
        results = @movie_services.search_movies("bad")

        expect(results).to be_a(Hash)
        expect(results[:results]).to be_a(Array)
        expect(results[:results].count).to eq(20)
        expect(results[:results].first[:original_title].downcase).to include("bad")
        required_keys = %i[id original_title overview vote_average]
        expect(results[:results].first).to include(*required_keys)
      end
    end

    it "returns a Ruby hash with results about that individual movie" do
      VCR.use_cassette("movie_id_238", allow_playback_repeats: true) do
        movie_id = "238"
        results = @movie_services.individual_movie(movie_id)
        expect(results).to be_a(Hash)
        required_keys = %i[id genres overview vote_average original_title runtime]

        expect(results).to include(*required_keys)
      end
    end

    it "returns a Ruby has with cast information about the cast  members" do
      VCR.use_cassette("movie_id_238_cast_members", allow_playback_repeats: true) do
        movie_id = "238"
        results = @movie_services.get_cast_members(movie_id)
        expect(results).to be_a(Hash)
        expect(results[:cast]).to be_a(Array)
        required_keys = %i[adult gender id cast_id name character]
        expect(results[:cast].first).to include(*required_keys)
      end
    end

    it "returns a Ruby with information about the reviewers" do
      VCR.use_cassette("movie_id_238_reviews", allow_playback_repeats: true) do
        movie_id = "238"
        results = @movie_services.get_review_info(movie_id)
        expect(results).to be_a(Hash)
        required_keys = %i[total_results]
        expect(results).to include(*required_keys)
        required_keys_array = %i[author]
        expect(results[:results]).to be_a(Array)
        expect(results[:results].first).to include(*required_keys_array)
      end
    end

    it "does not resturn JSON but returns a Ruby Hash" do
      VCR.use_cassette("top_rated_movies", allow_playback_repeats: true) do
        results = @movie_services.get_url("movie/top_rated")
        expect(results).to be_a(Hash)
      end
    end
  end
end
