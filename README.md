# Cryptodry
Roda + dry-rb architecture showcase on example of a fictional crypto-transactional service.


## Setup
`bundle`

`dotenv -f .env bundle exec rake db:setup`

`dotenv -f .env.test bundle exec rake db:setup`


## Start server
`dotenv -f .env bundle exec puma`


## Run tests
`dotenv -f .env.test bundle exec rspec`


## DB Migrations
`dotenv -f .env bundle exec rake db:migrate[version]`

`dotenv -f .env bundle exec rake db:rollback[version]`

Migration filename: `version_name.rb`

`dotenv -f .env bundle exec rake db:seed`
