# ## Edit an ad
#
# As an artist,
# I want to edit an ad I've already created,
# to better represent the project I want to collaborate on.
#
# ** Usage: **
# * Sign in
# * On user dashboard, click link `My Ads`
# * Click a specific ad
# * Click `Edit`
# * Enter or change information for any of the form fields
# * Click button `Create Ad`
#
# ** Acceptance Criteria: **
# * Artist is currently logged in
# * Artist is the creator of the ad they want to edit
# * Artist enters valid input for form fields, including all required
#   * title and description are required fields
#   * valid title must contain letters
#   * valid title must be length < 50
#   * valid description must contain letters
#   * valid description must be length < 500
#   * valid photo file type should be .png, .jpg, .jpeg, or .gif

feature "User edits an ad" do

  background do
    @user = Fabricate(:user, email: "cat@example.com", password: "password!")
    @tag = Fabricate(:tag, name: "Fibers")
    @ad = Fabricate(:ad, title: "Seeking Book artist", description: "Wanting to  work with a book lover to collaborate on an installation!", user: @user)
    @ad2 = Fabricate(:ad, title: "Seeking Fiber artist", description: "Wanting to  work with a fiber lover to collaborate on an installation!", user: @user)
    @ad_tag = Fabricate(:ad_tag, tag_id: @tag, ad_id: @ad2)

    visit '/'
    click_link 'Sign in'
    fill_in "Email", with: "cat@example.com"
    fill_in "Password", with: "password!"
    click_on 'Sign in'
    click_on 'Seeking Fiber artist'
    click_on 'Edit'
  end

  scenario "Successful - only required fields" do
    expect(current_path).to eq edit_ad_path(@ad2)
    expect(page).to have_unchecked_field("ad_local_only")
    fill_in 'Title', with: "Seeking fibers specialist"
    fill_in 'Description', with: "I'm working on an installation for the opening of the new downtown arts center. Looking for someone to collaborate with to create something awesome!"
    click_on 'Save Changes'
    expect(page).to have_content("Your ad was updated successfully.")
    expect(page).to have_content("Seeking fibers specialist")
    expect(page).not_to have_content("Seeking Fiber artist")
  end

  scenario "Successful - all fields, subsequent re-edit has placeholders" do
    expect(current_path).to eq edit_ad_path(@ad2)
    fill_in 'Title', with: "Seeking fibers specialist"
    fill_in 'Description', with: "I'm working on an installation for the opening of the new downtown arts center. Looking for someone to collaborate with to create something awesome!"
    attach_file 'Project Photo', 'spec/support/data/project_photo_example.jpg'
    select 'Fibers'
    check "ad_local_only"
    click_on 'Save Changes'
    expect(page).to have_content("Your ad was updated successfully.")
    expect(page).to have_content("Seeking fibers specialist")
    expect(page).not_to have_content("Seeking Fiber artist")
    find(".project_photo")[:src].should include("project_photo_example.jpg")

    click_on 'Edit'
    expect(page).to have_field("Title", :with => "Seeking fibers specialist")
    expect(page).to have_field("Description", :with => "I'm working on an installation for the opening of the new downtown arts center. Looking for someone to collaborate with to create something awesome!")
    page.has_select?("Tags", :selected => "Fibers")
    expect(page).to have_checked_field("ad_local_only")
  end

  scenario "Successful - no changes" do
    click_on 'Save Changes'
    expect(page).to have_content("Your ad was updated successfully.")
    expect(page).to have_content("Seeking Fiber artist")
    expect(page).to have_content("Wanting to  work with a fiber lover to collaborate on an installation!")
  end

  scenario "Successful - photo is not deleted from record" do
    attach_file 'Project Photo', 'spec/support/data/project_photo_example.jpg'
    click_on 'Save Changes'
    click_on 'Edit'
    click_on 'Save Changes'
    find(".project_photo")[:src].should include("project_photo_example.jpg")

  end

  scenario "Successful - removing tags deletes all ad_tag records" do
    expect(current_path).to eq edit_ad_path(@ad2)
    unselect('Fibers')
    click_on 'Save Changes'
    expect(page).to have_content("Your ad was updated successfully.")
    expect(page).to have_content("Seeking Fiber artist")
    page.find(".tags").should_not have_content("Fibers")
    expect(current_path).to eq ad_path(@ad2)
  end

  scenario "Successful - removes photo" do
    attach_file 'Project Photo', 'spec/support/data/project_photo_example.jpg'
    click_on 'Save Changes'
    click_on 'Edit'

    expect(current_path).to eq edit_ad_path(@ad2)
    check "Remove project photo"
    click_on "Save Changes"
    expect(page).to have_content("Your ad was updated successfully.")
    find(".project_photo")[:src].should include("default.png")
  end

  scenario "Unsuccessful - missing required fields" do
    expect(current_path).to eq edit_ad_path(@ad2)
    fill_in 'Title', with: ""
    fill_in 'Description', with: ""
    click_on 'Save Changes'
    expect(page).to have_content("Your ad could not be updated. See below for errors.")
    expect(page).to have_error("can't be blank", on: "Title")
    expect(page).to have_error("can't be blank", on: "Description")
  end

end
