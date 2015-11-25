require 'spec_helper'

feature 'User can sign in and out' do
  context 'User not signed in and on home page' do
    it 'should see a sign in and sign up link' do
      visit '/'
      expect(page).to have_link 'Sign in'
      expect(page).to have_link 'Sign up'
    end
    it 'should not see a sign out link' do
      visit '/'
      expect(page).not_to have_link 'Sign out'
    end
  end

  context 'User signed in on the home page' do
    before do
      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: 'pjackson@carrot.org'
      fill_in 'Password', with: 'somePassword'
      fill_in 'Password confirmation', with: 'somePassword'
      click_button 'Sign up'
    end

    it 'should not see a sign in and sign up link' do
      visit '/'
      expect(page).not_to have_link 'Sign in'
      expect(page).not_to have_link 'Sign up'
    end

    it 'should see a sign out link' do
      visit '/'
      expect(page).to have_link 'Sign out'
    end
  end
end
