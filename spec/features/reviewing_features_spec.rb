require 'spec_helper'

feature 'Reviewing' do
  before do
    Restaurant.create name: 'KFC'
    sign_in
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'Okay'
    select '3', from: 'Rating'
    click_button 'Leave Review'
  end

  scenario 'Allows a signed in user to review a restaurant using a form' do
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'Okay'
  end

  scenario 'Does not allow a user to review a restaurant if not signed in' do
    sign_out
    click_link 'Review KFC'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Does not allow a user to review a restaurant more than once' do
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'Good'
    select '4', from: 'Rating'
    click_button 'Leave Review'
    expect(page).to have_content 'You have already reviewed this restaurant'
    expect(page).not_to have_content 'Good'
  end
end
