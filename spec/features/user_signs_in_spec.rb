# ## User authentication (login)
#
# As an artist,
# I want my credentials to be authenticated
# in order to login to my profile.
#
# ** Usage: **
# 1. On home page, click `Sign In`
# 2. On modal, artist enters email and password
# 3. Click `Sign In`
#
# ** Acceptance Criteria: **
# * Artist enters email and password
# * Valid input to authenticate user:
#   * valid email should match an email in the database
#   * valid password should match a password in the database
#   * if an invalid email is provided, an error message will be displayed
#   * if an invalid password is provided, an error message will be displayed
# * Artist is taken to profile dashboard

feature "User signs in" do

  background do
    Fabricate(:user, email: "bobo@example.com", password: "password!")
  end

  scenario "with the correct credentials" do
    visit '/'
    click_link 'Sign in'
    fill_in "Email", with: "bobo@example.com"
    fill_in "Password", with: "password!"
    click_on 'Sign in'
    expect(page).to have_content("Welcome, bobo@example.com!")
    expect(page).not_to have_link("Sign up")
    expect(page).not_to have_link("Sign in")
    expect(page).to have_link("Sign out")
    expect(current_path).to eq dashboard_path
  end

  scenario "with an email that hasn't been registered" do
    visit '/'
    click_link 'Sign in'
    fill_in "Email", with: "brand_new@example.com"
    fill_in "Password", with: "password!"
    click_on 'Sign in'
    expect(page).to have_content("We don't have that email address registered in our system.")
    expect(page).not_to have_link("Sign out")
    expect(current_path).to eq new_user_session_path
    expect(field_labeled("Email")[:value]).to include("brand_new@example.com")
    expect(field_labeled("Password")[:value]).to be_blank
  end

  scenario "with a blank form" do
    visit '/'
    click_link 'Sign in'
    click_on 'Sign in'
    expect(page).to have_content("Invalid email or password.")
    expect(page).not_to have_link("Sign out")
    expect(current_path).to eq new_user_session_path
  end

  scenario "with an incorrect password" do
    visit '/'
    click_link 'Sign in'
    fill_in "Email", with: "bobo@example.com"
    fill_in "Password", with: "notmypassword"
    click_on 'Sign in'
    expect(page).not_to have_content("Welcome, bobo@example.com!")
    expect(page).not_to have_link("Sign out")
    expect(page).to have_content("Invalid email or password.")
    expect(current_path).to eq new_user_session_path
    expect(field_labeled("Email")[:value]).to include("bobo@example.com")
    expect(field_labeled("Password")[:value]).to be_blank

  end
end
