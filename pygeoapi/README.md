# pygeoapi configuration

This is configuration for a pygeoapi instance deployed to https://info.geoconnex.us. 

This is a work in progress aiming to provide basic landing pages for resources registered in geoconnex.us that don't otherwise have landing pages. 

The semantic markup and formalism of these resources will expand over time.


```
docker stop [container name]
docker system prune -a
svn checkout https://github.com/internetofwater/geoconnex.us/trunk/pygeoapi
cd pygeoapi
docker-compose up
```
