# Terraria server in gentoo docker image

## Configuration

You can edit `config/serverconfig.txt` and rebuild the image or pass the
following environment variables:
* TERRARIA_PORT (sets port=...)
* TERRARIA_PW (sets password=...)
* TERRARIA_MOTD (sets motd=...)
* TERRARIA_PLAYERNUM (sets maxplayers=...)
* TERRARIA_ARGS (additional arguments to the server binary)

In addition you should create a mountpoint at `/terraria/world` to mount your
worlds in from the host. Alternatively make it a data volume.

## Starting

Starting the server could look like this:

```sh
docker run -ti \
	--name=terraria \
	-p 7777:7777 \
	-v <host-location-to-terraria-worlds>:/terraria/world \
	-e TERRARIA_WORLD=/terraria/world/<world-file> \
	-e TERRARIA_PW=<some-pw> \
	hasufell/gentoo-terraria-server
```

## Accessing the interactive server console

The server is started via tmux. Because docker doesn't work well with tmux,
we have to use this command:

```sh
docker exec -ti terraria script -q -c "/bin/bash" /dev/null
tmux attach
```