import requests
# python3 - may need pip install requests

# Modify url to suit
url = "http://localhost:8080/geonetwork/srv/eng/qi@json?fast=index"

response = requests.get(url, auth=('admin','admin'))
for j in response.json()['metadata']:
  # only print out the records that have a databaseid
  if 'databaseid' in j:
    print(j['geonet:info']['uuid']+','+j['databaseid'])
