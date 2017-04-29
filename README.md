# oracle-docker

Dockerfiles based on the images available in the [Oracle Container Registry](https://container-registry.oracle.com/).
Before downloading any images from their registry you must first sign in and agree to the license.

These images are fairly large, and the Oracle Container Registry can be unfairly slow, so after the initial download I would recommend doing a `docker save` and storing a copy somewhere local.

Currently builds images for this version:

- Oracle Database 12c Standard Edition Release 12.1.0.2.0 - 64bit Production

Changing the `FROM` line in the Dockerfile should work against the other images.

The images provided by Oracle will first perform an installation, taking around 10 minutes, and then `tail -f` the log file to keep the container running.
This Dockerfile does only the installation and then exits, providing a stable base image to build upon, that doesn't require re-installation when being destroyed/re-created.

## Setup

The Oracle-provided images grow quite large and will exceed the default container base size, so your docker install will need to run the `devicemapper` storage driver, with it's base size increased:

- Create the file `/etc/docker/daemon.json`, with this as it's contents:

``` json
{
        "storage-driver": "devicemapper",
        "storage-opts": [
                "dm.basesize = 30G"
        ]
}
```

- Reload this config with:

```
sudo systemctl daemon-reload
```

- Verify that the change has taken place by inspecting the `Base Device Size` shown when running `docker info`

The new base size will only be picked up by images created after the change, so existing images will need to be destroyed and re-created. You can use [docker save](https://docs.docker.com/engine/reference/commandline/save/) and [docker load](https://docs.docker.com/engine/reference/commandline/load/) to do an export/import.

## Building

After pulling the images from [container-registry.oracle.com](container-registry.oracle.com), the image in this repository must be built with a larger shm-size (4GB minimum, but the larger the better). From the root of this repository run:

`docker build installoracle --shm-size="4g" -t oracle:installed`

This will run the installation and tag the resulting container image `oracle:installed`. Images started from this container will then startup the database.

## Usage

- `docker-compose up` to start the database container.
- wait a minute or so for the database to start up.
- connect from the host with `sqlplus system/Oracle@//localhost:1521/ORCL.localdomain` or within the container with `docker-compose exec --user oracle db /u01/app/oracle/product/12.1.0/dbhome_1/bin/sqlplus "system/Oracle"`
