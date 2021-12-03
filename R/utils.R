


loadModel <- function(model.name) {
  f = system.file("extdata", model.name, package = "dummyML")
  return(readRDS(f))
}
