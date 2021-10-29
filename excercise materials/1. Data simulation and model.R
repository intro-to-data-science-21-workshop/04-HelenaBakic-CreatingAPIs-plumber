
#installation of pacman package to handle other package installations

if (!require("pacman")) install.packages("pacman")


#installing/loading packages
pacman::p_load(faux, dplyr, stats)

#data simulation
#variables: IDS final grade (1-4), number of hours 
#spent studying per week (2 - 20), average of daily sunshine hours (0 - 10)
#interest in R (1 - 10) 

set.seed(1505)

simulated <- rnorm_multi(n = 100,
                  mu = c(2, 8, 3, 7),
                  sd = c(1, 4, 5, 2),
                  r = c(1, 0.5, -0.7, 0.6,
                        0.5, 1, -0.5, 0.3,
                        -0.7, -0.5, 1, 0.1,
                        0.6, 0.3, 0.1, 1),
                  varnames = c("grade", "study_time", "sunshine", "interest"),
                  empirical = FALSE)

#truncating and rounding variables

data <- simulated %>%
  mutate(grade = round(norm2trunc(grade, 1, 4)),
         study_time = round(norm2trunc(study_time, 2, 20)),
         sunshine = round(norm2trunc(sunshine, 1, 10)),
         interest = round(norm2trunc(interest, 1, 10)))

#examining simulated data

head(data)
summary(data)
cor(data)


#model

m <- as.formula('grade ~ study_time + sunshine + interest')

model <- lm(m, data)

summary(model)
