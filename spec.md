# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
    --ApplicationController inherits from Sinatra
- [x] Use ActiveRecord for storing information in a database
    --Users and Pets migration classes and their corresponding model class inherit from ActiveRecord
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
    --Created a user and pet model
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
    --A user has many pets
- [x] Include user accounts
    --A user can login, signup, and logout. Each user also has their own profile page.
- [x] Ensure that users can't modify content created by other users
    --A user can't view another user's profile. When a user views a different user's pet, the pet's modify and delete links do not appear.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
    --A pet, which belongs to a user, can be created, viewed, modified, and deleted.
- [x] Include user input validations
    --For user signup, input fields are required, must meet a certain amount of characters, and a username already in the
    database can't be used. For pet creation, all input fields are also required, and a pet name already in the database can't be used.
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
    --If a username or pet name is already taken, a flash mesage appears.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
