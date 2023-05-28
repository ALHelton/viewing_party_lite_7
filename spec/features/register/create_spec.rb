require "rails_helper"

RSpec.describe "register, create page", type: :feature do
  describe "as a user" do
    describe "when user attempts to register a new user ('/register')" do
      before :each do
        @user1 = User.create!(name: "Andra", email: "andra@turing.edu")
        @user2 = User.create!(name: "Hady", email: "hady@turing.edu")
      end

      it "when the user inputs a unique email into the form on the registrations new page and clicks submit, a new user is created with that email and the user is redirected to the new user's dashboard page page" do
        visit "/register"
        fill_in "name", with: "Malena"
        fill_in "email", with: "malena@gmail.com"
        click_button("Register User")
        expect(User.last.name).to eq("Malena")
        expect(User.last.email).to eq("malena@gmail.com")
        expect(current_path).to eq("/users/#{User.last.id}")
      end

      it "there is also a registration button" do
        visit "/register"
        expect(page).to have_button("Register User")
      end

      describe "sad path" do
        it "if the user inputs an email which already has been used, they will be redirected back to the registration page with a flash message indicating that email is already in use" do
          visit "/register"
          fill_in "name", with: "Hady"
          fill_in "email", with: "hady@turing.edu"
          click_button("Register User")
          expect(current_path).to eq("/register")
          expect(page).to have_content("A user with that email address already exists. Please choose a different email.")
        end
      end
    end
  end
end
