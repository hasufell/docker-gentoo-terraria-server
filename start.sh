#!/bin/bash

if [[ -n ${TERRARIA_WORLD} ]] ; then
	sudo -u terraria sed -i \
		-e "s|world=.*$|world=${TERRARIA_WORLD}|" \
		/terraria/serverconfig.txt
fi

if [[ -n ${TERRARIA_PORT} ]] ; then
	sudo -u terraria sed -i \
		-e "s|port=.*$|port=${TERRARIA_PORT}|" \
		/terraria/serverconfig.txt
fi

if [[ -n ${TERRARIA_PW} ]] ; then
	sudo -u terraria sed -i \
		-e "s|password=.*$|password=${TERRARIA_PW}|" \
		/terraria/serverconfig.txt
fi

if [[ -n ${TERRARIA_MOTD} ]] ; then
	sudo -u terraria sed -i \
		-e "s|motd=.*$|motd=${TERRARIA_MOTD}|" \
		/terraria/serverconfig.txt
fi

if [[ -n ${TERRARIA_PLAYERNUM} ]] ; then
	sudo -u terraria sed -i \
		-e "s|maxplayers=.*$|maxplayers=${TERRARIA_PLAYERNUM}|" \
		/terraria/serverconfig.txt
fi

cd /terraria/terraria-server-linux-${PV}

exec sudo -u terraria \
	./TerrariaServer.bin.x86_64 \
	-config /terraria/serverconfig.txt \
	${TERRARIA_ARGS}
