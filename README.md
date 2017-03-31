# Monitoring Docker Image

## How to build this image

```bash
docker build -t sealife/docker-monitoring .
```

## How to get the Build from DockerHUB

```bash
docker pull sealife/docker-monitoring:latest
```

## How to use this Build

Before you start using this Build you should create a directory with a prebuilt config using MySQL settings..

In this example we are using ``/applications/monitoring`` as data directory


```bash
mkdir /applications/monitoring
```

after this you just create config called ``config.ini`` in the data folder with this content.

```ini
[MainConfig]
pageTitle=Monitoring System
loggingLevel=1
loggingDate=H:i:m
bootswatch=cosmo
https=false
fullException=true

[Logging]
logger=ErrorLogger

[AddonManager]
enabled=false
repoFile=repositories.json
addonFile=addons.json

[Database]
enabled=true
driver=mysql
charset=utf8
host=<host>
port=3306
user=<user>
pass=<password>
prefix=
database=<dbName>

[ErrorLogger]
eval=new \System\Logger\ErrorScreenLogger();

[Security]
default-groups-enabled=true
```

now you can run the docker container with:

```bash
docker run --name monserv -h example.org -d -p 2001:80 -v /applications/monitoring:/data sealife/docker-monitoring
```

go to your browser and open

```
http://example.org:2001
```

there is your new monitoring.

## Administration

Default login is ``admin`` with ``admin`` as password. (dont forget to change this in the user management)

After this you can navigate to Monitoring through the menu and start configure your monitoring.
