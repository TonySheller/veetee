import datetime
import time
import requests  

# Exterenal to the cluster with port-forwarding setup
#PROMETHEUS = 'http://localhost:9090/'

# Internal to the cluster with no port-forwarding
PROMETHEUS = 'http://prometheus-server.prometheus.svc.cluster.local/'

class DiskSpaceUsed:

  def __init__(self):
    '''
    Could pass in a the parition if needed

    Or get all the paritions of the correct kind
    
    '''
    self.used = self.getUsed()  
  
  def getUsed(self):
    '''
    Get the used space
    '''
    response =requests.get(PROMETHEUS + '/api/v1/query', params={'query': '100 - ((node_filesystem_avail_bytes * 100)/node_filesystem_size_bytes)'}) 
    return_me_temp =[]
    results = response.json()['data']['result']
    file_systems = []
    for result in results:
      if result['metric']['device'].startswith('/dev'):
        if result['metric']['device'] not in file_systems:
          file_systems.append(result['metric']['device'])
          return_me_temp.append([result['metric']['node'], result['metric']['mountpoint'],round(float(result['value'][1]),2)])
    return_me = "\n"
    for item in return_me_temp:
      return_me += "Host {} filesystem '{}' at {:>5.2f} % usage.\n".format(item[0],item[1],item[2])
    return return_me



    
if __name__ == '__main__':
  dsu = DiskSpaceUsed()
  print(dsu.used)
