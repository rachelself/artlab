feature "User adds a new gallery" do

  background do
    @user = Fabricate(:user, email: "painter@gmail.com", password: "password!")
    visit '/'
    click_link 'Sign in'
    fill_in "Email", with: "painter@gmail.com"
    fill_in "Password", with: "password!"
    click_on 'Sign in'
    click_link 'Create Gallery'
  end

  scenario "Successful, gallery saved to database" do
    fill_in "Title", with: "Paintings"
    # select "Painting"
    expect(current_path).to eq new_gallery_path
    click_on "Create Gallery"
    expect(page).to have_content("Paintings gallery has been created.")
    expect(page).to have_button("Add Photos")
    expect(page).to have_content("You have no photos in this gallery.")
  end

  scenario "Unsuccessful, skipped title" do
    pending "implementation"
    select "Painting"
    click_on "Create Gallery"
    expect(current_path).to eq new_gallery_path
    expect(page).to have_content("Gallery could not be created. See below for errors.")
    expect(page).to have_error("can't be blank", on: "Title")
  end

  scenario "Unsuccessful, skipped tags" do
    pending "implementation"
    fill_in "Title", with: "Paintings"
    click_on "Create Gallery"
    expect(current_path).to eq new_gallery_path
    expect(page).to have_content("Gallery could not be created. See below for errors.")
    expect(page).to have_error("must select at least one", on: "Tags")
  end

  scenario "Unsuccessful, blank form" do
    click_on "Create Gallery"
    expect(page).to have_content("Gallery could not be created. See below for errors.")
    expect(page).to have_error("can't be blank", on: "Title")
    # expect(page).to have_error("must select at least one", on: "Tags")
  end

end
