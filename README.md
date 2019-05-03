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
Runs your Garry's Mod server inside Docker container as an executable

# Features
- Gmod running under non-root user (steam)
- Working luarefresh. You can update your scripts and changes will apply instantly
- Installed CSS content
- You can run commands in your container like it's not containered server
- Correct `GetConVarString("hostip")` if run with docker-compose (just edit ip inside .env)
- tmysql4, luasocket and some .dll modules works fine

# Example
For detailed info look inside start.sh and docker-compose.yml

Also you can run your server with `docker run`. Simple example:
```bash
docker build -t gmod-server . ; docker run --rm -it --name gmod \
    -p 27015:27015/udp \
    -v $PWD/volume/addons:/gmodserv/garrysmod/addons/ \
    gmod-server \
        -port 27015 \
        -tickrate 32 \
        -maxplayers 8 \
        +map gm_construct \
```

# Notes

- This image requires ~10GB of free space
- All you need (addons, data, gamemodes) located in `/gmodserv/garrysmod`
- Such modules like `gmsv_socket_linux.dll` requires additional port forwarding rules. Example. If you plan to use `27030/tcp` then you need to add following option to `docker run` command: `-p 27030:27030/tcp`
- The next useful thing it's `--rm` option. If you use it the container will automatically removed after srcds process being killed. You should not remove trash containers by hands with this param
- `--name anyname` assign pretty name to your container
- `-d` option runs container in background. You can attach them with `docker attach container_name` (don't use with --rm).
- `-it` there is 2 options where -t allocate a pseudo-TTY (required) and -i which allow you to interact with gmod console (run commands etc)
- `docker logs -f container_name` let's receive logs from server!
- `docker exec -it container_name bash` connect to container shell
