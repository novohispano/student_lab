# StudentLab

StudentLab is a student CRM app built for JumpstartLab. You can keep track of the interactions that your instructors have with your students, and easily create one-on-one sessions, assessments and evaluations.

## Setup

1. Clone this repo.
2. Run bundle install
3. Run rake db:create
4. Register the application [on GitHub](https://github.com/settings/applications/new) to obtain oauth keys
   The authorization callback url is **http://localhost:3000/auth/github/callback**
5. Copy /config/application.yml.example to /config/application.yml
6. Add your GitHub OAuth keys to /config/application.yml
7. Enjoy.

StudentLab runs on MongoDB, so you won't need to migrate anything.

## Ruby / Rails

This app was built on Ruby 2.0 and Rails 4.0 by Jorge Téllez at gSchool.