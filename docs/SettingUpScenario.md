# Defining a Scenario

To really get the most out of rasa there are some additional things that must be done so that it will fit your needs. 

## Define intent.
First define intent by modifying the *rasa/data/nlu.yml* file.  There are already some examples in there so go with it. I defined *check_storage* like this:

```

- intent: check_storage
  examples: |
    - Provide drive status.
    - Provide drive status please
    - disk status.
    - storage please
    - storage status please
    - How is the storage situation?
    - Are the drives full?
    - Any problems with storage?
    - What's going on with the disk drives?

```

Now the *rasa/domain.yml* file should be edited. At the top of the file be sure to add *check_storage* in the list of intentions. 

```.shell

intents:
  - greet
  - goodbye
  - inform
  - affirm
  - deny
  - mood_great
  - mood_unhappy
  - bot_challenge
  - check_storage
  - give_time
  - give_python_path

```

The responses to the *intents* are kept in the *rasa/domain.yml* file.

```.shell
  utter_storage:
  - text: "One sec' while i check."
```

Open up the *rasa/data/stories.yml* file and add a story for checking storage. This is what it might look like.
Note the *action_get_storage* action.  This will be elaborated on further as it is an actual Python script that queries the Prometheus service running in the K8s cluster. 

```.shell

- story: get storage
  steps:
  - intent: greet
  - action: utter_greet
  - intent: check_storage
  - action: action_get_storage
  - action: utter_what_else

```

## Defining an Action that does something Besides echo text

The file *rasa/actions/actions.py* contains some examples of Python classes that perform actions. For example, the below is a Python class defined to get the information requested. 

Pay particular attention to the *name* method. This is where the name of the action is defined.  In this case *action_get_storage*

```.python

class GetStorage(Action):

    def name(self) -> Text:
         return "action_get_storage"

    def run(self, dispatcher: CollectingDispatcher,
             tracker: Tracker,
             domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

         dispatcher.utter_message(text=f"{DiskSpaceUsed().used}")

         return []

```

Note that all actions have a section in the *rasa/domain.yaml* file where they must be listed.

```

actions:
  - action_show_time
  - action_get_storage
  - action_print_python_path

```

## Train your model 

It's simple to train your model just type `rasa trrain` and the model gets trained and is ready to go.  If there is something wrong with the configuration an informative errror will be provided to help track it down.

```.shell
(RASA) asheller@DESKTOP-B3F18RF:/mnt/e/en705603/veetee/rasa$ rasa train
...

2022-04-30 12:48:37 INFO     rasa.engine.training.hooks  - Restored component 'CountVectorsFeaturizer' from cache.
2022-04-30 12:48:37 INFO     rasa.engine.training.hooks  - Restored component 'CountVectorsFeaturizer' from cache.
2022-04-30 12:48:37 INFO     rasa.engine.training.hooks  - Restored component 'DIETClassifier' from cache.
2022-04-30 12:48:37 INFO     rasa.engine.training.hooks  - Restored component 'EntitySynonymMapper' from cache.
2022-04-30 12:48:37 INFO     rasa.engine.training.hooks  - Restored component 'LexicalSyntacticFeaturizer' from cache.
2022-04-30 12:48:37 INFO     rasa.engine.training.hooks  - Restored component 'MemoizationPolicy' from cache.
2022-04-30 12:48:37 INFO     rasa.engine.training.hooks  - Restored component 'RegexFeaturizer' from cache.
2022-04-30 12:48:37 INFO     rasa.engine.training.hooks  - Restored component 'ResponseSelector' from cache.
2022-04-30 12:48:37 INFO     rasa.engine.training.hooks  - Restored component 'RulePolicy' from cache.
2022-04-30 12:48:37 INFO     rasa.engine.training.hooks  - Restored component 'TEDPolicy' from cache.
2022-04-30 12:48:37 INFO     rasa.engine.training.hooks  - Restored component 'UnexpecTEDIntentPolicy' from cache.
Your Rasa model is trained and saved at 'models/20220430-124835-small-curry.tar.gz'.

```

## To Run it 

Just type `rasa shell` to interact with your new assistant.