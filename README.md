# nix-recipes

I will be sharing any interesting small nix applications here.

## Postgres server

Go to [pg-server](pg-server#posgres-server), for simple setup and execution of
Postgres servers locally without Docker.

## Target parent nix shell file

Enable nix-shell to use the closest `default.nix` or `shell.nix` from current directory upwards
til `/`, by adding the following to your .bashrc:
```bash
function nix-shell-parent {
    function findShellInPath {
      path=$1
      [ -e "$path/default.nix" ] && echo "$path/default.nix"
      [ -e "$path/shell.nix" ] && echo "$path/shell.nix"
    }

    path=$(pwd)
    shellFile=""
    while [[ "$path" != "" && "$shellFile" == "" ]]; do
        shellFile="`findShellInPath $path`"
        path="${path%/*}"
    done
    if [[ "$shellFile" == "" ]]; then
      # above loop fails to check for shell files under /
      shellFile="`findShellInPath /`"
    fi

    [[ "$shellFile" == "" ]] && {
        echo 'no shell.nix found in . / .. / etc.'
        return 1
    }
    echo "entering nix shell with $shellFile"
    nix-shell "$@" "$shellFile"
}
```
