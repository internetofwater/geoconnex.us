
import pyourls3
import random

your_site = "http://localhost:8082"

urls = pyourls3.Yourls(your_site, user="example_username", passwd="example_password")
rand = random.randint() % 10**10
# Shorten a link, giving it a custom keyword and title
r = urls.shorten("https://www.jetbrains.com/"+rand, keyword="bestides"+rand, title="JetBrains makes nice IDEs")
print(r)

# Expand a link
r = urls.expand("bestides"+rand)
print(r)

# Get stats for a shortened link
r = urls.url_stats("bestides"+rand)
print(r)

# Get global installation stats
r = urls.stats()
print(r)