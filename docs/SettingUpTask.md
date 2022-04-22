# Defining a task

To really get the most out of rasa there are some additional things that must be done so that it will fit your needs. 

My definition of task is actually an *action* in Rasa.  The time example provided is a good one to look over.  For our action we will use check_storage.

# Define intent.
First define intent by modifying the *data/nlu.yml* file.  There are already some examples in there so go with it. I defined *check_storage* like this:

```

- intent: check_storage
  examples: |
    - Provide drive status.
    - Provide drive status please.
    - disk status.
    - storage please
    - storage status please.

```

So I only have 5 items displayed but add more as they come to you.  `Intent` is derived from these so the exact wording won't be necessary when its trained.

The responses are kept in the *domain.yml* file at the base of the project. Be sure to define your intents at the top of the file. 

```
 utter_storage:
  - text: "One sec' while i check."

```

Open up the *data/stories.yml* file and add a story for checking storage. This is what it might look like.

```

- story: get storage
  steps:
    - intent: greet
    - action: utter_greet
    - intent: check_storage
    - action: get_storage
    - action: utter_what_else

```


