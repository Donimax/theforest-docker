# Docker - TheForest Dedicated Server

[![Docker Pulls](https://img.shields.io/docker/pulls/donimax/theforest-docker)](https://hub.docker.com/r/donimax/theforest-docker)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/donimax/theforest-docker/latest)](https://hub.docker.com/r/donimax/theforest-docker)

This includes a TheForest Dedicated Server based on Docker with Wine and an example config.

## What you need to run this

* Basic understanding of Linux and Docker

## Getting started

WARNING: If you dont do Step 1 and 2 your server can/will not save!

1. Create a new game server account over at <https://steamcommunity.com/dev/managegameservers> (Use AppID: `242760`)
2. Insert the Login Token into the environment variable via docker-run or docker-compose (at `SERVERSTEAMACCOUNT`)
3. Start the container with the following examples:

Bash:

```console
docker run --rm -i -t -e 'SERVERSTEAMACCOUNT=YOUR_TOKEN_HERE' -p 8766:8766/tcp -p 8766:8766/udp -p 27015:27015/tcp -p 27015:27015/udp -p 27016:27016/tcp -p 27016:27016/udp -v $(pwd)/config:/config --name theforest-docker donimax/theforest-docker:latest
```

Docker-Compose:

```yaml
services:
  the-forest-server-01:
    container_name: the-forest-server-01
    image: donimax/theforest-docker:latest
    restart: unless-stopped
    ports:
      - 8766:8766/tcp
      - 8766:8766/udp
      - 27015:27015/tcp
      - 27015:27015/udp
      - 27016:27016/tcp
      - 27016:27016/udp
    volumes:
      - './config:/config'
    environment:
      - SERVERSTEAMACCOUNT=YOUR_TOKEN_HERE
```

## Environment variables

| Env                      | default              | description |
|------------------------- |----------------------|-------------|
| TIMEZONE                 | Europe/Berlin        | Timezone                  |
| PUID                     | 1000                 | puid                      |
| PGID                     | 1000                 | pgid                      |
| STEAMAPPID               | 556450               | steamappid                |
| SERVERIP                 | 0.0.0.0              | Server IP address         |
| SERVERSTEAMPORT          | 8766                 | Steam Communication Port  |
| SERVERGAMEPORT           | 27015                | Game Communication Port   |
| SERVERQUERYPORT          | 27016                | Query Communication Port  |
| SERVERNAME               | the-forest-server-01 | Server display name       |
| SERVERPLAYERS            | 8                    | Maximum number of players |
| ENABLEVAC                | on                   | Enable VAC                |
| SERVERPASSWORD           |                      | Server password. Blank means no password. It is recommended to have a password to prevent griefers.                        |
| SERVERPASSWORDADMIN      |                      | Server administration password. Blank means no password.                                                                   |
| SERVERSTEAMACCOUNT       |                      | Don't leave this blank or use your actual Steam account name. The Forest App ID number is 242760. DO NOT SHARE THIS CODE!  |
| SERVERAUTOSAVEINTERVAL   | 30                   | Time between server auto saves in minutes - The minimum time is 15 minutes                                                 |
| DIFFICULTY               | Normal               | Game difficulty mode. Must be set to Peaceful / Normal / Hard / HardSurvival                                               |
| INITTYPE                 | Continue             | Must be set to New or Continue. If left on New, the game won't save and you will have to restart each time.                |
| SLOT                     | 1                    | Slot to save the game. Must be set to either slot 1 / slot 2 / slot 3 / slot 4 / slot 5.                                  |
| SHOWLOGS                 | off                  | Show event log. Must be set off or on.                                                                                     |
| SERVERCONTACT            | email@gmail.com      | Contact email for server admin. Not required.                                    |
| VEGANMODE                | off                  | No enemies if switched off.                                                       |
| VEGETARIANMODE           | off                  | No enemies during day time.                                                       |
| RESETHOLESMODE           | off                  | Reset all structure holes when loading a save.                                    |
| TREEREGROWMODE           | off                  | Regrow 10% of cut down trees when sleeping.                                       |
| ALLOWBUILDINGDESTRUCTION | on                   | Allow building destruction.                                                       |
| ALLOWENEMIESCREATIVEMODE | off                  | Allow enemies in creative games.                                                  |
| ALLOWCHEATS              | off                  | Allow clients to use the built in debug console.                                  |
| REALISTICPLAYERDAMAGE    | off                  | Realistic Player Damage — increases PvP damage dramatically depending on weapon.  |

## Software used

* Debian Slim Stable
* Xvfb
* Winbind
* Wine
* SteamCMD
* TheForest Dedicated Server
