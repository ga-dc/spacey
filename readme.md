# Spacey

## Local Setup

```
$ git clone git@github.com:ga-dc/spacey.git
$ cd spacey
$ bundle install
$ figaro install
$ rake db:create db:schema:load db:seed
```

- Visit https://console.developers.google.com and create a new application
- Under "Authorized Redirect URIs" add: http://localhost:3000/auth/google_oauth2/callback

in `config/application.yml`, add:

```yml
google_key: "your client id here"
google_secret: "your client secret here"
```

Start the server with `rails s`

## Contributing

Submit a pull request to this repository. Check out https://github.com/ga-dc/spacey/issues
if you're looking for something to work on

## Deployment

Deployment for this application is handled via jenkins at http://ci.wdidc.org/job/spacey/

Any push/pull request to this repository will trigger a build. If all the tests pass,
Jenkins will push code to production server and restart the rails application.
