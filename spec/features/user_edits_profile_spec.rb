# ## Edit profile
#
# As an artist,
# I want to add or change information on my profile,
# to better represent my work online.
#
# ** Usage: **
# * Sign in
# * On user dashboard, click link `Edit Profile`
# * Enter information for any/all fields
# * Click button `Save`
#
# ** Acceptance Criteria: **
# * Artist is currently logged in
# * Artist enters valid input for form fields
#   * valid bio should contain letters
#   * valid location should be correct address formatting (per field)
#   * valid profile photo should have PNG or JPG file extension

feature "User edits their profile" do

  background do
    @user = Fabricate(:user, email: "susanna@example.com", password: "password!")
    visit '/'
    click_link 'Sign in'
    fill_in "Email", with: "susanna@example.com"
    fill_in "Password", with: "password!"
    click_on 'Sign in'
  end

  scenario "Successful, columns added to database on save (without location)" do
    click_link 'Edit Profile'
    expect(current_path).to eq edit_profile_path
    expect(page).to have_field("First Name")
    expect(page).to have_field("Last Name")
    expect(page).to have_field("Bio")
    # expect(page).to have_unchecked_field("Photography")
    fill_in "First Name", with: "Susanna"
    fill_in "Last Name", with: "Jones"
    fill_in "Bio", with: "Susanna is interested in a myriad of topics, including photography and painting."
    # select "Photography"
    # check "Painting"
    attach_file 'Profile Picture', 'spec/support/data/susanna.jpg'
    click_on "Save Changes"
    expect(page).to have_content("Profile updated successfully.")
    expect(current_path).to eq profile_path
    expect(page).to have_content("Susanna is interested in a myriad of topics, including photography and painting.")
    find(".profile_picture")[:src].should include("susanna.jpg")
  end

  scenario "Sucessful, 1 change made" do
    click_link 'Edit Profile'
    fill_in "Bio", with: "Only modifying this field"
    click_on "Save Changes"
    expect(page).to have_content("Profile updated successfully")
    expect(current_path).to eq profile_path
    expect(page).to have_content("Only modifying this field")
  end

  scenario "Sucessful, no changes made" do
    click_link 'Edit Profile'
    click_on "Save Changes"
    expect(page).to have_content("Profile updated successfully")
    expect(current_path).to eq profile_path
    expect(page).to have_content("Email: susanna@example.com")
    expect(page).not_to have_error("must contain letters", on: "Bio")
  end

  scenario "Unsuccessful, bio contains no letters" do
    click_link 'Edit Profile'
    fill_in "Bio", with: "555-555-5555"
    click_on "Save Changes"
    expect(page).to have_content("Profile could not be updated. Please see below.")
    page.should have_error("must include letters", on: "Bio")
  end

  scenario "Invalid file type for photo upload" do
    click_link 'Edit Profile'
    attach_file 'Profile Picture', 'spec/support/data/susanna.pdf'
    click_on "Save Changes"
    expect(page).to have_content('You are not allowed to upload "pdf" files, allowed types: jpg, jpeg, gif, png')

  end


end
