## Database config

Rename config/database.example.yml to config/database.yml and configure to your local details.

## Import Production Database

Use the Heroku pg:pull to import the latest version of the database.

If a database called wlc already exists, you'll need to delete it first as it won't overwrite an existing database. Or rename the database your local app uses in database.yml to something else, then specify that new name in the pg:pull command:

`heroku pg:pull DATABASE_URL wlc`

## Visual Database Editor

You can use Postico for a visual database editor.

To access the production database with it, install the Heroku Postico plugin:

`heroku plugins:install heroku-postico`

And open it while in your Watercooler directory (if it has the Heroku app remote):

`heroku postico:open`
