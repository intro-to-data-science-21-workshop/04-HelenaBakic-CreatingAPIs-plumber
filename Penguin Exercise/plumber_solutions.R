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

################################################################################
#
#
# NOTE FOR THIS EXERCISE TO WORK, MAKE SURE YOU HAVE DOWNLOADED ALL FILES FROM 
# THE GITHUB REPOSITORY INTO ONE FOLDER. OTHERWISE THE FILE WILL NOT RUN.
#
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

# Libraries needed for plots in ModelInfo.R
library(ggplot2)
library(wesanderson)

# Source all data and model info constructed previously, make sure this 
# "ModelInfo.R file is saved in the same folder as the plumber file.
source("./ModelInfo.R")
model <- readr::read_rds("./model.rds")

################################################################################
# Task 1
################################################################################

#* System check
#* @get /checkup
running <- function() {
  list(
    running = "System is up and Running!",
    time = Sys.time()
  )
}


################################################################################
# Task 2
################################################################################

#* Friendly Welcome Message
#* @param name Enter your name to be welcomed
#* @post /welcome
function(name = "") {
  list(paste0("Hello ", name, ", well done. You have successfully interacted with an API!"))
}


################################################################################
# Task 3
################################################################################


#* Plot a histogram
#* @png
#* @get /plot
function() {
  flipperdist <- penguin_data$flipper_length_mm
  hist(flipperdist, xlab = "Flipper Length (mm)")
}

################################################################################
# Task 4
################################################################################

# Run the following line of code for an example of the
# expected response from the API.

predict(model, new_data = jsonlite::read_json("./new_penguins.json", simplifyVector = TRUE), type = "prob")


#* Predict Species for new Penguin
#* @post /predict

function(req, res) {
  predict(model, new_data = req$body, type = "prob" )
}


#* @plumber 
#* 

function(pr) {
 pr %>% 
   pr_set_api_spec(yaml::read_yaml("./newPenguin.yaml"))
}
