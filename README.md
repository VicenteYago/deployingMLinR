# Depliegue de ML con R: creacion de paquetes y API


## Introducción

Hola!, con este repositorio aprenderemos a crear paquetes R para nuestros modelos y a desplegarlos con una API a través de openCPU.

El repositorio consta de 3 ramas: 
* **main** : rama principal, en la que estas ahora mismo, aqui se reunen los principales recursos para este taller.
* **[r-package](https://github.com/VicenteYago/deployingMLinR/tree/r-package)**: aqui esta todo lo necesario para crear un paquete que unifica varios modelos preentrenados listos para ser desplegados con opencpu (explicación en el readme.md)
* **[models](https://github.com/VicenteYago/deployingMLinR/tree/models)**: aqui se encuentran los scripts con los que se han entrenadlos los modelos de la rama r-package. En una aplicacion real seria un notebook bien desarrollado.




## R packages : 

* El mejor recurso: https://r-pkgs.org/    
* Algunos packetes profesionales para examinar: 
  * https://github.com/robjhyndman/forecast
  * https://github.com/tidyverse/dplyr


## Docker :
 * La fuente de imagenes docker mas importante para R: https://www.rocker-project.org/
 * Para openCPU : https://hub.docker.com/u/opencpu
## Opencpu :
 * https://www.opencpu.org/
 * Como dar de alta un servidor opencpu + configuracion (PDF) : https://opencpu.github.io/server-manual/opencpu-server.pdf
    * Resumido: https://www.opencpu.org/download.html
 * Probar opencpu rapidamente: `docker run --name mybox -t -p 8004:8004 opencpu/rstudio`
    * `curl http:localhost:8004/ocpu/library/stats/R/rnorm -d "n=10&mean=5"`
    * `curl http://localhost:8004/ocpu/library/stats/R/rnorm/json -d "n=10&mean=5"`
 * Tambien puede devolvernos imagenes:
    * `curl http://localhost:8004/ocpu/library/MASS/R/truehist -d "data=[1,3,7,4,2,4,2,6,23,13,5,2]"`  
 * Ejemplos de apps hechas con opencpu : https://www.opencpu.org/apps.html
           
