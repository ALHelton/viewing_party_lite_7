require "rails_helper"

RSpec.describe "register, new page", type: :feature do
  describe "as a user" do
    describe "when visits the registration page ('/register')" do
      it "the user will see the form to register" do
        visit "/register"
        expect(page).to have_selector("form")
        expect(page).to have_field("Name")
        expect(page).to have_field("Email")
      end

      it "there is also a registration button" do
        visit "/register"
        expect(page).to have_button("Register User")
      end
    end
  end
end
