The geoconnex Persistent Identifier Service uses the [YOURLS](https://github.com/YOURLS/YOURLS) platform and some custom plugins developed for geoconnex but made available to the wider YOURLS community. 
Installation, configuration, deployment, and use information can be found in the [IoW-YOURLS repository](https://github.com/internetofwater/IoW-YOURLS).

Basic steps

```
git clone https://github.com/internetofwater/IoW-YOURLS
cd IoW-YOURLS
nano .env <edit environmental variables as appropriate>
docker-compose up --build -d
```

