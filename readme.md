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
