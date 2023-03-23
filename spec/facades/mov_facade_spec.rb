require 'rails_helper'

RSpec.describe MovFacade do
  let(:top_rated) { MovFacade.top_rated_movies }
  let(:keys) { MovFacade.keywords("Hello") }
  let(:movie_deets) { MovFacade.details(123) }

  it 'creates top rated movies poros' do
    VCR.use_cassette("movie_facade", :record => :new_episodes, :match_requests_on => [:method]) do
      expect(top_rated.first).to be_a(Movie)
    end
  end

  it 'creates keyword search for movies poros' do
    VCR.use_cassette("keyword_search_facade", :record => :new_episodes, :match_requests_on => [:method]) do
      expect(keys.first).to be_a(Movie)
    end
  end

  it 'creates movie details for movies poros' do
    VCR.use_cassette("movie_details_facade", :record => :new_episodes, :match_requests_on => [:method]) do
      expect(movie_deets).to be_a(Movie)
    end
  end
end 