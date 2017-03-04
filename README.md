## Getting started

Clone the repo:
`$ git clone https://github.com/svpersteve/wlcrails.git`

Change directory into the app:
`$ cd wlcrails`

Install gems the app depends on:
`$ bundle install`

Start a server:
`$ rails server`

## Database config

Rename config/database.example.yml to config/database.yml and configure to your local details.

Setup the database locally:
`$ bundle exec rake db:setup`

Download a copy of production database:
`$ bundle exec rake db:pull`

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

Make your changes, then push the branch:
`$ git push -u origin sb-my-branch`

Run the tests and make sure your changes didn't cause any to fail:
`$ bundle exec rake`

You can run tests individually using spring to make it faster:
`$ spring rspec path/to/spec/file`

Send Steve a link or make a pull request.

## Visual Database Editor

You can use Postico for a visual database editor, this is really helpful for more easily understanding the data.

You should only do this on your local database unless you really need to change something on production, as deleting data is permanent.

To access the production database with it, install the Heroku Postico plugin:

`heroku plugins:install heroku-postico`

And open it while in the `wlcrails` directory (if it has the Heroku app remote):

`heroku postico:open`
