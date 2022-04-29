#!/bin/sh

# VEETEE Virtual Teammate
# ashelle5@jhu.edu

# This script is copied into a Docker container and is used to 
# train the NLU model for that the rasa chatbot will use.

echo "Training Rasa Server"
# Get into the approproiate direectory
# Turn off the telementry -- not necessary and is kind of bothersome
# Train the model
(cd /home/veetee/rasa; rasa telemetry disable; rasa train )