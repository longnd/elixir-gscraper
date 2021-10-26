## Introduction

This is a web application built on [Elixir](https://elixir-lang.org/), using [Phoenix Framework](https://phoenixframework.org/) 
that provide the ability to scrap the Google search result and generating the report.

It is used to practice and demonstrate my learning of these two great technologies. 

- Staging: https://elixir-gscraper-staging.herokuapp.com/
- Production: https://elixir-gscraper.herokuapp.com/

## Project Setup

### Erlang & Elixir

- Erlang 24.0.5 and Elixir 1.12.2

- Recommended version manager.

  - [asdf](https://github.com/asdf-vm/asdf) Erlang & Elixir

### Development

- Install [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

- Setup and boot the Docker containers:

  ```sh
  make docker_setup
  ```

- Install Elixir dependencies:

  ```sh
  mix deps.get
  ```

- Install Node dependencies:

  ```sh
  npm install --prefix assets
  ```

- Setup the databases:

  ```sh
  mix ecto.setup
  ```

- Start the Phoenix app

  ```sh
  iex -S mix phx.server
  ```

- Run all tests:

  ```sh
  mix test 
  ```

- Run all lint:

  ```sh
  mix codebase 
  ```

### Production

- Build Docker image

  ```sh
  docker-compose build
  ```

### CI/CD
This project uses Github action for CI/CD and will automatically deploy to Heroku when the code is merged to the `develop` & `main` branches.
- Create two new Heroku apps, one for `staging` and the other for `production` environments:
  - Add a [Database add-on](https://devcenter.heroku.com/articles/managing-add-ons#using-the-dashboard), PostgreSQL is recommended.
  - Set the following [environment variables](https://devcenter.heroku.com/articles/config-vars#using-the-heroku-dashboard):
    | Environment Variable   | Description          |
    | ---------------------- | -------------------- |
    | DATABASE_URL           | Will be added automatically after adding the database add-on to the Heroku app |
    | HOST_URL               | The URL host, e.g. `acme.herokuapp.com` |
    | SECRET_KEY_BASE        | The value generated by running the command `mix phx.gen.secret` |
    
- [Define the secrets](https://docs.github.com/en/actions/reference/encrypted-secrets#creating-encrypted-secrets-for-a-repository) in the repository:
  | Environment Variable       | Description          |
  | -------------------------- | -------------------- |
  | HEROKU_API_KEY             | Can be found under [Account settings](https://dashboard.heroku.com/account#api-key) |
  | HEROKU_APP_NAME_STAGING    | The Heroku app name created for staging environment |
  | HEROKU_APP_NAME_PRODUCTION | The Heroku app name created for production environment |  
