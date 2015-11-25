require 'spec_helper'

feature 'Reviewing' do
  before { Restaurant.create name: 'KFC' }

  scenario 'Allows users to review a restaurant using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'Okay'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'Okay'
  end
end
