# User Types
* *Artist:* the users who are posting portfolios, ads, and trying to connect with other users to collaborate.

# Features
* User authentication (create account)
* User authentication (login)
* User resets password
* Edit profile
* Add a new gallery (need user story)
* Add new items to a gallery (need user story)
* View items in a gallery (need user story)
* Edit a gallery (need user story)
* Delete an item from a gallery (need user story)
* Delete a gallery (need user story)
* Create a new invitation to collaborate (need user story)
* Send a specific artist your invitation (need user story)
* Create a new active collaboration (need user story)
* View your invitations (need user story)
* View your collaborations (need user story)
* View all invitations (need user story)
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
* Enter information for any/all fields
* Click button `Save`

** Acceptance Criteria: **
* Artist is currently logged in
* Artist enters valid input for form fields
  * valid bio should contain letters
  * valid location should be correct address formatting (per field)
  * valid profile photo should have PNG or JPG file extension
