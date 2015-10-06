FROM        hasufell/gentoo-amd64-paludis:latest
MAINTAINER  Julian Ospald <hasufell@gentoo.org>

##### PACKAGE INSTALLATION #####

# copy paludis config
COPY ./config/paludis /etc/paludis

# update world with our USE flags
RUN chgrp paludisbuild /dev/tty && cave resolve -c world -x

# install tools set
RUN chgrp paludisbuild /dev/tty && cave resolve -c tools -x

# update etc files... hope this doesn't screw up
RUN etc-update --automode -5

################################


##### APPLICATION INSTALLATION #####

ENV PV 1308
RUN useradd -u 5000 terraria -d /terraria -m

WORKDIR /terraria

RUN wget http://terraria.org/server/terraria-server-linux-${PV}.tar.gz && \
	tar xzf terraria-server-linux-${PV}.tar.gz && \
	rm terraria-server-linux-${PV}.tar.gz

RUN mkdir -p /terraria/world

COPY ./config/serverconfig.txt /terraria/

RUN chown terraria:users -R /terraria

####################################


EXPOSE 7777

COPY start.sh /
RUN chmod +x /start.sh

CMD sh -c 'tmux new-session -s terraria /start.sh'
