

if (F){
  # https://www.rebeccabarter.com/blog/2020-03-25_machine_learning/

  library(tidymodels)
  library(tidyverse)
  library(workflows)
  library(tune)
  library(mlbench)

  data(PimaIndiansDiabetes)
  diabetes_orig <- PimaIndiansDiabetes


  diabetes_clean <- diabetes_orig %>%
    mutate_at(vars(triceps, glucose, pressure, insulin, mass),
              function(.var) {
                if_else(condition = (.var == 0), # if true (i.e. the entry is 0)
                        true = as.numeric(NA),  # replace the value with NA
                        false = .var # otherwise leave it as it is
                )
              })


  set.seed(234589)
  # split the data into trainng (75%) and testing (25%)
  diabetes_split <- initial_split(diabetes_clean,
                                  prop = 3/4)

  # extract training and testing sets
  diabetes_train <- training(diabetes_split)
  diabetes_test <- testing(diabetes_split)

  # create CV object from training data
  diabetes_cv <- vfold_cv(diabetes_train)


  # define the recipe
  diabetes_recipe <-
    # which consists of the formula (outcome ~ predictors)
    recipe(diabetes ~ pregnant + glucose + pressure + triceps +
             insulin + mass + pedigree + age,
           data = diabetes_clean) %>%
    # and some pre-processing steps
    step_normalize(all_numeric()) %>%
    step_knnimpute(all_predictors())

  rf_model <-
    # specify that the model is a random forest
    rand_forest() %>%
    # specify that the `mtry` parameter needs to be tuned
    set_args(mtry = tune()) %>%
    # select the engine/package that underlies the model
    set_engine("ranger", importance = "impurity") %>%
    # choose either the continuous regression or binary classification mode
    set_mode("classification")


  # set the workflow
  rf_workflow <- workflow() %>%
    # add the recipe
    add_recipe(diabetes_recipe) %>%
    # add the model
    add_model(rf_model)


  # specify which values eant to try
  rf_grid <- expand.grid(mtry = c(3, 4, 5))
  # extract results
  rf_tune_results <- rf_workflow %>%
    tune_grid(resamples = diabetes_cv, #CV object
              grid = rf_grid, # grid of values to try
              metrics = metric_set(accuracy, roc_auc) # metrics we care about
    )

  final_model <- fit(rf_workflow, diabetes_clean)
  saveRDS(final_model, file = "./inst/extdata/ranger_pima.RDS")
}


# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

getPred.ranger.pima <- function(pregnant, glucose, pressure, triceps, insulin, mass, pedigree, age) {

  loadModel <- function(model.name) {
    f = system.file("extdata", model.name, package = "dummyML")
    return(readRDS(f))
  }

  fit <- loadModel(model.name = "ranger_pima.RDS")


  new_woman <- tibble::tribble(~pregnant, ~glucose, ~pressure, ~triceps, ~insulin, ~mass, ~pedigree, ~age,
                                pregnant , glucose, pressure, triceps, insulin, mass, pedigree, age)

  out <- predict(fit, new_woman)
  return(out)
}


if(F){
dummyML::getPred.ranger.pima(pregnant = 2,
                             glucose  = 95,
                             pressure = 70,
                             triceps  = 31,
                             insulin  = 102,
                             mass     = 28.2,
                             pedigree = 0.67,
                             age      = 23)

  }




