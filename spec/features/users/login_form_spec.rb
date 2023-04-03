require 'rails_helper'

RSpec.describe 'User Login page', type: :feature do
  describe "Login Happy Path" do
    it "can log in with valid credentials" do
      user = User.create(name: "Andra", email: "funbucket13@gmail.com", password: "test")

      visit "/"
      click_on "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_field(:email)
      expect(page).to have_field(:password)

      fill_in :email, with: "funbucket13@gmail.com"
      fill_in :password, with: "test"
      click_on "Log In"

      expect(current_path).to eq("/users/#{user.id}")
      expect(page).to have_content("Welcome, #{user.name}")
    end
  end

  describe "Login Sad Path" do
    it "I'm taken back to the Log In page if I filled in invalid login credentials" do
      user = User.create(name: "Andra", email: "funbucket13@gmail.com", password: "test")

      visit login_path
      expect(page).to have_field(:email)
      expect(page).to have_field(:password)

      fill_in :email, with: "funbucket13@gmail.com"
      fill_in :password, with: "another test"
      click_on "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Sorry, your credentials are bad.")
    end
  end
end