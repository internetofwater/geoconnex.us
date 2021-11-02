# Geoconnex Yourls Permanent Identifier Server (PIDS)
[![Yourls for geoconnex.us](https://github.com/internetofwater/pids.geoconnex.us/actions/workflows/build.yml/badge.svg?)](https://github.com/internetofwater/pids.geoconnex.us/actions/workflows/build.yml)

### Description
This folder serves as the deployment for the CI/CD of the Geoconnex PIDS.
The Geoconnex PIDS uses [YOURLS](https://github.com/YOURLS/YOURLS) with custom plugins developed for geoconnex, but made available to the wider community. The service relies on two linked containers: a MySQL database and a Yourls server container.

Inside this folder are Docker-Compose and Dockerfiles configured to build and run each of the aformentioned containers. Futher information regarding the installation, configuration, deployment, and build process of this service can be found in the [Persistent Identifier Repository](https://github.com/internetofwater/pids.geoconnex.us).

The docker images provide a sitemap.xml of the all PIDs inside of the namespaces folder and a .sql.gz backup of the namespaces folder located inside the MySQL container at `/docker-entrypoint-initdb.d/yourls.sql.gz`. 

Basic steps to run locally:

```
git clone https://github.com/internetofwater/geoconnex.us
cd geoconnex.us/PID-server
nano docker-compose.yml <edit environmental variables as appropriate>
docker-compose up --build -d
```
