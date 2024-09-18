# OurMaps API

### Setup

Start database
```sh
docker compose up
```

Install dependencies
```sh
bundle install
```

### Deploy app locally

```sh
ruby app.rb
```

### Run tests
```sh
bundle exec rspec
```

### Format your code
```sh
bundle exec rubocop -A
```
_*Install `rubocop` gem first_

## Database

### Setup
```sh
bundle exec rake db:environment:set
bundle exec rake db:setup
bundle exec rake db:migrate
```

### Create Migration
```sh
bundle exec rake db:create_migration NAME=[migration_name]
```