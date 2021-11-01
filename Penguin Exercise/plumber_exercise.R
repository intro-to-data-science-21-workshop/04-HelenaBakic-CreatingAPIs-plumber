#* @apiTitle Plumber Example API


################################################################################
#
# Citation: please refer to https://allisonhorst.github.io/palmerpenguins/index.html
# for any additional information of the Palmer Penguin Data Set.
#
# Similarly, refer to https://www.youtube.com/watch?v=J0Th2QRZ7Rk for a thorough
# explanation of the plumber package and how to integrate APIs.
#
################################################################################


#################################################################################
#
# Load all relevant plumber packages
#
library(plumber)
library(jsonlite)
library(yaml)

# Library needed for data
library(palmerpenguins)

# Libraries needed for the model
library(ranger)
library(parsnip)
library(tidyverse)

# Source all data and model info constructed previously, make sure this 
# "ModelInfo.R file is saved in the same folder as the plumber file.
source("./ModelInfo.R")
model <- readr::read_rds("./model.rds")

#################################################################################
#
# First things first, make sure you have the plumber package installed already.
# Start things off by opening a new Plumber API (under File -> New File -> 
# Plumber API), the new file should contain some script already. Go ahead 
# and press "Run API" at the top of this window. You should see an API pop up,
# test out each of the three functions to get an idea of what you'll do today.
# Once you're done, have a look at the exercises below.
#
#################################################################################

#
# Task 1: Create a simple System check, to see whether the API is running
# correctly on your screen. Use the @get tag to request a resource.
# You can call the end node "/checkup". 
# Create a function that returns a little message of your choice, as well as
# the current system time. Hint: you can use the function Sys.time().
#

#* System check
#* @_____ /_____
running <- function() {
  list(
    running = "_____",
    time = _____
  )
}


# Task 2: Ask the user to input their name and return a warm welcome message.
# Hint: take a look at the coding of the echo node that is part of the 
# automated Plumber script. Think about any parameters you might want to include.

#* Friendly Welcome Message
#* @param _____
#* _____ /welcome
function(_____ = "") {
  list(paste0("Hello ", name, ", well done. You have successfully interacted with an API!"))
}


#
# Task 3: Take a look into the ModelInfo.R file and get a feel for the data you
# will be working with next. In this task you should plot a simple histogram of 
# any data you are particularly interested in from the data set. Is a post
# or a get tag appropriate here? Can you motivate your answer?
#


#* Plot a histogram
#* @_____
#* _____
function() {
  _____ <- penguin_data$_____
  hist(_____, xlab = "_____")
}

#
# Task 3: Of course in the ideal scenario we can create an api that doesn't 
# require any R knowledge from the other ends user. In order to do this, we have
# created a ranger model (loaded as such, check code in the beginning of the file)
# that uses the data from the penguin set in order to make predictions about
# the penguin's species, based on the other data provided. 
# We want to load this model into our API such that another user can enter data 
# and the API will return the probabilities that these observations match one
# of our three species. Run the following line of code for an example of the
# expected response from the API.

predict(model, new_data = jsonlite::read_json("./new_penguins.json", simplifyVector = TRUE), type = "prob")

#
# For this to work we need to pass a request "req" and a response "res" to the 
# function. As the output, we want the probabilities that our observations 
# match each penguin species, don't forget to specify the type!
# Hint: The new_data we feed into the predict function can be accessed by
# req$body. 
#
################################################################################
################################################################################
#
# Important! To get this last part of the code to run successfully, you need to
# remove the number symbols "#" infront of the last part of the code. 
# This reads a .yaml file that overwrites the plumber API specification. It 
# allows for interaction with the API for this specific model. The structure of
# this .yaml file can be adapted to other codes as well.
#
################################################################################
################################################################################


#* Predict Species for new Penguin
#* @post /predict

function(_____, _____) {
  predict(model, new_data = _____, _____ )
}


# Un-comment the following section of code to run the final Task.

# #* @plumber 
# #* 
# 
# function(pr) {
#   pr %>% 
#     pr_set_api_spec(yaml::read_yaml("./newPenguin.yaml"))
# }

