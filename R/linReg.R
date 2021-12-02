# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'


if (F){
#----NOT RUN
  library(ISLR)
  library(MASS)
  attach(Boston)

  # multiple linear reg
   (lm.fit = lm(medv ~ lstat + age, data = Boston))
   saveRDS(lm.boston, file = "./inst/extdata/lm-boston.RDS")
}



#' Construir un JSON
#'
#' @param df A dataframe.
#out2JSON <- function(df){
#  jsonlite::toJSON(df)
#}


#' Devuelve el resultado de una regresion lineal simple ajustada al dataset "BOSTON" del paquete MASS ()
#'
#' @param lstat ....
#' @param agre ....
getPred.lm.boston <- function(lstat, age){

  lm.fit <- loadModel(model.name = "lm-boston.RDS")
  out <- predict(lm.fit,
                 data.frame("lstat" = lstat,
                            "age"   = age),
                             interval = "confidence")
  return(out)
}


if (F) {
  # dummyML::getPred.lm.s(lstat = c(5,10,15))
  dummyML::getPred.lm.boston(lstat = c(5,10,15), age = c(80, 90, 100))
}




