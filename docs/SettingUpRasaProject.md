# The Rasa Project

To get started create a directory to intialize the project in. I just created a folder called *rasa*.

Follow this by changing directory into the folder and doing:

```shell

rasa init

(RASA) acshell@ip-10-114-74-48:~/k8sChatbot/rasa$ rasa init
┌────────────────────────────────────────────────────────────────────────────────┐
│ Rasa Open Source reports anonymous usage telemetry to help improve the product │
│ for all its users.                                                             │
│                                                                                │
│ If you'd like to opt-out, you can use `rasa telemetry disable`.                │
│ To learn more, check out https://rasa.com/docs/rasa/telemetry/telemetry.       │
└────────────────────────────────────────────────────────────────────────────────┘
Welcome to Rasa! 🤖

To get started quickly, an initial project will be created.
If you need some help, check out the documentation at https://rasa.com/docs/rasa.
Now let's start! 👇🏽

? Please enter a path where the project will be created [default: current directory]               

```

I press enter to accept the current directory.

```shell
? Please enter a path where the project will be created [default: current directory]                  
Created project directory at '/home/acshell/k8sChatbot/rasa'.
Finished creating project structure.
? Do you want to train an initial model? 💪🏽(Yn)                                                                           
```

I say yes.

## Keep in mind

At this point, it will ask:

```
? Do you want to speak to the trained assistant on the command line? 🤖 Yes


```

the *assistant* does not have alot of data to train on so it's not going to answer general questions very well. Now it's up to you to provide that data.