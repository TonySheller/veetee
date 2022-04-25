# This files contains your custom actions which can be used to run
# custom Python code.
#
# See this guide on how to implement these action:
# https://rasa.com/docs/rasa/custom-actions

# This is a simple example for a custom action which utters "Hello World!"

from typing import Any, Text, Dict, List
import datetime as dt
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
import requests  

class ActionShowTime(Action):
    def name(self) -> Text:
         return "action_show_time"

    def run(self, dispatcher: CollectingDispatcher,
             tracker: Tracker,
             domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
         dispatcher.utter_message(text=f"{dt.datetime.now()}")

         return []

class GetStorage(Action):

    def name(self) -> Text:
         return "action_get_storage"

    def run(self, dispatcher: CollectingDispatcher,
             tracker: Tracker,
             domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
         PROMETHEUS = 'http://localhost:9090/'
         response =requests.get(PROMETHEUS + '/api/v1/query', params={'query': '100 - ((node_filesystem_avail_bytes{mountpoint="/data",fstype!="rootfs"} * 100)/node_filesystem_size_bytes{mountpoint="/data",fstype!="rootfs"})'}) 
         results = response.json()['data']['result']
         msg = ""
         percent_used = round(float(results[0]['value'][1]),2)
         if percent_used < 90:
             msg = "{} % diskspace used".format(percent_used)
         else: 
             msg = "Disk Space is dangerously, with {} % used".format(percent_used)

         dispatcher.utter_message(text=f"{msg}")

         return []
