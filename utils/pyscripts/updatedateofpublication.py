# python3 - may need pip install requests
import requests,sys
import json

if len(sys.argv) != 3:
  print("usage: "+sys.argv[0]+" {uuid} {date-of-publication}");
  print("       eg: "+sys.argv[0]+" 3e63bd41a59dc355c0c616bc9284c3b18f0c2e10 2020-06-02T10:00:00")
  sys.exit(1)

date = sys.argv[1]

authentuser='admin'
authentpass='admin'

# Modify url to suit
urlprefix="http://140.79.20.100:8080/geonetwork/"

params = [
  { 
      'value' : '<gn_replace>'+str(sys.argv[2])+'</gn_replace>',
      'xpath' : 'mdb:identificationInfo/mri:MD_DataIdentification/mri:resourceMaintenance/mmi:MD_MaintenanceInformation/mmi:maintenanceDate/cit:CI_Date/cit:date/gco:DateTime'
  }
]

response = requests.post(urlprefix+"srv/eng/info?type=me", auth=(authentuser,authentpass))
token = response.cookies['XSRF-TOKEN']
print("Token is "+token)

headers = {
  'X-XSRF-TOKEN': token,
  'accept': 'application/json',
  'Content-Type': 'application/json'
}
jar = requests.cookies.RequestsCookieJar()
jar.set('XSRF-TOKEN',token)
response = requests.put(urlprefix+"srv/api/0.1/records/batchediting?uuids="+str(sys.argv[1]), data=json.dumps(params), auth=(authentuser,authentpass), headers=headers, cookies=jar)
response.raise_for_status()
if 'errors' in response.json():
    print("Result returned "+str(response.json()['errors'])+" errors")

sys.exit(0)
