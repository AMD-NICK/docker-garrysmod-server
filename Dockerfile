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
	&& useradd -r -u 999 -g steam steam

WORKDIR /home/steam
RUN mkdir -p steamcmd gmodserv content/css \
	&& chown -vR steam:steam /home/steam

USER steam


# SteamCMD + GMOD + CSS
# ===================================

WORKDIR /home/steam/steamcmd

RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
	&& tar -xvzf steamcmd_linux.tar.gz \
	&& rm steamcmd_linux.tar.gz

RUN ./steamcmd.sh \
	+login anonymous \
	+force_install_dir /home/steam/content/css \
	+app_update 232330 -validate \
	+force_install_dir /home/steam/gmodserv \
	+app_update 4020 -validate \
	+quit

RUN echo '"mountcfg" {"cstrike" "/home/steam/content/css/cstrike"}' > /home/steam/gmodserv/garrysmod/cfg/mount.cfg


# Run server
# ===================================

WORKDIR /home/steam/gmodserv
ENTRYPOINT ["./srcds_run"]
CMD ["-game garrysmod", "-console", "-norestart", "-strictportbind"]
