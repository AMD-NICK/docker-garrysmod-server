<p align="center">
    <a href="#">
        <img src="https://img.qweqwe.ovh/docker-gmod.png"></a>
</p>

<p align="center">
    <a href="https://hub.docker.com/r/defaced/gmod-server/">
        <img src="https://img.shields.io/docker/build/defaced/gmod-server.svg"></a>
    <a href="https://hub.docker.com/r/defaced/gmod-server/">
        <img src="https://img.shields.io/docker/pulls/defaced/gmod-server.svg"></a>
    <a href="https://hub.docker.com/r/defaced/gmod-server/">
        <img src="https://img.shields.io/docker/stars/defaced/gmod-server.svg"></a>
</p>

<p align="center">
    <a href="https://github.com/AMD-NICK/docker-garrysmod-server/stargazers">
        <img src="https://img.shields.io/github/stars/AMD-NICK/docker-garrysmod-server.svg?style=social&label=Stars"></a>
    <a href="https://github.com/AMD-NICK/docker-garrysmod-server/network">
        <img src="https://img.shields.io/github/forks/AMD-NICK/docker-garrysmod-server.svg?style=social&label=Forks"></a>
    <a href="https://github.com/AMD-NICK/docker-garrysmod-server/issues">
        <img src="https://img.shields.io/github/issues/AMD-NICK/docker-garrysmod-server.svg?style=social&label=Issues"></a>
</p>



# Dockerized Garry's Mod server
Runs your gmod server in container as an executable

# Example
For detailed info look inside start.sh and docker-compose.yml

Also you can run your server with `docker run`. Simple example:
```bash
docker run --rm -it --name gmod \
    -p $PORT:$PORT/udp \
    -v $PWD/volume/addons:/home/steam/gmodserv/garrysmod/addons/ \
    defaced/gmod-server \
        -port $PORT \
        -tickrate 32 \
        -maxplayers 8 \
        +map gm_construct \
```


# Notes

- All you need (addons, data, gamemodes) located in `/home/steam/gmodserv/garrysmod`
- Such modules like `gmsv_socket_linux.dll` requires additional port forwarding rules. Example. If you plan to use `27030/tcp` then you need to add following option to `docker run` command: `-p 27030:27030/tcp`
- The next useful thing it's `--rm` option. If you use it the container will automatically removed after srcds process being killed. You should not remove trash containers by hands with this param
- `--name anyname` assign pretty name to your container
- `-d` option runs container in background. You can attach them with `docker attach container_name` (don't use with --rm).
- `-it` there is 2 options where -t allocate a pseudo-TTY (required) and -i which allow you to interact with gmod console (run commands etc)
- `docker logs -f container_name` let's receive logs from server!
- `docker exec -it container_name bash` connect to container shell
