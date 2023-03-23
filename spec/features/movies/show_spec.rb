require 'rails_helper'

RSpec.describe 'Movies Show Page', type: :feature do
  let!(:andra) { User.create!(name: "Andra", email: "andra@turing.edu") }

  describe 'when I visit "/user/:id/movies/:movie_id' do
    it 'I see a button to create a viewing party that takes me to a new viewing party page' do
      VCR.use_cassette("movie_show", :record => :new_episodes, :match_requests_on => [:method]) do
        visit "/users/#{andra.id}/movies/123"
        expect(page).to have_button("Create a Viewing Party")

        click_button "Create a Viewing Party"
        expect(current_path).to eq("/users/#{andra.id}/movies/123/viewing_parties/new")
      end
    end
  end
end