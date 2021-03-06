# As an artist,
# in order to network with other artists,
# I want to create a new account.
#
# ** Usage: **
# 1. On home page, click `Sign Up`
# 2. Artist enters email, password, and password confirmation
# 3. Artist is taken to their profile dashboard
#
# ** Acceptance Criteria: **
# * Artist enters email, password, password confirmation
# * Valid input to create a new user:
#   * valid if present
#   * valid if email is not a duplicate
#   * valid if email format is an email
#   * valid if passwords match
# * Artist is saved to database in the Artist model

feature "User signs up" do

  background do
    visit '/'
    within(".show-for-medium-up") do
      click_link 'Sign up'
    end
  end

  scenario "Successful sign up and subsequent sign in" do
    expect(current_path).to eq new_user_registration_path
    Capybara.exact = true
    fill_in "* Email", with: "rachel@example.com"
    fill_in "* Password", with: "password!"
    fill_in "* Password confirmation", with: "password!"
    Capybara.exact = false
    click_button "Sign up"
    expect(page).to have_content("Welcome, rachel@example.com!")
    expect(page).not_to have_link("Sign up")
    expect(page).not_to have_link("Sign in")

    user = User.last
    expect(user.email).to eq "rachel@example.com"
    within(".show-for-medium-up") do
      click_link 'Sign out'
    end
    within(".show-for-medium-up") do
      click_link 'Sign in'
    end
    fill_in "Email", with: "rachel@example.com"
    fill_in "Password", with: "password!"
    within(".form-actions") do
      click_on 'Sign in'
    end
    expect(page).to have_content("Welcome, rachel@example.com!")
  end

  scenario "Skipped email and password" do
    click_button "Sign up"
    expect(page).to have_content("Please review the problems below")
    expect(page).to have_error("can't be blank", on: "Email")
    expect(page).to have_error("can't be blank", on: "Password")
  end

  scenario "Skipped password confirmation" do
    expect(current_path).to eq new_user_registration_path
    Capybara.exact = true
    fill_in "* Email", with: "rachel@example.com"
    fill_in "* Password", with: "password!"
    Capybara.exact = false
    click_button "Sign up"
    expect(page).to have_error("doesn't match Password", on: "Password confirmation")
  end
end
