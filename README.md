# deployingMLinR
Deploying ML models in R: from package building to REST services.



```{bash}
./buildDocker.sh 
```

```{bash}
docker ps 

REPOSITORY                  TAG       IMAGE ID       CREATED          SIZE
dummy-ml                    latest    7ff3d6280a0a   12 days ago      1.98GB
opencpu/ubuntu-20.04        latest    7ff3d6280a0a   12 days ago      1.98GB
```

```{bash}
./runDocker 7ff3d6280a0a
```
