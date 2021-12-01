# deployingMLinR
Deploying ML models in R: from package building to REST services.

## DESCARGAR EL PROYECTO EN NUESTRO PC

Abrimos la terminal (Ctrl + Alt + T) y navegamos hasta la carpeta en la que vamos a clonar el proyecto, por ejemplo la carpeta Documents/

```{bash}
cd Documents/
git clone git@github.com:VicenteYago/deployingMLinR.git
```
Una vez descargado, nos situamos dentro del proyecto: 

```{bash}
cd deployingMLinR
```

y echamos un vistazo a los ficheros: 

```{bash}
-rwxrw-r-- 1 vyago vyago   46 nov 25 21:08 buildDocker.sh
-rw-rw-r-- 1 vyago vyago  391 nov 28 00:15 DESCRIPTION
-rw-rw-r-- 1 vyago vyago  277 nov 28 00:33 Dockerfile
-rw-rw-r-- 1 vyago vyago  356 nov 28 00:53 dummyML.Rproj
drwxrwxr-x 3 vyago vyago 4096 nov 21 16:44 inst
drwxrwxr-x 2 vyago vyago 4096 nov 28 00:15 man
-rw-rw-r-- 1 vyago vyago   31 nov 21 16:31 NAMESPACE
drwxrwxr-x 2 vyago vyago 4096 nov 28 00:20 R
-rw-rw-r-- 1 vyago vyago  806 nov 28 00:55 README.md
-rwxrw-r-- 1 vyago vyago   45 nov 25 21:30 runDocker.sh
-rwxrw-r-- 1 vyago vyago   51 nov 25 21:35 toDocker.sh
```

Parece el contenido de un paquete R normal, a excepcion del fichero **Dockerfile**.


## CONSTRUIR IMAGEN DOCKER

* ¿Que hay dentro del Dockerfile?

```{Dockerfile}
FROM rocker/tidyverse

# OPENCPU ---> https://opencpu.github.io/server-manual/opencpu-server.pdf
RUN sudo apt-get install software-properties-common
RUN sudo add-apt-repository ppa:opencpu/opencpu-2.2 -y
sudo apt-get update
sudo apt-get install opencpu-server

sudo a2ensite opencpu
sudo apachectl restart

# LIBRERIAS TOP
RUN R -e "install.packages(c('tidymodels', 'ranger', 'tidypredict'), dependencies = T)"

#KERAS + TENSORFLOW ---> https://tensorflow.rstudio.com/installation/
#RUN R -e "install.packages('tensorflow')"
#RUN R -e "tensorflow::install_tensorflow()"
#RUN R -e "install.packages('keras')"


# NUESTRO PAQUETE 
RUN R -e "devtools::install_github('https://github.com/VicenteYago/deployingMLinR', ref = 'dev')"
```

Construimos la imagen: 
```{bash}
./buildDocker.sh 
```

Verificamos que  la imagen se ha creado en nuestro pc : 
```{bash}
sudo docker images 

REPOSITORY      TAG       IMAGE ID       CREATED          SIZE
dummy-ml       latest    <image_id>    12 days ago       1.98GB
```

Y ejecutamos el contendor: 

```{bash}
./runDocker <image_id>
```

Verificamos que esta corriendo: 
```{bash}
sudo docker ps 
CONTAINER ID       IMAGE          COMMAND                CREATED         STATUS         PORTS                                                  NAMES
<container_id>  <image_id>   "/bin/sh -c 'service…"   5 minutes ago   Up 5 minutes   443/tcp, 8004/tcp, 0.0.0.0:85->80/tcp, :::85->80/tcp   interesting_roentgen
```

Incluso podemos echar un vistazo dentro: 
```{bash}
./toDocker <container_id>
```
Podemos regresar a nuestro pc con Ctrl + d


## EJECUTAMOS LOS MODELOS DE FORMA REMOTA

```{bash}
curl http://localhost:85/ocpu/library/dummyML/R/getPred.lm.s/json?auto_unbox=true -H "Content-Type: application/json" -d '{"lstat":[5,10,15]}'
```

```{json}
[
  [29.8036, 29.0074, 30.5998],
  [25.0533, 24.4741, 25.6326],
  [20.3031, 19.7316, 20.8746]
]
```


```{bash}
curl http://localhost:85/ocpu/library/dummyML/R/getPred.lm.m/json?auto_unbox=true -H "Content-Type: application/json" -d '{"lstat":[5,10,15], "age":[80,90,100]}'
```


```{json}
[
  [30.826, 29.7627, 31.8893],
  [26.0111, 25.1311, 26.891],
  [21.1962, 20.3549, 22.0375]
]
```






