FROM ubuntu:xenial

LABEL MAINTAINER="_AMD_ (me@amd-nick.me)"

# Prepare Gmod server and CSS content
# ===================================

RUN apt-get update \
	&& apt-get -y upgrade \
	&& apt-get -y --no-install-recommends install wget lib32gcc1 lib32tinfo5 lib32stdc++6 ca-certificates
#                                                 for steamcmd               for gmod     for steamcmd under !root


# Cleanup
# ===================================

RUN apt-get clean \
	&& rm -rf /tmp/* /var/lib/apt/lists/*


# Security
# ===================================

RUN groupadd -g 999 steam \
	&& useradd -r -m -d /gmodserv -u 999 -g steam steam

RUN mkdir -p /gmodserv/steamcmd /gmodserv/content/css \
	&& chown -vR steam:steam /gmodserv

USER steam
ENV HOME /gmodserv


# SteamCMD + GMOD + CSS
# ===================================

WORKDIR /gmodserv/steamcmd

RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
	&& tar -xvzf steamcmd_linux.tar.gz \
	&& rm steamcmd_linux.tar.gz

RUN ./steamcmd.sh \
	+login anonymous \
	+force_install_dir /gmodserv/content/css \
	+app_update 232330 -validate \
	+force_install_dir /gmodserv \
	+app_update 4020 -validate \
	+quit

RUN echo '"mountcfg" {"cstrike" "/gmodserv/content/css/cstrike"}' > /gmodserv/garrysmod/cfg/mount.cfg


# Run server
# ===================================

WORKDIR /gmodserv
ENTRYPOINT ["./srcds_run", "-game garrysmod", "-console", "-norestart", "-strictportbind"]
CMD ["-port 27015", "-tickrate 32", "-maxplayers 16", "-insecure", "+map gm_construct"]
