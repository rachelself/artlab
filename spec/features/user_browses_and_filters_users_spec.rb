# ## View all users
#
# As an artist,
# I want to browse all the other artist users,
# to look for someone I may want to collaborate with.
#
# ** Usage: **
# * Sign in
# * On user dashboard, click link `Users`
#
# ## Search users by tag
#
# As an artist,
# I want to filter artists by tag
# so I can quickly find relevant talent I may want to collaborate with.
#
# ** Usage: **
# * Sign in
# * Click `Users`
# * Select `Painting` from Tags
# * Click `Search`

feature "User searches users" do

  background do
    @user1 = Fabricate(:user, email: "bob@example.com", password: "password!", first_name: "Bob", last_name: "Jones", bio: "Hi there")
    @user2 = Fabricate(:user, first_name: "Julie", last_name: "Smith", bio: "I've been painting for 10 years")
    @user3 = Fabricate(:user, first_name: "Mike", last_name: "Johnson", bio: "Photography is my jam")
    @tag_fibers = Fabricate(:tag, name: "Fibers")
    @tag_painting = Fabricate(:tag, name: "Painting")
    @tag_photography = Fabricate(:tag, name: "Photography")
    # Bob is tagged Painting
    @artist_tag1 = Fabricate(:artist_tag, user: @user1, tag: @tag_painting)
    # Julie is tagged Painting
    @artist_tag2 = Fabricate(:artist_tag, user: @user2, tag: @tag_painting)
    # Mike is tagged Photography
    @artist_tag3 = Fabricate(:artist_tag, user: @user3, tag: @tag_photography)

    visit '/'
    within(".show-for-medium-up") do
      click_link 'Sign in'
    end
    fill_in "Email", with: "bob@example.com"
    fill_in "Password", with: "password!"
    within(".form-actions") do
      click_on 'Sign in'
    end
    within(".show-for-medium-up") do
      click_on 'Artists'
    end
  end

  scenario "should render all the users" do
    expect(page).to have_content("Julie Smith")
    expect(page).to have_content("Mike Johnson")
    expect(page).to have_content("Bob Jones")
    expect(current_path).to eq users_path
  end

  scenario "should render the 1 user tagged as Photography" do
    select("Photography", from: "filter[tag_id]")
    click_on "Search"
    expect(page).not_to have_content("Julie Smith")
    expect(page).not_to have_content("Bob Jones")
    expect(page).to have_content("Mike Johnson")
    expect(current_path).to eq users_path
  end

  scenario "shouldn't render any users, tagged as Fibers" do
    select "Fibers"
    click_on "Search"
    expect(page).to have_content("No users found.")
    expect(page).not_to have_content("Mike Johnson")
    expect(page).not_to have_content("Julie Smith")
    expect(page).not_to have_content("Bob Jones")
    expect(current_path).to eq users_path
  end

end
