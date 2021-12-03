

#' loadModel: Cargar modelos preetrenados
#'
#' Los modelos se cargan del directorio /inst/extdata para hacer las predicciones
#'
#' @param model.name String
loadModel <- function(model.name) {
  f = system.file("extdata", model.name, package = "dummyML")
  return(readRDS(f))
}
