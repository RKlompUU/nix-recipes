# Posgres server

This is a nix solution for running (temporary) Postgres servers for dev
work. State is stored on disk (in this folder, under database instance named
subfolders), and thus will survive reboots.

Unlike running with Docker, applying this will allow to execute Postgres
natively (this may be especially nice on MacOS, where Docker is entirely
virtualized). Subjectively it's also simply more fun to run Postgres natively
as opposed to through the dockerized image :)

## How to run

To start, execute `./run`. The terminal will drop into a session where in the background the postgres server is running. While in this session, executing `psql` will enter the database. `./run` optionally accepts a database instance name, defaults to `default`.

To stop, Ctrl+d or execute `exit`.

When a session is running and in another terminal `./run` is executed, postgres is _not_ started again, environment variables are set appropriately however and so this can be useful to enter the database in another terminal with `psql`.

`logs` is a convenience script to print all logs (that may be distributed over multiple files).

Credits to the main inspiration: https://zeroes.dev/p/nix-recipe-for-postgresql/

## Connecting to the server

See `./env` for connection settings (user, port, etc.), you're free to change these prior to initialization of a new database instance (i.e. each first `./run` execution of a new instance will initialize according to the settings in `./env`).
