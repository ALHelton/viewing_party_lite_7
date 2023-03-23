require 'rails_helper'

RSpec.describe 'Movies Show Page', type: :feature do
  let!(:andra) { User.create!(name: "Andra", email: "andra@turing.edu") }

  describe 'when I visit "/user/:id/movies/:movie_id' do
    it 'I see a button to create a viewing party' do
      
    end
  end
end