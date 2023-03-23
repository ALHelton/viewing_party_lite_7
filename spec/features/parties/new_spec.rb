require 'rails_helper'

RSpec.describe "party new page", type: :feature do
  before :each do 
    @andra = User.create!(name: "Andra", email: "andra@turing.edu")
    @hady = User.create!(name: "Hady", email: "hady@turing.edu")
    VCR.use_cassette("top_rated_movies") do
      @results = MoviesFacade.top_rated_movies
    end
  end 
  describe "when visit the viewing party page" do 

    it "when you enter the viewing party, it lists the movie title, the voting average and the runtime" do
      VCR.use_cassette("party_new_spec", :allow_playback_repeats => true) do
        visit "/users/#{@hady.id}/movies/#{@results[0].movie_id}"

        click_link("Create Viewing Party")
          within("div#movie_title") do 
            expect(page).to have_content(/Movie Title(?=.+)/)
          end

          within("div#vote_average") do 
            expect(page).to have_content(/\d+\.\d+/)
          end
        
          within("div#runtime") do 
            expect(page).to have_content("Runtime")
            expect(page).to have_content("hours")
            expect(page).to have_content("minutes")
          end
        end 
      end 

    it "when you enter the genres, the summary description, and the first 10 cast members and their characters" do
      VCR.use_cassette("party_new_spec", :allow_playback_repeats => true) do
        visit "/users/#{@hady.id}/movies/#{@results[0].movie_id}"

        click_link("Create Viewing Party")
        within("div#genres") do 
          expect(page).to have_content(/Genres(?=.+)/)
        end

        within("div#description") do 
          expect(page).to have_content(/Summary Description(?=.+)/)
        end

        within("div#cast_members") do 
          expect(all('li').count).to eq(10)
          all('li').each do |li|
            expect(li.text).to include("as")
          end
        end

      end 
    end 

    it "when you enter, you see the count of reviews, and the information about each author" do
      VCR.use_cassette("party_new_spec", :allow_playback_repeats => true) do
        visit "/users/#{@hady.id}/movies/#{@results[0].movie_id}"

        click_link("Create Viewing Party")
        within("div#count_of_reviews") do 
          expect(page).to have_content("Number of Reviews")
          expect(page).to have_content(/\d+/)
        end

        within("div#author_information") do 
          expect(page).to have_content("Username")
          expect(page).to have_content("Avatar path")
          expect(page).to have_content("Rating")
        end
      end 
    end 

    it "when you enter /users/:user_id/movies/:movid_id/parties/new you will see a form below the name with information to fill out including duration of party, date, time, and submit button" do 
      VCR.use_cassette("party_new_spec_form", :allow_playback_repeats => true) do
        visit "/users/#{@hady.id}/movies/#{@results[0].movie_id}/parties/new"
 
        within("div#viewing_party_form") do 
          expect(page).to have_selector("form")
          expect(page).to have_field("duration", type: 'number')
          expect(page).to have_field("event_date", type: 'date')
          expect(page).to have_field("time_field")
          expect(page).to have_button("Create Party")
        end 
      
      end 
    end

    it "when you enter /users/:user_id/movies/:movid_id/parties/new you will see a form below the name that includes all the current users registered in the system and a checkbox next to their name to invite them to the viewing party" do 
      VCR.use_cassette("party_new_spec_form", :allow_playback_repeats => true) do
        visit "/users/#{@hady.id}/movies/#{@results[0].movie_id}/parties/new"
        within("div#viewing_party_form") do 
          within("div#Hady") do 
            expect(page).to have_content("Check to invite to viewing party Hady")
            expect(page).to have_selector("input[type='checkbox']")
          end

          within("div#Andra") do 
            expect(page).to have_content("Check to invite to viewing party Andra")
            expect(page).to have_selector("input[type='checkbox']")
          end
        end 
      end 
    end

    it "when you fill in the form on the viewing party new page, you are redirected to the user's dashboard where the new event is shown" do 
      VCR.use_cassette("party_new_spec_form", :allow_playback_repeats => true) do
        visit "/users/#{@hady.id}/movies/#{@results[0].movie_id}/parties/new"
        within("div#viewing_party_form") do 
          fill_in "Party duration (in minutes):", with: 180

        end
        save_and_open_page
      end 
    end 



    it "the event should also be listed on any user's dashboard that were invited to the party" do 

    end

  end 
end 