# nix-recipies

I will be sharing any interesting small nix applications here.

## Postgres server

Go to [pg-server](pg-server#posgres-server), for simple setup and execution of
Postgres servers locally without Docker.

## Target parent shell.nix

Enable nix-shell to use the closest `shell.nix` from current directory upwards
til `/`, by adding the following to your .bashrc:
```bash
function nix-shell-wrapped {
    path="$(pwd)"
    while [[ "$path" != "" && ! -e "$path/shell.nix" ]]; do
        path=${path%/*}
    done
    shell_path="$path/shell.nix"
    [ -e "$shell_path" ] || {
        echo 'no shell.nix found in . / .. / etc.'
        return 1
    }
    echo "entering nix shell with $shell_path"
    nix-shell "$@" "$shell_path"
}

alias nix-shell=nix-shell-wrapped
```
