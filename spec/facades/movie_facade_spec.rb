require "rails_helper"
RSpec.describe MoviesFacade do
  describe "MoviesFacade" do
    before :each do
      @facade = MoviesFacade.new
    end

    it "creates movies objects of the top rated movies" do
      VCR.use_cassette("top_rated_movies") do
        expect(@facade.top_rated_movies.first).to be_a(Movie)
      end
    end

    it "creates movies objects of the results returned by the search" do
      VCR.use_cassette("search_results_green") do
        expect(@facade.search_results("green").first).to be_a(Movie)
      end
      VCR.use_cassette("search_results_green") do
        expect(@facade.search_results("green").first.name.downcase).to include("green")
      end
    end

    it "creates movies PORO when API call is to get an individual movie and that PORO has several itemized attributes relevant to the cast and the movies general information" do
      VCR.use_cassette("ind_movie_full_call_cast_movie") do
        movie_id = "238"
        results = @facade.get_all_movie_info(movie_id)

        expect(results).to be_an_instance_of(Movie)
        expect(results).to respond_to(:name)
        expect(results.name).not_to be_nil
        expect(results).to respond_to(:runtime)
        expect(results.runtime).not_to be_nil
        expect(results).to respond_to(:vote_average)
        expect(results.vote_average).not_to be_nil
        expect(results).to respond_to(:genres)
        expect(results.genres).not_to be_nil
        expect(results).to respond_to(:cast_members)
        expect(results.cast_members).to be_a(Hash)
      end
    end

    it "creates movies PORO when API call is to get an individual movie and that PORO has several itemized attributes relevant to the cast and the movies general information, and now will include the review information" do
      VCR.use_cassette("ind_movie_full_call_cast_movie") do
        movie_id = "238"

        results = @facade.get_all_movie_info(movie_id)
        expect(results).to respond_to(:count_of_reviews)
        expect(results.count_of_reviews).not_to be_nil
        expect(results).to respond_to(:author_information)
        expect(results.author_information).not_to be_nil
      end
    end
  end
end
