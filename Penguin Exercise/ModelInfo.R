################################################################################
#
# Citation: please refer to https://allisonhorst.github.io/palmerpenguins/index.html
# for any additional information of the Palmer Penguin Data Set.
#
# Similarly, refer to https://www.youtube.com/watch?v=J0Th2QRZ7Rk for a thorough
# explanation of the plumber package and how to integrate APIs.
#
################################################################################


#
# Load the Penguin Data Set
#

completeset <- data(package = "palmerpenguins")
head(penguins)
penguin_data <- as.data.frame(na.omit(penguins))
head(penguin_data)

#
# Create a sample data set, used to make predictions in the API
#

sample <- sample_n(penguin_data, 1)
write_json(sample, "./new_penguins.json")

#
# Construct the model
#

model <- rand_forest() %>%
  set_engine ("ranger") %>%
  set_mode("classification") %>%
  fit(species ~ bill_length_mm + bill_depth_mm + flipper_length_mm + 
        body_mass_g, data = penguin_data)

model

readr::write_rds(model, "./model.rds")


#
# Plotting the model
#
#

ggplot(penguin_data, aes(x = body_mass_g, y = flipper_length_mm, col = species, shape = species)) +
  geom_point() + 
  geom_smooth(method = lm, se = F) +
  theme_minimal() +
  labs(title = "Flipper Length and Body Mass of the Palmer Penguins") + ylab("Flipper Length (mm)") + xlab("Body Mass (g)") +
  scale_color_manual(values = wes_palette(n=3, name="GrandBudapest2"))
