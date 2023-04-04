require 'rails_helper'

RSpec.describe 'landing page, index', type: :feature do
  describe "as a user" do
    before :each do
      @user1 = User.create!(name: "Andra", email: "andra@turing.edu", password: "heyo888")
      @user2 = User.create!(name: "Hady", email: "hady@turing.edu", password: "heyo888")
      visit "/"
    end

    describe "when visits landing page ('/'')" do
      it "the user will see the title of the application" do 
        expect(page).to have_content("Viewing Party Application (Andra and Hady)")
      end 

      it "user will see a button to register a new user" do 
        expect(page).to have_button("Register")
        click_button("Register")
        expect(current_path).to eq("/register")
      end 

      it "will see list of existing users with links to their respective dashboards" do 
        expect(page).to have_content("#{@user1.name}")
        expect(page).to have_link("#{@user1.name}'s Dashboard")
      end 

      it "if you click on a user's dashboard link, you will be taken to that user's dashboard" do
        within("#existing_users") do 
          click_link("#{@user1.name}'s Dashboard")
          expect(current_path).to eq("/users/#{@user1.id}")
        end
      end

      it "link to go back to landing page" do 
        expect(page).to have_link("Back to Landing Page")
        click_link("Back to Landing Page")
        expect(current_path).to eq("/")
      end 

      it "I see a link to 'Log In', click the button, and am taken to a Log In page ('/login')" do
        expect(page).to have_button("Log In")
        click_button("Log In")
        expect(current_path).to eq("/login")
      end

      it "After logging in successfully, I see a button to log out" do
        user = User.create(name: "Andra", email: "funbucket13@gmail.com", password: "test")
        click_button("Log In")
        fill_in :email, with: "funbucket13@gmail.com"
        fill_in :password, with: "test"
        click_on "Log In"
        expect(current_path).to eq("/users/#{user.id}")
        
        click_link "Back to Landing Page"
        expect(page).to have_button("Log Out")
      end
    end 
  end 
end
