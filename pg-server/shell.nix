{ target ? "default", pkgs ? import <nixpkgs> {} }:
with pkgs;

mkShell {
  name = "postgres-env";
  buildInputs = [
    postgresql_14
    less
  ];

  postgresConf =
    writeText "postgresql.conf"
      ''
        # Add Custom Settings
        log_min_messages = warning
        log_min_error_statement = error
        log_min_duration_statement = 100  # ms
        log_connections = on
        log_disconnections = on
        log_duration = on
        #log_line_prefix = '[] '
        log_timezone = 'UTC'
        log_statement = 'all'
        log_directory = 'logs'
        log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
        logging_collector = on
        log_min_error_statement = error
      '';


  PGDATA = "${toString ./.}/" + target + "/.pg";

  shellHook = "mkdir -p " + target + "; " + ''
    echo "Using ${postgresql_14.name}."

    # Setup: other env variables
    export PGHOST="$PGDATA"
    # Setup: DB
    [ ! -d $PGDATA ] && pg_ctl initdb -o "-U dev" && cat "$postgresConf" >> $PGDATA/postgresql.conf
    pg_ctl -o "-p 5555 -k $PGDATA" start && {
      trap 'pg_ctl stop' EXIT
    }
    alias fin="pg_ctl stop && exit"

    export PGPORT=5555
    export PGUSER=dev
    export PGPASSWORD=dev
    export PGHOST=localhost
    export PGDATABASE=postgres
  '';
}
