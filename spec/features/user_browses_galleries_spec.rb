# ## View all galleries
#
# As an artist,
# I want to browse all the galleries,
# to look for inspiring talent.
#
# ** Usage: **
# * Sign in
# * On user dashboard, click link `Galleries`

feature "User browses galleries" do

  background do
    @user1 = Fabricate(:user, email: "bob@example.com", password: "password!", first_name: "Bob", last_name: "Jones", bio: "Hi there")
    @user2 = Fabricate(:user, first_name: "Julie", last_name: "Smith", bio: "I've been painting for 10 years")
    @user3 = Fabricate(:user, first_name: "Mike", last_name: "Johnson", bio: "Photography is my jam")
    @gallery1 = Fabricate(:gallery, title: "Watercolor Paintings", description: "Landscapes & Cityscapes", user: @user1)
    @gallery2 = Fabricate(:gallery, title: "Seaside Paintings", description: "We love to visit the OBx in North Carolina", user: @user2)
    @gallery3 = Fabricate(:gallery, title: "Film Photography", description: "All shot on 35mm", user: @user3)

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
      click_on 'Galleries'
    end
  end

  scenario "should render all the galleries" do
    expect(page).to have_content("Watercolor Paintings")
    expect(page).to have_content("Seaside Paintings")
    expect(page).to have_content("Film Photography")
    expect(current_path).to eq galleries_path
  end
end
