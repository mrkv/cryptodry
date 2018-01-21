# Cryptodry
Roda + dry-rb architecture showcase on example of a fictional crypto-transactional service.

## Setup
`dotenv -f .env rake db:setup`
`dotenv -f .env.test rake db:setup`

## Start server
`puma`

## Run tests
`dotenv -f .env.test rspec`

## DB Migrations
`dotenv -f .env rake db:migrate[version]`

`dotenv -f .env rake db:rollback[version]`

Migration filename: `version_name.rb`

`dotenv -f .env rake db:seed`
