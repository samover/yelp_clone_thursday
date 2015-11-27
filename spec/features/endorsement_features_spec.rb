require 'rails_helper'

feature 'endorsing reviews' do
  before do
    sign_in
    add_restaurant
    create_review
    click_link 'KFC'
    click_link 'Endorse Review'
  end

  it 'user can endorse a review' do
    expect(page).to have_content '1 endorsement'
  end

  it 'user cannot endors a review twice' do
    click_link 'KFC'
    expect(page).to_not have_link 'Endorse Review'
  end
end
