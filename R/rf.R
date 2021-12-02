
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




