# python3 - may need pip install requests
import requests,sys

if len(sys.argv) != 2:
  print("usage: "+sys.argv[0]+" {username}");
  sys.exit(1)

username = sys.argv[1]

authentuser='admin'
authentpass='admin'

# Modify url to suit
urlapi = "http://localhost:8080/geonetwork/srv/api"
url = "http://localhost:8080/geonetwork/srv/eng/qi@json?fast=index"

# Note it may be better to make a dummy call to the api in order to retrive an 
# X-XSRF-TOKEN from the response and then use that as a header on all future requests 
# but for the purposes of this script it isn't needed 
response = requests.get(urlapi+"/0.1/users@json", auth=(authentuser,authentpass))
userid = None
for j in response.json():
  # find the user id of the username specified as an argument
  if j['username'] == username:
    userid = j['id']

if userid is not None:
  print("Found userid "+str(userid)+" that matches specified username "+username)
else:
  print("Cannot find user "+username)
  sys.exit(1)

response = requests.get(url+"&_owner="+str(userid), auth=(authentuser,authentpass))
if 'metadata' in response.json():
  md = response.json()['metadata']
  print("Found "+str(len(md))+" owned by user "+username)
  for j in md:
    print(j['geonet:info']['uuid'])
else:
  print("No records owned by "+username)

sys.exit(0)
