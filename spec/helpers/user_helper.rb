def sign_in(email:"test@test.com", password:"password")
  visit '/restaurants'
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password
  click_button 'Sign up'
end

def sign_out
  click_link 'Sign out'
end

def add_restaurant(name: 'KFC')
  visit '/restaurants'
  click_link 'Add a restaurant!'
  fill_in 'Name', with: name
  click_button 'Create Restaurant'
end
