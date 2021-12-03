
#' TidyModels RandomForest Indian Pima Diabetes
#'
#' Pronosticar si una indigena pima es diabetica con un random Forest ajustado al dataset IndianPimaDiabetes del paquete MLBench.
#'
#' @param pregnant Numeric, number of times pregnant
#' @param glucose Numeric, plasma glucose concentration a 2 hours in an oral glucose tolerance test
#' @param pressure Numeric, Diastolic blood pressure (mm Hg)
#' @param triceps Numeric, Triceps skin fold thickness (mm)
#' @param insulin Numeric, 2-Hour serum insulin (mu U/ml)
#' @param mass Numeric, body mass index (weight in kg/(height in m)\^2)
#' @param pedigree Numeric, diabetes pedigree function
#' @param age Numeric, age (years)
#' @return Logical: True si diabetico, Falso si no.
#' @examples
#' getPred.ranger.pima(pregnant = 2, glucose = 95, pressure = 70, triceps = 31, insulin = 102, mass = 28.2, pedigree = 0.67, age = 23)
#' @seealso \code{\link[parsnip]{rand_forest}}
#' @seealso \code{\link{getPred.lm.boston}}
#' @author Yago
#' \email{josevicente.yago@@um.es}
#' @import tidymodels
#' @import workflows
#' @import tune
#' @import mlbench
#' @export
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





