
#' Regresion lineal Boston
#'
#' Devuelve el resultado de una regresion lineal multiple ajustada al dataset \code{\link[MASS]{Boston}}.
#'
#' @param lstat Numeric vector, lower status of the population (percent).
#' @param age Numeric vector, proportion of owner-occupied units built prior to 1940.
#' @return A dataframe, first row is the fit, second is lwr, third is upr.
#' @examples
#' getPred.lm.boston(lstat = c(5,10,15), age = c(80, 90, 100))
#' @seealso \code{\link{getPred.ranger.pima}}
#' @author Yago
#' \email{josevicente.yago@@um.es}
getPred.lm.boston <- function(lstat, age){

  lm.fit <- loadModel(model.name = "lm-boston.RDS")
  out <- predict(lm.fit,
                 data.frame("lstat" = lstat,
                            "age"   = age),
                             interval = "confidence")
  return(data.frame(out))
}





