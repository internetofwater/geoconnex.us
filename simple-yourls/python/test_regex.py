
import pyourls3

your_site = "http://localhost:8082"

urls = pyourls3.Yourls(your_site, user="yourls-admin", passwd="apassword")
short_url = "/ref/pws/SD4602337"
# short_url = "/usgs/monitoring-location/01010000"

# Expand a link
r = urls.expand(short_url)
print(r)

# Get global installation stats
r = urls.stats()
print(r)