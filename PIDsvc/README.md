# Persistent Identifier Service (PID Service)
The geoconnex.us persistent identifiers are resolved by the Persistent Identifier Service (PIDsvc) deployed here. 
The PIDsvc was originally developed by CSIRO. https://www.seegrid.csiro.au/wiki/Siss/PIDService#Prerequisites

The geoconnex.us deployment is based on a Dockerized version of the PIDsvc maintained by the [Internet of Water](https://internetofwater.org) at https://github.com/internetofwater/IoW-PIDsvc. A full description of the PIDsvc and its API is available [here](https://github.com/internetofwater/IoW-PIDsvc/tree/master/PIDsvc).

The remainder of this document describes the deployment system for the geoconnex.us PID Service for easy restoration or migration to other services

1. [Architecture](#architecture)
2. [Deployment](#deployment)

# Architecture
All requests to the domain https://geoconnex.us are first intercepted by a proxy server, in this case, [Caddy 2](https://caddyserver.com/). If the request involves either the PIDsvc user interface or write requests (to create, modify or delete any PIDs and redirects), the proxy server redirects the request to a writeable instance of the PIDsvc that requires authentication. The database of this instance is replicated to multiple read-only databases using write-ahead logging (WAL). If the request involves a normal GET request for a PID, the proxy server routes the request to a read-only instance of the PIDsvc, which matches PIDs against read-only databases load balanced by Docker Engine, and dispatches matched PIDs towards the targeted redirect URLs. See figure below to visualize this architecture.

![deployment figure](https://user-images.githubusercontent.com/44071350/87054857-9b891780-c1d1-11ea-9d1e-c1876b65e65f.png)


# Deployment
This assumes a machine running Ubuntu 18.04 LTS with at least 10GB of disk space and 2GB of RAM

## Docker-Compose 
1. [Install Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
2. [Install Docker-Compose](https://docs.docker.com/compose/install/)
3. ```git clone https://github.com/internetofwater/geoconnex.us``` to your server
4. ```cd``` into the directory ```path/to/geoconnex.us/PIDsvc```
5. Change ```POSTGRESQL_PASSWORD```, ```POSTGRESQL_REPLICATION_USER``` and ```POSTGRESQL_REPLICATION_PASSWORD``` in docker-compose ```environment:``` for ```postgres-master``` and ```postgres-replica``` AND ```username``` and ```password``` in ```context_master.xml``` and ```context_replica.xml``` to your desired preferences/
6. ```docker-compose up --scale postgres-replica=5 -d``` One can set postgres-replica=```n```, where ```n``` is the number of read-only databases desired for the read-only PIDsvc to load balance to over docker internal round-robin DNS
7. The write-enabled PIDsvc is deployed at http://localhost:8095, with GUI at http://localhost:8095/pidsvc. The read-only PIDsvc is accessed at http://localhost:8096 

## Caddy

8. Install Caddy 2:  

```
echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" 
    | sudo tee -a /etc/apt/sources.list.d/caddy-fury.list
sudo apt update
sudo apt install caddy
```

9. Copy and configuration:

```
cp Caddyfile /etc/caddy/Caddyfile
cd /etc/caddy
sudo caddy reload
```

## Security/Authentication
Can be implemented via varied Caddy settings or an external LDAP

