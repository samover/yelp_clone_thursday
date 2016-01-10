require 'rails_helper'

feature 'endorsing reviews' do
  before do
    sign_in
    add_restaurant
    create_review
    click_link 'KFC'
  end

  it 'user can endorse a review', js: true do
    click_link 'Endorse Review'
    expect(page).to have_content '1 endorsement'
  end

  it 'user cannot endors a review twice', js: true do
    click_link 'Endorse Review'
    expect(page).to_not have_link 'Endorse Review'
  end
end
