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

  library(ISLR)
  library(MASS)
  attach(Boston)

  # simple linear reg
  (lm.s.fit = lm(medv ~ lstat, data = Boston))
   saveRDS(lm.s.fit, file = "./inst/extdata/lm_s-fit.RDS")

  # multiple linear reg
   (lm.m.fit = lm(medv ~ lstat + age, data = Boston))
   saveRDS(lm.m.fit, file = "./inst/extdata/lm_m-fit.RDS")

}


#' Construir un JSON
#'
#' @param df A dataframe.
#out2JSON <- function(df){
#  jsonlite::toJSON(df)
#}

loadModel <- function(model.name) {
  f = system.file("extdata", model.name, package = "dummyML")
  return(readRDS(f))
}

#' Devuelve el resultado de una regresion lineal simple ajustada al dataset "BOSTON" del paquete MASS ()
#'
#' @param df A dataframe.
getPred.lm.s <- function(lstat){
  lm.s.fit <- loadModel(model.name = "lm_s-fit.RDS")
  out <- predict(lm.s.fit,
                 data.frame("lstat" = lstat),
                 interval = "confidence")
  return(out)
}

getPred.lm.m <- function(lstat, age){
  lm.m.fit <- loadModel(model.name = "lm_m-fit.RDS")
  out <- predict(lm.m.fit,
                 data.frame("lstat" = lstat,
                            "age"   = age),
                             interval = "confidence")
  return(out)
}

#  dummyML::getPred.lm.s(lstat = c(5,10,15))
#  dummyML::getPred.lm.m(lstat = c(5,10,15), age = c(80, 90, 100))


