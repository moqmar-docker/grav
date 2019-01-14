# momar/grav
A docker container for the [Grav CMS](https://getgrav.org) that always keeps Grav and its plugins up-to-date.

## Environment
`GRAV_PLUGINS` should be a space-separated list of plugins to be installed.

## Volumes
`/data/grav/user` contains all user data.

## Setup
```
# start container
docker run -d --name grav -e GRAV_PLUGINS="admin quark" -v "$PWD/data:/data/grav/user" momar/grav

# create admin user (you might have to wait a few minutes for the login plugin to be installed)
docker exec -it grav php bin/plugin login new-user
```