# YOURLS PID service

### Description
This deploys the geoconnex.us PID server, which is based on [YOURLS](https://yourls.org), an actively maintained, open-source redirection platform. This deprecates the [PID service](https://github.com/SISS/PID), whose deployment information is archived [here](https://github.com/internetofwater/IoW-PIDsvc)

### Requires
- Docker & docker-compose.

YOURLS plugins used & activated:
- [reset-urls](https://gist.github.com/ozh/a0090f46569b50835520d95f9481d9fd#file-plugin-php) 
- [always-302](https://github.com/tinjaw/Always-302)
- [keep-querystring](https://github.com/rinogo/yourls-keep-query-string)
- [redirect-index](https://github.com/tomslominski/yourls-redirect-index)
- [regex-in-urls](https://github.com/webb-ben/plugins/tree/master/regex-in-urls)
- [request-forwarder](https://github.com/webb-ben/plugins/tree/master/request-forward)
- [bulk-import-and-shorten](https://github.com/vaughany/yourls-bulk-import-and-shorten)
- [bulk-API-import](https://github.com/webb-ben/plugins/tree/main/bulk-api-import)
- [sleek-backend](https://sleeky.flynntes.com)
- change-title

### Installation

1. Clone the repository to your own personal folder. <br>
   `git clone https://github.com/internetofwater/geoconnex.us`<br>
   `cd PID-server`<br>
   `docker-compose up -d --build`
2. Open yourls admin interface and install yourls.
3. Enable all plugins before adding any entries. 
4. To populate the database from a SQL dump backup:
 - Look under [python](python/README.md)
 - Upload a backup of the MySQL database using the adminer interface.

### Regular PID upload and update

`docker run -i -t --rm internetofwater/post-geoconnex \ `<br>
`python yourls_client.py --uri-stem https://geoconnex.us/ \ `<br> 
`--addr https://pids.geoconnex.us -u <user> -p <password> \ `<br>
`<https://csv-url.csv>`

### License
This service is licensed under the [MIT License](LICENSE).
