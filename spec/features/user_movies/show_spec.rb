require 'rails_helper'

RSpec.describe "User_movie Index Page", type: :feature do
  describe "As a registered user" do 
    before :each do 
      @andra = User.create!(name: "Andra", email: "andra@turing.edu", password: "hello123")
      @hady = User.create!(name: "Hady", email: "hady@turing.edu", password: "hello123")
      visit "/"
      click_button("Log In")
      fill_in :email, with: "hady@turing.edu"
      fill_in :password, with: "hello123"
      click_on "Log In"
      expect(current_path).to eq("/users/#{@hady.id}")
  
      VCR.use_cassette("top_rated_movies") do
        @results = MoviesFacade.new.top_rated_movies
      end
    end 

    it "should show a button to create a viewing party and one to return to discover page" do
      VCR.use_cassette("movie_id_238_usermovie_show_spec") do
        visit "/users/#{@hady.id}/movies/#{@results[0].movie_id}"
   
        expect(page).to have_link("Return to Discover Page", href: "/users/#{@hady.id}/discover")
        expect(page).to have_link("Create Viewing Party", href: "/users/#{@hady.id}/movies/#{@results[0].movie_id}/parties/new")
      end 
    end 
  end 

  describe "As default visitor" do 
    before do
      @andra = User.create!(name: "Andra", email: "andra@turing.edu", password: "hello123")
      @hady = User.create!(name: "Hady", email: "hady@turing.edu", password: "hello123")
      VCR.use_cassette("top_rated_movies") do
        @results = MoviesFacade.new.top_rated_movies
      end
    end

    it "I click the button to create a viewing party and redirected to the movies show page with message to log in/register" do
      VCR.use_cassette("unregistered_movie_show") do
        
        visit "/users/#{@hady.id}/movies/#{@results[0].movie_id}"

        click_link ("Create Viewing Party")
        expect(current_path).to eq("/users/#{@hady.id}/movies/#{@results[0].movie_id}")
        expect(page).to have_content("You must be logged in or registered to create a party")
      end
    end
  end 
end 
