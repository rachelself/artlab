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
    @tag_painting = Fabricate(:tag, name: "Painting")
    @tag_photography = Fabricate(:tag, name: "Photography")
    visit '/'
    within(".show-for-medium-up") do
      click_link 'Sign in'
    end
    fill_in "Email", with: "susanna@example.com"
    fill_in "Password", with: "password!"
    within(".form-actions") do
      click_on 'Sign in'
    end
    click_link 'Edit Profile'
  end

  scenario "Successful, columns added to database on save (without location)" do
    expect(current_path).to eq edit_profile_path
    expect(page).to have_field("user_first_name")
    expect(page).to have_field("user_last_name")
    expect(page).to have_field("user_bio")
    fill_in "user_first_name", with: "Susanna"
    fill_in "user_last_name", with: "Jones"
    fill_in "user_bio", with: "Susanna is interested in a myriad of topics, including photography and painting."
    select("Photography", from: "user_tag_ids")
    select("Painting", from: "user_tag_ids")
    attach_file 'user_profile_image', 'spec/support/data/susanna.jpg'
    click_on "Save Changes"
    expect(page).to have_content("Profile updated successfully.")
    expect(current_path).to eq profile_path
    expect(page).to have_content("Susanna is interested in a myriad of topics, including photography and painting.")
    find(".profile_picture")[:src].should include("susanna.jpg")

    expect(ArtistTag.count).to eq 2
    expect(page).to have_content("Photography")
    expect(page).to have_content("Painting")
  end

  scenario "Sucessful, 1 change made" do
    fill_in "Bio", with: "Only modifying this field"
    click_on "Save Changes"
    expect(page).to have_content("Profile updated successfully")
    expect(current_path).to eq profile_path
    expect(page).to have_content("Only modifying this field")
  end

  scenario "Sucessful, no changes made" do
    click_on "Save Changes"
    expect(page).to have_content("Profile updated successfully")
    expect(current_path).to eq profile_path
    expect(page).to have_content("Email: susanna@example.com")
    expect(page).not_to have_error("must contain letters", on: "Bio")
  end

  scenario "Successful, old tags dropped" do
    select("Photography", from: "user_tag_ids")
    click_on "Save Changes"
    click_link 'Edit Profile'
    select("Painting", from: "user_tag_ids")
    click_on "Save Changes"
    expect(page).to have_content("Profile updated successfully.")
    expect(current_path).to eq profile_path
    expect(page).to have_content("Painting")
  end

  scenario "Unsuccessful, bio contains no letters" do
    fill_in "user_bio", with: "555-555-5555"
    click_on "Save Changes"
    expect(page).to have_content("Profile could not be updated. Please see below.")
    page.should have_content("must include letters")
  end

  scenario "Invalid file type for photo upload" do
    attach_file 'user_profile_image', 'spec/support/data/susanna.pdf'
    click_on "Save Changes"
    expect(page).to have_content('You are not allowed to upload "pdf" files, allowed types: jpg, jpeg, gif, png')
  end
end
