## West London Coders

This is the Rails app and main website for West London Coders.

The protected master branch auto-deploys to Heroku.

If you'd like to contribute, please open a pull request.

## Cloning locally

You'll need the following installed:
* Ruby, via a [Ruby version manager](https://github.com/rbenv/rbenv)
* [Rails](http://installrails.com/steps/choose_os)
* [Postgres](https://wiki.postgresql.org/wiki/Detailed_installation_guides)

You'll also need:

* An AWS access key and secret from [Steve](https://westlondoncoders.com/members/steve-brewer)

Clone the repo:
`$ git clone https://github.com/svpersteve/wlcrails.git`

Change directory into the app:
`$ cd wlcrails`

Install gems the app depends on:
`$ bundle install`

Initialise the databases:

`$ bundle exec rake db:create`

Start the server:
`$ rails server`

## Database config

To download a copy of the production database, you need to have Heroku access.

Download a copy of production database:
`$ bundle exec rake get_database`

If you have any issues connecting to the database, [this](http://stackoverflow.com/questions/26447736/unable-to-connect-to-postgresql-database-after-upgrading-to-yosemite-10-10/26458194#26458194) might help.

## Setup GitHub omniauth so you can login to the site locally

Create an app on GitHub here: https://github.com/settings/applications/new

Use these values:

Homepage URL:  http://localhost:3000
Authorization Callback URL:  http://localhost:3000/auth/github

Create a file in your wlcrails directory called `.env`

Enter the following, rreplacing them with the real values GitHub gives you:

```
GITHUB_KEY=YOUR_KEY
GITHUB_SECRET=YOUR_SECRET
```

## Contributing

Make a new branch prefixed with your initials:
`$ git checkout -b sb-my-branch`

Make your changes, then run the tests and make sure your changes didn't cause any to fail and you don't have any lint/rubocop issues:
`$ bundle exec rake`

You can run tests individually using spring:
`$ spring rspec path/to/spec/file`

Then push the branch:
`$ git push -u origin sb-my-branch`

Send Steve a link or make a pull request.

## Visual Database Editor

You can use Postico for a visual database editor, this is really helpful for more easily understanding the data.

You should only do this on your local database unless you really need to change something on production, as deleting data is permanent.

To access the production database with it, install the Heroku Postico plugin:

`heroku plugins:install heroku-postico`

And open it while in the `wlcrails` directory (if it has the Heroku app remote):

`heroku postico:open`
