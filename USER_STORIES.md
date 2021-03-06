# User Types
* *Artist:* the users who are posting portfolios, ads, and trying to connect with other users to collaborate.

# Features
* User authentication (create account)
* User authentication (login)
* User resets password
* View profile
* Edit profile
* Add a new gallery
* Add photos to a gallery
* Create a new ad
* Edit an ad
* View all users
* Filter users by tag
* View all ads
* Filter ads by tag
* View all galleries
* View items in a gallery (need user story)
* Edit a gallery (need user story)
* Delete an item from a gallery (need user story)
* Delete a gallery (need user story)
* Send a specific artist your ad (need user story)
* Create a new active collaboration (need user story)
* View your (ad) invitations (need user story)
* View your collaborations (need user story)

* View another artist's collaboration (need user story)
* Follow an artist (need user story)
* Unfollow an artist (need user story)

# Stories

## User authentication (create account)

As an artist,
in order to network with other artists,
I want to create a new account.

** Usage: **
* On home page, click `Sign Up`
* Enter email, password, and password confirmation
* Artist is taken to their profile dashboard

** Acceptance Criteria: **
* Artist enters email, password, password confirmation
* Valid input to create a new user:
  * valid if present
  * valid if email is not a duplicate
  * valid if email format is an email
  * valid if passwords match
* Artist is saved to database in the User model

## User authentication (login)

As an artist,
I want my credentials to be authenticated
in order to login to my profile.

** Usage: **
* On home page, click `Sign In`
* Enter email and password
* Click `Sign In`

** Acceptance Criteria: **
* Artist enters email and password
* Valid input to authenticate user:
  * valid email should match an email in the database
  * valid password should match a password in the database
  * if an invalid email is provided, an error message will be displayed
  * if an invalid password is provided, an error message will be displayed
* Artist is taken to profile dashboard

## User resets password

As an artist,
I want to log back into my account with a new password,
because I have forgotten the old one.

** Usage: **
* On home page, click `Sign In`
* Click `Forgot your password?`
* Enter email address
* Click `Send me reset password instructions`

** Acceptance Criteria: **
* Artist enters valid email
  * valid email should match an email in the database
  * if an invalid email is provided, an error message will be displayed

## Edit profile

As an artist,
I want to add or change information on my profile,
to better represent my work online.

** Usage: **
* Sign in
* On user dashboard, click link `Edit Profile`
* Enter information for any/all fields, including First Name, Last Name, and Bio
* Select from Tags
* Attach a Profile Photo file you want to upload
* Click button `Save`

** Acceptance Criteria: **
* Artist is currently logged in
* Artist enters valid input for form fields
  * valid bio should contain letters
  * valid location should be correct address formatting (per field)
  * valid profile photo should have PNG or JPG file extension

## View profile

As an artist,
I want to view my profile,
to make sure it's looking good.

** Usage: **
* Sign in
* On user dashboard, click link `View Profile`

## Add a gallery

As an artist,
I want to create a new gallery,
to keep photos of my work organized and easy to navigate.

** Usage: **
* Sign in
* On user dashboard, click link `Create Gallery`
* Enter a title
* Click button `Create Gallery`

** Acceptance Criteria: **
* Artist is currently logged in
* Artist enters valid input for title
  * valid title must contain letters

## Add photos to a gallery

As an artist,
I want to add photos to a gallery I've already created,
in order to show off my talent.

** Usage: **
* Sign in
* On user dashboard, click link `Upload Photos`
* Upload an image file
* Enter a caption
* Select a gallery
* Click `Upload Photos`

** Acceptance Criteria: **
* Artist is currently logged in
* Artist uploads valid image file
  * valid photo file type should be .png, .jpg, .jpeg, or .gif
  * valid caption must contain letters
  * valid caption must be length < 30
  * valid if gallery selected

## Create a new ad

As an artist,
I want to create a new ad,
so that I can collaborate on a project with another artist.

** Usage: **
* Sign in
* On user dashboard, click link `New Ad`
* Enter a title, description, select tags, check `local only` (if applicable),
and upload a photo (optional),
* Click button `Create Ad`

** Acceptance Criteria: **
* Artist is currently logged in
* Artist enters valid input for form fields, including all required
  * title and description are required fields
  * valid title must contain letters
  * valid title must be length < 50
  * valid description must contain letters
  * valid description must be length < 500
  * valid photo file type should be .png, .jpg, .jpeg, or .gif

## Edit an ad

As an artist,
I want to edit an ad I've already created,
to better represent the project I want to collaborate on.

** Usage: **
* Sign in
* On user dashboard, click link `My Ads`
* Click a specific ad
* Click `Edit`
* Enter or change information for any of the form fields
* Click button `Create Ad`

** Acceptance Criteria: **
* Artist is currently logged in
* Artist is the creator of the ad they want to edit
* Artist enters valid input for form fields, including all required
  * title and description are required fields
  * valid title must contain letters
  * valid title must be length < 50
  * valid description must contain letters
  * valid description must be length < 500
  * valid photo file type should be .png, .jpg, .jpeg, or .gif

## View all users

As an artist,
I want to browse all the other artist users,
to look for someone I may want to collaborate with.

** Usage: **
* Sign in
* On user dashboard, click link `Users`

## Filter users by tag

As an artist,
I want to filter artists by tag
so I can quickly find relevant talent I may want to collaborate with.

** Usage: **
* Sign in
* Click `Users`
* Select `Painting` from Tags
* Click `Search`

## View all ads

As an artist,
I want to browse all the ads,
to look for someone already looking for collaboration.

** Usage: **
* Sign in
* On user dashboard, click link `Ads`

## Filter ads by tag

As an artist,
I want to filter ads by tag
so I can quickly find relevant projects I may want to collaborate on.

** Usage: **
* Sign in
* Click `Ads`
* Select `Painting` from Tags
* Click `Search`

## View all galleries

As an artist,
I want to browse all the galleries,
to look for inspiring talent.

** Usage: **
* Sign in
* On user dashboard, click link `Galleries`
