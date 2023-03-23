require 'rails_helper'

RSpec.describe MovService do
  let(:top_movies) { MovService.top_rated_movies }
  let(:keys) { MovService.keywords("Hello") }
  let(:movie_deets) { MovService.details(123) }

  it 'establishes connection for top rated movies' do
    VCR.use_cassette("movie_service", :record => :new_episodes, :match_requests_on => [:method]) do
      expect(top_movies).to be_a(Hash)
      expect(top_movies[:results]).to be_a(Array)
      expect(top_movies[:results].first[:title]).to be_a(String)
    end
  end

  it 'establishes a connection for keywords' do
    VCR.use_cassette("movie_service_keyword", :record => :new_episodes, :match_requests_on => [:method]) do
      expect(keys).to be_a(Hash)
      expect(keys[:results]).to be_a(Array)
      expect(keys[:results].first[:original_title]).to be_a(String)
    end
  end

  it 'establishes a connection for movie details' do
    VCR.use_cassette("movie_service_details", :record => :new_episodes, :match_requests_on => [:method]) do
      expect(movie_deets).to be_a(Hash)
      expect(movie_deets[:title]).to be_a(String)
      expect(movie_deets[:vote_count]).to be_a(Integer)
    end
  end
end