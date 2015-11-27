require 'rails_helper'

feature 'endorsing reviews' do
  before do
    sign_in
    add_restaurant
    create_review
  end

  it 'user can endorse a review' do
    sign_out
    sign_in(email: 'rob@makers.com', password: 'password')
    click_link 'KFC'
    click_link 'Endorse Review'
    expect(page).to have_content '1 endorsement'
  end
end
