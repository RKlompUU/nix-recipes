# Posgres server

To start, execute `./run`. Terminal will drop into a session where in the background the postgres server is running. While in this session, executing`psql` will enter the database. `./run` optionally accepts a database instance name, defaults to `default`.

To stop, Ctrl+d or type `exit`.

When a session is running and in another terminal `./run` is executed, postgres is _not_ started again, environment variables are set appropriately however and so this can be useful to enter the database in another terminal with `psql`.

`logs` is a convenience script to print all logs (that may be distributed over multiple files).

Credits to main inspiration: https://zeroes.dev/p/nix-recipe-for-postgresql/
