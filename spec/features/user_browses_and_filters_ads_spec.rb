# ## View all ads
#
# As an artist,
# I want to browse all the ads,
# to look for someone already looking for collaboration.
#
# ** Usage: **
# * Sign in
# * On user dashboard, click link `Projects`
#
# ## Filter ads by tag
#
# As an artist,
# I want to filter ads by tag
# so I can quickly find relevant projects I may want to collaborate on.
#
# ** Usage: **
# * Sign in
# * Click `Projects`
# * Select `Painting` from Tags
# * Click `Search`

feature "User searches ads" do

  background do
    @user1 = Fabricate(:user, email: "bob@example.com", password: "password!", first_name: "Bob", last_name: "Jones", bio: "Hi there")
    @user2 = Fabricate(:user, first_name: "Julie", last_name: "Smith", bio: "I've been painting for 10 years")
    @user3 = Fabricate(:user, first_name: "Mike", last_name: "Johnson", bio: "Photography is my jam")
    @tag_fibers = Fabricate(:tag, name: "Fibers")
    @tag_painting = Fabricate(:tag, name: "Painting")
    @tag_photography = Fabricate(:tag, name: "Photography")
    @ad1 = Fabricate(:ad, title: "Seeking Photographer", description: "I would love to collaborate on a photoshoot", user: @user3)
    @ad2 = Fabricate(:ad, title: "Seeking Painter", description: "I would love to collaborate on a painting", user: @user2)
    # ad1 is tagged Photography
    @ad_tag1 = Fabricate(:ad_tag, ad: @ad1, tag: @tag_photography)
    # ad2 is tagged Painting
    @ad_tag2 = Fabricate(:ad_tag, ad: @ad2, tag: @tag_painting)

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
      click_on 'Projects'
    end
  end

  scenario "should render all the ads" do
    expect(page).to have_content("Seeking Photographer")
    expect(page).to have_content("Seeking Painter")
    expect(current_path).to eq ads_path
  end

  scenario "should render the 1 ad tagged as Painting" do
    select("Painting", from: "filter[tag_id]")
    click_on "Search"
    expect(page).to have_content("Seeking Painter")
    expect(page).not_to have_content("Seeking Photographer")
    expect(current_path).to eq ads_path
  end

  scenario "shouldn't render any ads, tagged as Fibers" do
    select("Fibers", from: "filter[tag_id]")
    click_on "Search"
    expect(page).to have_content("No ads found.")
    expect(page).not_to have_content("Seeking Painter")
    expect(page).not_to have_content("Seeking Photographer")
    expect(page).not_to have_content("Julie Smith")
    expect(page).not_to have_content("Mike Johnson")
    expect(current_path).to eq ads_path
  end

end
