# Persistent Identifier Service (PID Service)
This is a deployment system using docker for the PIDsvc developed by CSIRO. https://www.seegrid.csiro.au/wiki/Siss/PIDService#Prerequisites

1. [Overview](#overview)
2. [Deployment](#deployment)
3. [API Request Templates](#api-request-templates)
* [Batch import](#batch-import-via-xml-file) 
* [Delete individual mapping](#delete-individual-mapping) 

# Overview
The Persistent Identifier Service (PID Service) enables resolution of persistent identifiers. All incoming HTTP requests are intercepted by an Apache HTTP web server level and passed to a dispatcher servlet that matches a pattern of an incoming request and compares it with the patterns configured in the PID Service and stored in a persistent relational data store (e.g. PostgreSQL) and then performs a set of user-defined actions, such as, HTTP header manipulation, redirects, proxying requests, delegating resolution to another service, etc. It features extendable architecture for future improvements and supports multiple control interfaces - visual user interface (UI) as well as programmable API for remote user-less management of URI mapping rules.

Implementation has taken into account findings, requirements and observations discovered during technology review and prototype implementation phases that immediately preceded implementation of the PID Service:
https://www.seegrid.csiro.au/wiki/bin/view/SISS4BoM/PIDTechnologyReview
https://www.seegrid.csiro.au/wiki/bin/view/SISS4BoM/PIDPrototypeSolution



# Simple Deployment
This docker configuration includes 3 images: a postgres database, tomcat (with a pidsvc .war for the dispatcher, API, and user interface) and apache2 as a request interceptor.This assumes a machine running Ubuntu 18.04 LTS with at least 10GB of disk space and 2GB of RAM

1. [Install Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
2. [Install Docker-Compose](https://docs.docker.com/compose/install/)
3. ```git clone []``` to your Server (ubuntu 18.04 LTS)
4. Change ```POSTGRES_USER```in docker-compose ```environment:``` AND ```username``` in ```context.xml``` to your desired preference
5. Change ```POSTGRES_PASSWORD```in docker-compose ```environment:``` AND ```password``` in ```context.xml``` to your desired preference
6. Move to IoW-PIDsvc/PIDsvc directory, then ```docker-compose build```
7. Pidsvc is deployed at http://localhost:8095, with GUI at http://localhost:8095/pidsvc


## Optional: Enable https

The most straightforward way to serve the PID service over https is to set up a reverse proxy that routes all https traffic coming through port 443 to the "backend service" running on the tomcat docker image on port 8095, and redirects all http traffic coming through port 80 to port 443. The simplest way to do this is with the [Caddy server](https://caddyserver.com/docs/), which by default provisions and renews free SSL certificates from [letsencrypt.org](https://letsencrypt.org).

### Installing and configuring Caddy is simple 
1. [Manual Install caddy server for Linux](https://caddyserver.com/docs/install)
2. caddy reverse-proxy --from example.com --to localhost.IP.address:8095

# Robust deployment
Sometimes, under many rapid requests, the database becomes overwhelmed and the PIDsvc fails. To mitigate this issue, it a more robust architecture is possible (see figure below).

![deployment figure](https://user-images.githubusercontent.com/44071350/87054857-9b891780-c1d1-11ea-9d1e-c1876b65e65f.png)

For this deployment use:

```docker-compose up -f docker-compose-robust.yml --build --scale postgres-replica=3 -d```

You can set postgres-replica=n,  where n is the number of read-only databases desired for the read-only PIDsvc to load balance to over docker internal round-robin DNS
The write-enabled PIDsvc is deployed at http://localhost:8095, with GUI at http://localhost:8095/pidsvc. The read-only PIDsvc is accessed at http://localhost:8096 

The Caddy settings require more complex routing. An example deployment including a Caddyfile is described [here](https://github.com/ksonda/geoconnex.us-1/blob/master/PIDsvc/README.md)


# API Request Templates

## Batch import via xml file
Import an xml file of 1:1 mappings located at path/<import-file.xml>. Note, any mappings for paths already registered will be overwritten by default.

### Using shell/ curl
```
curl --user [name]:[password] https://geoconnex.us/pidsvc/controller?cmd=import -X POST -F "source=@<path>/import-file.xml" -H "Content-Type: multipart/mixed" 
```

### Using R
```
library(httr)

# URL of API endpoint + command
api <- "https://geoconnex.us/pidsvc/controller?cmd=import"

# set path to xml code desired
payload <- list(y = upload_file("<path>/import-file.xml", type = "text/xml"))

# POST with authentication and appropriate header
x <- POST(api, body = payload, authenticate("user", "password"), encode = c("multipart"))
```

### Using Python
```
import requests

#URL of API endpoint + command
api = 'https://geoconnex.us/pidsvc/controller?cmd=import'

#POST the file with authentication
with open('<path>/import-file.xml') as f:
    r = requests.post(api, files={'<path>/import-file.xml': f}, auth=('user','password'))

```


## Delete individual mapping
Delete a mapping for /namespace/path/endofpath. Note that this does not actually delete the mapping but deprecates and inactivates it. Full version histories are kept in the persistent data store.

### Using shell/ curl
```
curl --user [name]:[password] https://geoconnex.us/pidsvc/controller?cmd=delete_mapping -d "mapping_path=/namespace/path/endofpath" -X POST
```

### Using R
```
library(httr)

# URL of API endpoint + command
api <- "https://geoconnex.us/pidsvc/controller?cmd=delete_mapping"

# specify the individual path to be deleted
payload <- list(mapping_path = "/namespace/path/endofpath")

# POST with authentication
x <- POST(api, body = payload, authenticate("user", "password"), encode = "form")
```

### Using Python
```
import requests

#URL of API endpoint + command
api ='https://geoconnex.us/pidsvc/controller?cmd=delete_mapping'

#specify the individual path to be deleted
payload = {'mapping_path':'/namespace/path/endofpath'}

#POST with authentication
r = requests.post(api, data = payload, auth=('user','password'))

```
