# ## Create a new ad
#
# As an artist,
# I want to create a new ad,
# so that I can collaborate on a project with another artist.
#
# ** Usage: **
# * Sign in
# * On user dashboard, click link `New Ad`
# * Enter a title, description, select tags, check `local only` (if applicable),
# and upload a photo (optional),
# * Click button `Publish Ad`
#
# ** Acceptance Criteria: **
# * Artist is currently logged in
# * Artist enters valid input for form fields, including all required
#   * title, description, and tags are required fields
#   * valid title must contain letters
#   * valid title must be length < 50
#   * valid description must contain letters
#   * valid description must be length < 500
#   * valid photo file type should be .png, .jpg, .jpeg, or .gif

feature "User creates a new ad" do

  background do
    @user = Fabricate(:user, email: "sally@example.com", password: "password!")
    @tag_book = Fabricate(:tag, name: "Bookmaking")
    @tag_paper = Fabricate(:tag, name: "Papermaking")
    @tag_callig = Fabricate(:tag, name: "Calligraphy")
    visit '/'
    within(".show-for-medium-up") do
      click_link 'Sign in'
    end
    fill_in "Email", with: "sally@example.com"
    fill_in "Password", with: "password!"
    within(".form-actions") do
      click_on 'Sign in'
    end
    click_link 'New Ad'
  end

  scenario "Successful, ad saved to the database with minimum required fields" do
    fill_in "Title", with: "Bookmaker seeking paper maker"
    fill_in "Description", with: "I make handmade books and I'm seeking someone with an expertise in fine paper making. I prefer to work with handmade papers that have a bit of tooth to them, like a fine drawing paper, but that are more substantial than any of the Japanese variety."
    select("Papermaking", from: "ad_tag_ids")
    expect(current_path).to eq new_ad_path
    click_on "Create Ad"
    expect(page).to have_content("Your ad was successfully published.")
    expect(page).to have_content("Bookmaker seeking paper maker")
    expect(page).to have_link("Edit")
  end

  scenario "Successful, ad saved to the database with ALL fields" do
    fill_in "Title", with: "Bookmaker seeking paper maker"
    fill_in "Description", with: "I make handmade books and I'm seeking someone with an expertise in fine paper making. I prefer to work with handmade papers that have a bit of tooth to them, like a fine drawing paper, but that are more substantial than any of the Japanese variety."
    select("Papermaking", from: "ad_tag_ids")
    attach_file "ad_project_photo", 'spec/support/data/book_project_1.jpg'
    choose "ad_local_only_true"
    click_on "Create Ad"
    expect(page).to have_content("Your ad was successfully published.")
    expect(page).to have_content("Local Only")
    expect(page).to have_link("Edit")
    find(".project_photo")[:src].should include("book_project_1.jpg")
  end

  scenario "Unsuccessful, skipped required field" do
    fill_in "Description", with: "I make handmade books and I'm seeking someone with an expertise in fine paper making. I prefer to work with handmade papers that have a bit of tooth to them, like a fine drawing paper, but that are more substantial than any of the Japanese variety."
    select("Papermaking", from: "ad_tag_ids")
    click_on "Create Ad"
    expect(page).to have_content("Your ad could not be published. See below for errors.")
    expect(page).to have_content("can't be blank")
    expect(page).to have_button("Create Ad")
  end

  scenario "Unsuccessful, blank form" do
    click_on "Create Ad"
    expect(page).to have_content("Your ad could not be published. See below for errors.")
    expect(page).to have_content("can't be blank")
    expect(page).to have_button("Create Ad")
  end

end
