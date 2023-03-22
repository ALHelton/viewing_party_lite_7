require 'rails_helper'

RSpec.describe 'Movies Index Page', type: :feature do
  let!(:andra) { User.create!(name: "Andra", email: "andra@turing.edu") }

  describe 'when I visit "/user/:id/movies' do

    
    it 'I see the movie title as a link to the movie details page with a maximum of 20 results' do
      VCR.use_cassette("movie_index", :record => :new_episodes, :match_requests_on => [:method]) do
        visit "/users/#{andra.id}/movies"

        within(first(".movie")) do
          expect(page).to have_css(".movie_name")
          expect(page).to have_css(".vote_avg")

          within(".movie_name") do
            expect(page).to have_link(href: %r{/users/\d+/movies/\d+})
          end
        end
      end
    end
  end
end