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
rspec
```

### Format your code
```sh
rubocop -A
```
_*Install `rubocop` gem first_

## Database

### Setup
```sh
rake db:environment:set
rake db:setup
rake db:migrate
```

### Create Migration
```sh
rake db:create_migration NAME=[migration_name]
```