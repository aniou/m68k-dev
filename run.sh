set -x
podman run -it --rm --userns=keep-id -v $HOME/a2560x/src:/src:rw,U m68k-dev:0.0.5
