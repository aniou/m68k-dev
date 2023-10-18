# m68k-dev

Docker container with m68k compiler

# Building container

There is a single assumption that sources are located in `$HOME/a2560x/src`,
to adjust that change mapping in `run.sh` script, if neccessary.

```bash
$ podman -v
podman version 3.4.4
$ mkdir -p ~/a2560x/src
$ cd ~/a2560x/src
$ git clone https://github.com/aniou/m68k-dev
$ cd m68k-dev
$ ./build.sh
```

# Building and running FUZIX in emulato

## fetch sources and run container

```bash
$ cd ~/a2560x/src
$ git clone https://github.com/EtchedPixels/FUZIX
$ git clone https://github.com/EtchedPixels/EmulatorKit
```

## configure FUZIX

Edit `~/a2560x/src/FUZIX/Makefile` and set `TARGET` variable to `68knano`.

## build FUZIX and emulator

Start container:

```bash
$ cd ~/a2560x/src
$ ./run.sh
++ podman run -it --rm --userns=keep-id -v /home/user/a2560x/src:/src:rw,U m68k-dev:0.0.5
```

Following commands should be run in container. Host source directory 
`~/a2560x/src` will be mounted as `/src` in container:

```bash
$ cd /src/FUZIX
$ make
$ make diskimage
$ cd /src/EmulatorKit
$ make
$ exit
```

## run emulator

Run commands on host

```bash
$ cd ~/a2560x/src/EmulatorKit
$ ./68knano -r ../FUZIX/Images/68knano/fuzix.rom -i ../FUZIX/Images/68knano/emu-ide.img
FUZIX version 0.5
Copyright (c) 1988-2002 by H.F.Bower, D.Braun, S.Nitschke, H.Peraza
Copyright (c) 1997-2001 by Arcady Schekochikhin, Adriano C. R. da Cunha
Copyright (c) 2013-2015 Will Sowerbutts <will@sowerbutts.com>
Copyright (c) 2014-2023 Alan Cox <alan@etchedpixels.co.uk>
Devboot
Motorola 68000 processor detected.
1024kB total RAM, 971kB available to processes (32 processes max)
Enabling interrupts ... ok.
IDE drive 0: hda: hda1 hda2
IDE drive 1:
bootdev: hda1
Mounting root fs (root_dev=1, ro): OK
Starting /init
init version 0.9.1
Checking root file system.

^ ^
n n   Fuzix 0.5
>@<
Welcome to Fuzix
m m

login: root

Welcome to FUZIX.
# ls -la /
drwxrwxrwx  11 root     root          512 Oct 18 19:29 .
drwxrwxrwx  11 root     root          512 Oct 18 19:29 ..
drwxr-xr-x   2 root     root         4096 Oct 18 19:29 bin
drwxr-xr-x   2 root     root         3072 Oct 18 19:29 dev
drwxr-xr-x   2 root     root          512 Oct 18 19:29 etc
-rwxr-xr-x   1 root     root        15696 Oct 18 19:29 init
drwxr-xr-x   2 root     root          512 Oct 18 19:29 mnt
drwx--x---   2 root     root          512 Oct 18 19:29 root
drwxrwxrwt   2 root     root          512 Oct 18 19:29 tmp
drwxr-xr-x  10 root     root          512 Oct 18 19:29 usr
drwxr-xr-x   5 root     root          512 Oct 18 19:29 var
#
```

# Acknowledgements

Thanks to [dwildie/68k-tools](https://github.com/dwildie/68k-tools) for inspiration!

