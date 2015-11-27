require 'rails_helper'

feature 'Reviewing' do
  before do
    sign_in
    add_restaurant
    create_review(thoughts: "Good", rating: 4)
  end

  scenario 'Allow a user to see the time elapsed since review posted' do
    restaurant = Restaurant.all.last
    review = restaurant.reviews.last
    review.created_at = DateTime.now - 50
    review.save
    visit('/')
    expect(page).to have_content 'about 2 months ago'
  end

  scenario 'Allows a signed in user to review a restaurant using a form' do
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'Good'
  end

  scenario 'Does not allow a user to review a restaurant if not signed in' do
    sign_out
    click_link 'Review KFC'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Does not allow a user to review a restaurant more than once' do
    create_review(thoughts:"Bad", rating:2)
    expect(page).to have_content 'You have already reviewed this restaurant'
    expect(page).not_to have_content 'Bad'
  end

  scenario "allows an author of a review to delete his review" do
    click_link 'KFC'
    click_link 'Delete Review'
    expect(page).to_not have_content 'Okay'
  end

  scenario "does not allow a user to delete a review she has not authored" do
    sign_out
    sign_in(email: 'test2@test.com', password: 'password')
    click_link 'KFC'
    expect(page).not_to have_link 'Delete Review'
  end

  scenario 'displays an average rating for all reviews' do
    sign_out
    sign_in(email: 'test2@test.com', password: 'password')
    create_review(thoughts: 'Bad', rating: 2)
    expect(page).to have_content 'Average rating: ★★★☆☆'
  end
end
