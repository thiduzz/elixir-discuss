# Discuss

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`


# Release Locally (without docker)

Start a release with:

mix release.init

Create a releases.exs in your config dir (ref: https://dev.to/ilsanto/deploy-a-phoenix-app-with-docker-stack-1j9c )

Create a .env within a .docker/app directory

Comment out the following line in the prod.exs
import_config "prod.secret.exs"

Add init method to the /lib/NAME_OF_YOUR_APP_web/endpoint.ex

Create a release.ex within /lib/NAME_OF_YOUR_APP dir

Run the following commands:

mix phx.digest
MIX_ENV=prod mix release
set -o allexport; source ./.docker/app/.env; set +o allexport
_build/prod/rel/NAME_OF_YOUR_APP/bin/NAME_OF_YOUR_APP eval NAME_OF_YOUR_APP.Release.migrate
_build/prod/rel/NAME_OF_YOUR_APP/bin/NAME_OF_YOUR_APP start

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
