require 'rails_helper'

RSpec.describe MovService do
  let(:top_movies) { MovService.top_rated_movies }

  it 'establishes connection for top rated movies' do
    VCR.use_cassette("movie_service", :record => :new_episodes, :match_requests_on => [:method]) do
      expect(top_movies).to be_a(Hash)
      expect(top_movies[:results]).to be_a(Array)
      expect(top_movies[:results].first[:title]).to be_a(String)
      expect(top_movies[:results].first[:title]).to eq("The Godfather")
    end
  end
end