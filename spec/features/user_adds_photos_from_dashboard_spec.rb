# ## Add gallery items
#
# As an artist,
# I want to add photos to a gallery I've already created,
# in order to show off my talent.
#
# ** Usage: **
# * Sign in
# * On user dashboard, click link `Galleries`
# * Click link `Add Photos`
# * Upload an image file
# * Enter a caption
# * Click `Add Another Photo`
# * Upload an image file
# * Enter a caption
# * Click `Save`
#
# ** Acceptance Criteria: **
# * Artist is currently logged in
# * Artist uploads valid image file
#   * valid photo file type should be .png, .jpg, .jpeg, or .gif
#   * valid caption must contain letters
#   * valid caption must be length < 30

feature "User adds photos to a gallery from dashboard" do
  background do
    @user = Fabricate(:user, email: "pierre@example.com", password: "password!")
    @gallery1 = Fabricate(:gallery, title: "Sculpture", user: @user)
    @gallery2 = Fabricate(:gallery, title: "Painting", user: @user)
    visit '/'
    within(".show-for-medium-up") do
      click_link 'Sign in'
    end
    fill_in "Email", with: "pierre@example.com"
    fill_in "Password", with: "password!"
    within(".form-actions") do
      click_on 'Sign in'
    end
    click_on 'Upload Photos'
  end

  scenario "Successful, photo record saved" do
    pending "implementation"
    attach_file 'Image', 'spec/support/data/book_project_1.jpg'
    fill_in 'Caption', with: "Abstract expressionism at its best."
    select 'Painting'
    click_on "Upload Photos"
    expect(page).to have_content("Photos uploaded successfully.")
    find(".gallery_photo")[:src].should include("book_project_1.jpg")
    expect(page).to have_content("Abstract expressionism at its best.")
  end

  scenario "Successful, photo with no caption" do
    attach_file 'Image', 'spec/support/data/book_project_1.jpg'
    select 'Painting'
    click_on "Upload Photos"
    expect(page).to have_content("Photos uploaded successfully.")
    find(".gallery_photo")[:src].should include("book_project_1.jpg")
    expect(page).not_to have_content("Abstract expressionism at its best.")
  end

  scenario "Unsuccessful, invalid photo format" do
    pending "implementation"
    attach_file 'Image', 'spec/support/data/susanna.pdf'
    select 'Painting'
    fill_in 'Caption', with: "Abstract expressionism at its best."
    click_on "Upload Photos"
    expect(page).to have_content("Photos could not be uploaded. Please see errors below.")
    expect(page).to have_content('You are not allowed to upload "pdf" files, allowed types: jpg, jpeg, gif, png')
  end

  scenario "Unsuccessful, no photo uploaded" do
    pending "implementation"
    fill_in 'Caption', with: "Abstract expressionism at its best."
    select 'Painting'
    click_on "Upload Photos"
    expect(page).to have_content("Photos could not be uploaded. Please see errors below.")
    expect(page).to have_content("must upload at least one photo")
  end

  scenario "Unsuccessful, no gallery chosen" do
    pending "implementation"
    attach_file 'Image', 'spec/support/data/book_project_1.jpg'
    fill_in 'Caption', with: "Abstract expressionism at its best."
    click_on "Upload Photos"
    expect(page).to have_content("Photos could not be uploaded. Please see errors below.")
    expect(page).to have_content("must choose a gallery")
  end
end
