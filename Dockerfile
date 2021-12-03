FROM rocker/tidyverse:latest


#    R Package Manager fix  https://github.com/rocker-org/rocker-versioned2/issues/301#issuecomment-984679756
#RUN echo 'options(repos = c(CRAN = "https://cloud.r-project.org"))' >> ${R_HOME}/etc/Rprofile.site


# OPENCPU ---> https://opencpu.github.io/server-manual/opencpu-server.pdf
#    apache mail server fix  https://stackoverflow.com/questions/40890011/ubuntu-dockerfile-mailutils-install
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt-get install -y mailutils # https://stackoverflow.com/questions/40890011/ubuntu-dockerfile-mailutils-install

RUN sudo apt-get update
RUN sudo apt-get upgrade -y
RUN sudo apt-get install software-properties-common -y
RUN sudo add-apt-repository ppa:opencpu/opencpu-2.2 -y
RUN sudo apt-get update
RUN sudo apt-get install -y opencpu-server

# LIBRERIAS ML
RUN R -e "install.packages(c('tidymodels'), dependencies = T)"
RUN R -e "install.packages(c('ranger'), dependencies = T)"
RUN R -e "install.packages(c('tidypredict'), dependencies = T)"

# NUESTRO PAQUETE
RUN R -e "devtools::install_github('https://github.com/VicenteYago/deployingMLinR', ref = 'dev')"

#KERAS + TENSORFLOW ---> https://tensorflow.rstudio.com/installation/
#RUN R -e "install.packages('tensorflow')"
#RUN R -e "tensorflow::install_tensorflow()"
#RUN R -e "install.packages('keras')"
