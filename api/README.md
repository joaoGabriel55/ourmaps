# README

## Setup
Start database container
```bash
docker compose up -d
```

Setup database
```bash
rails db:create db:migrate
```

## Run server
```bash
rails s
```

## Run tests
All tests
```bash
rspec
```

Single test. e.g.:
```bash
rspec spec/models/user_spec.rb
```
