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
from actions.StorageGetter import DiskSpaceUsed


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

         dispatcher.utter_message(text=f"{DiskSpaceUsed().used}")

         return []

class PrintPythonPath(Action):

    def name(self) -> Text:
         return "action_print_python_path"

    def run(self, dispatcher: CollectingDispatcher,
             tracker: Tracker,
             domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
         

         dispatcher.utter_message(text=f"{sys.path}")

         return []
