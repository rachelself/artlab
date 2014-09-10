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
  scenario "Successful sign up and subsequent sign in" do
    visit '/'
    click_link "Sign Up"
    current_path.should == new_user_registration_path
    fill_in "Email", with: "rachel@example.com"
    fill_in "Password", with: "password!"
    fill_in "Password Confirmation", with: "password!"
    click_button "Create Account"
    current_path.should == user_registration_path
    page.should have_content("Welcome, rachel@example.com")
    page.should_not have_content("Sign Up")
    page.should_not have_content("Sign In")

    click_link "Sign Out"
    current_path.should == new_user_session_path
    fill_in "Email", with: "rachel@example.com"
    fill_in "Password", with: "password!"
    click_button "Sign In"
    page.should have_content("Welcome back, rachel@example.com")
  end

  scenario "Skipped email and password" do
    visit '/'
    click_link "Sign Up"
    click_button "Create Account"
    page.should have_content("Your account could not be created.")
    page.should have_error("can't be blank", on: "Email")
    page.should have_error("can't be blank", on: "Password")
  end
end
