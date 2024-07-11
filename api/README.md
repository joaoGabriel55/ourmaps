# OurMaps API

### Deploy app locally
```sh
docker compose up --build
```

### Run tests
```sh
docker compose run --build web rspec
```

### Format your code
```sh
rubocop -A
```
_*Install `rubocop` gem first_

## Database

### Setup
```sh
docker compose run --build web rake db:environment:set
docker compose run --build web rake db:setup
docker compose run --build web rake db:migrate
```

### Create Migration
```sh
docker compose run --build web rake db:create_migration NAME=[migration_name]
```