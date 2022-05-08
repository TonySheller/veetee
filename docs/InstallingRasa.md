# Installing Rasa

One should have setup a Python virutal environment of their choosing. I chose to use Ananconda but a normal Python virtual environment will be fine. This section is if one wanted to develop with Rasa. Docker will not be needed until later.

Install rasa into a python virtual environment or Anaconda


```.shell
pip3 install -U --user pip && pip3 install rasa[full]
```

Rasa is much more than a python module, it's an envrionemnt so we'll setup a basic chat model and work through a few things next.


