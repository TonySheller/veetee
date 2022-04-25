import datetime
import time
import requests  

PROMETHEUS = 'http://localhost:9090/'

class DiskSpaceUsed:

  def __init__(self):
    '''
    Could pass in a the parition if needed
    '''
    self.used = self.getUsed()  
  
  def getUsed(self):
    '''
    Get the used space
    '''
    response =requests.get(PROMETHEUS + '/api/v1/query', params={'query': '100 - ((node_filesystem_avail_bytes{mountpoint="/data",fstype!="rootfs"} * 100)/node_filesystem_size_bytes{mountpoint="/data",fstype!="rootfs"})'}) 
    results = response.json()['data']['result']
    
    return round(float(results[0]['value'][1]),2)

    
if __name__ == '__main__':
  dsu = DiskSpaceUsed()
  print(dsu.used)
