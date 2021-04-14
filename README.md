## Introduction

This is a web application built on [Elixir](https://elixir-lang.org/), using [Phoenix Framework](https://phoenixframework.org/) 
that provide the ability to scrap the Google search result and generating the report.

It is used to practice and demonstrate my learning of these two great technology. 

## Project Setup

### Erlang & Elixir

* Erlang 23.2.1 and Elixir 1.11.3

* Recommended version manager.

  - [asdf](https://github.com/asdf-vm/asdf) Erlang & Elixir

### Development

* Install [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

* Setup and boot the Docker containers:

  ```sh
  make docker_setup
  ```

* Install Elixir dependencies:

  ```sh
  mix deps.get
  ```

* Install Node dependencies:

  ```sh
  npm install --prefix assets
  ```

* Setup the databases:

  ```sh
  mix ecto.setup
  ```

* Start the Phoenix app

  ```sh
  iex -S mix phx.server
  ```

* Run all tests:

  ```sh
  mix test 
  ```

* Run all lint:

  ```sh
  mix codebase 
  ```

### Production

* Build Docker image

  ```sh
  docker-compose build
  ```
