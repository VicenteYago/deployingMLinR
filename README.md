# deployingMLinR : Paquete dummyML

Bienvenidos a la rama **r-package** ! Aqui se encuentra el paquete dummyML que usaremos en el taller.

## DESCARGAR EL PROYECTO EN NUESTRO PC

Abrimos la terminal (Ctrl + Alt + T) y navegamos hasta la carpeta en la que vamos a clonar el proyecto, por ejemplo la carpeta Documents/

```{bash}
cd ~/Documents
```
Y clonaomos el repositorio:
```{bash}
git clone git@github.com:VicenteYago/deployingMLinR.git
```
Una vez descargado, nos situamos dentro del proyecto: 

```{bash}
cd deployingMLinR
```

y echamos un vistazo a los ficheros con *ls -l* : 

```{bash}
total 44
-rwxrwxr-x 1 vyago vyago   57 dic  2 14:27 buildDocker.sh
-rw-rw-r-- 1 vyago vyago  391 nov 28 00:15 DESCRIPTION
-rw-rw-r-- 1 vyago vyago 1231 dic  2 14:27 Dockerfile
-rw-rw-r-- 1 vyago vyago  356 dic  2 15:24 dummyML.Rproj
drwxrwxr-x 3 vyago vyago 4096 dic  2 14:27 inst
drwxrwxr-x 2 vyago vyago 4096 dic  2 15:13 man
-rw-rw-r-- 1 vyago vyago  115 dic  2 15:13 NAMESPACE
drwxrwxr-x 2 vyago vyago 4096 dic  2 14:27 R
-rw-rw-r-- 1 vyago vyago 3552 dic  2 14:27 README.md
-rwxrw-r-- 1 vyago vyago   45 nov 25 21:30 runDocker.sh
-rwxrw-r-- 1 vyago vyago   51 nov 25 21:35 toDocker.sh
```

Parece el contenido de un paquete R normal, a excepcion del fichero **Dockerfile** y los scripts .sh


## CONSTRUIR IMAGEN DOCKER Y DESPLEGAR SERVICIOS

¿Que hay dentro del Dockerfile?

  [Dockerfile](Dockerfile)



Construimos la imagen:

* **Atencion!!: El siguiente comando puede tardar bastante en compilar en funcion de la capaciad de vuestro pc**

  ```{bash}
  ./buildDocker.sh 
  ```
* **Por eso he subido la imagen ya compilada a [dockerhub](https://hub.docker.com/r/vyago/dummy-ml-umur)
 para que solo tengais que descargarla:**
    ```{bash}
    docker pull vyago/dummy-ml-umur
    ```


Verificamos que  la imagen se ha creado en nuestro pc : 
```{bash}
sudo docker images 

REPOSITORY      TAG       IMAGE ID       CREATED          SIZE
dummy-ml       latest    <image_id>    12 days ago       1.98GB
```

Y ejecutamos el contendor: 

```{bash}
./runDocker <image_id> <port>
./runDocker <image_id> 80
```

Verificamos que esta corriendo: 
```{bash}
sudo docker ps 
CONTAINER ID       IMAGE          COMMAND                CREATED         STATUS         PORTS                                                  NAMES
<container_id>  <image_id>   "/bin/sh -c 'service…"   5 minutes ago   Up 5 minutes   443/tcp, 8004/tcp, 0.0.0.0:85->80/tcp, :::85->80/tcp   interesting_roentgen
```

Nos metemos dentro del contendor: 
```{bash}
./toDocker <container_id>
```
Y  [activamos](https://opencpu.github.io/server-manual/opencpu-server.pdf) el servicio opencpu   : 

```{bash}
sudo a2ensite opencpu
sudo apachectl restart
```


Podemos regresar a nuestra máquina con Ctrl + d


## EJECUTAMOS LOS MODELOS DE FORMA REMOTA

### Regresion Lineal Multiple con Boston

```{bash}
curl http://localhost:80/ocpu/library/dummyML/R/getPred.lm.boston/json?auto_unbox=true -H "Content-Type: application/json" -d '{"lstat":[5,10,15], "age":[80,90,100]}'
```

```{json}
[
  [30.826, 29.7627, 31.8893],
  [26.0111, 25.1311, 26.891],
  [21.1962, 20.3549, 22.0375]
]
```

### Clasificación con Random Forest en Dataset Indios Pina.

```{bash}
curl http://localhost:80/ocpu/library/dummyML/R/getPred.ranger.pima/json?auto_unbox=true -H "Content-Type: application/json" -d '{"pregnant":[2], "glucose":[95], "pressure":[70], "triceps":[31], "insulin":[102], "mass":[28.2], "pedigree":[0.67], "age":[23]}'
```


```{json}
[
  {
    ".pred_class": "neg"
  }
]

```
*Estos comandos tienen truco, en realidad no es de forma remota pues estamos utilizando nuestra propia maquina (localhost), si hubiesemos desplegado los modelos en un servidor el comando seria igual pero sustituyendo localhost por la ip del mismo*

# Pagina de Test Opencpu

http://localhost:80/ocpu/test/



