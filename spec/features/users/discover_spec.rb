require 'rails_helper'

RSpec.describe "User Discover Page", type: :feature do
  let!(:andra) { User.create!(name: "Andra", email: "andra@turing.edu") }
  
  before do
    visit "/users/#{andra.id}/discover"
  end

  describe "When I visit '/users/:id/discover" do
    describe "button to discover top rated movies" do
      it "I see a button to discover top rated movies" do
        expect(page).to have_button("Discover Top Rated Movies")
      end

      it "when I click the button, I am taken to the movies results page" do
        VCR.use_cassette("button_top_rated_discover_page", :record => :new_episodes, :match_requests_on => [:method]) do
          click_button "Discover Top Rated Movies"
          expect(current_path).to eq("/users/#{andra.id}/movies")
        end
      end
    end

    describe "section to search movies by keyword" do
      it "I see a text field to enter keyword(s) to search by movie title" do
        within "#search_by_keyword" do
          expect(page).to have_field("Keywords")
        end
      end
      
      it "I see a button to search by movie title" do
        within "#search_by_keyword" do
          expect(page).to have_button("Search by Movie Title")
        end
      end

      it "when I fill in the field and click search by movie title, I am taken to the movies results page" do
        VCR.use_cassette("search_top_rated_discover_page", :record => :new_episodes, :match_requests_on => [:method]) do
          within "#search_by_keyword" do
            fill_in :keywords, with: "Night"
            click_button "Search by Movie Title"
            expect(current_path).to eq("/users/#{andra.id}/movies")
          end
        end
      end
    end
  end
end