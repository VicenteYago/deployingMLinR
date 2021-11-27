# deployingMLinR
Deploying ML models in R: from package building to REST services.



```{bash}
./buildDocker.sh 
```

```{bash}
sudo docker images 

REPOSITORY                  TAG       IMAGE ID       CREATED          SIZE
dummy-ml                    latest    7ff3d6280a0a   12 days ago      1.98GB
opencpu/ubuntu-20.04        latest    7ff3d6280a0a   12 days ago      1.98GB
```

```{bash}
./runDocker 7ff3d6280a0a
```

```{bash}
sudo docker ps 
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                                                  NAMES
2a2bd553cb1e   7ff3d6280a0a   "/bin/sh -c 'service…"   5 minutes ago   Up 5 minutes   443/tcp, 8004/tcp, 0.0.0.0:85->80/tcp, :::85->80/tcp   interesting_roentgen
```


```{bash}
./toDocker 2a2bd553cb1e
```

