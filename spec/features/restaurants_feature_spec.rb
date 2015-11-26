require 'rails_helper'

feature 'restaurant' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet!'
      expect(page).to have_link 'Add a restaurant!'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    context 'when a user is signed in'
      scenario 'prompt a user to fill out a form, the display the new restaurant' do
        sign_in
        visit '/restaurants'
        click_link 'Add a restaurant!'
        fill_in 'Name', with: 'KFC'
        click_button 'Create Restaurant'
        expect(page).to have_content 'KFC'
        expect(current_path).to eq '/restaurants'
      end

      context 'invalid restaurant' do
        it 'does not allow user to submit name that is too short' do
          sign_in
          visit '/restaurants'
          click_link 'Add a restaurant!'
          fill_in 'Name', with: 'kf'
          click_button 'Create Restaurant'
          expect(page).not_to have_css 'h2', text: 'kf'
          expect(page).to have_content 'error'
        end
      end

    context 'when a user is not signed in' do
      scenario 'prompt a user to sign up or sign in' do
        visit '/restaurants'
        click_link 'Add a restaurant!'
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
      end
    end
  end

  context 'viewing restaurants' do
    let!(:kfc){Restaurant.create(name: 'KFC')}
    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
    scenario 'shows user all reviews' do
      sign_in
      visit '/restaurants'
      create_review
      click_link 'KFC'
      expect(page).to have_content 'Good'
    end
  end

  context 'editing restaurants' do
    before do
      sign_in
      add_restaurant
    end

    scenario 'let a user edit a restaurant which he has created' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'does not let a user edit a restaurant which he has not created' do
      sign_out
      sign_in(email:"test2@test.com", password:"password2")
      expect(page).not_to have_css 'a', text: 'Edit KFC'
    end

    scenario 'not allowed when signed out' do
      sign_out
      expect(page).not_to have_css 'a', text: 'Edit KFC'
    end
  end

  context 'deleting restaurants' do
    before do
      sign_in
      add_restaurant
    end

    scenario 'let a user delete a restaurant which he has created' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'doen not let a user delete a restaurant which she has not created' do
      sign_out
      sign_in(email: 'potato@makers.org', password: 'password')
      expect(page).not_to have_css 'a', text: 'Delete KFC'
    end

    scenario 'not allowed when signed out' do
      sign_out
      expect(page).not_to have_css 'a', text: 'Delete KFC'
    end
  end
end
