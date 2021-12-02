FROM rocker/tidyverse:4.1.0

# OPENCPU ---> https://opencpu.github.io/server-manual/opencpu-server.pdf
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt-get install -y mailutils # https://stackoverflow.com/questions/40890011/ubuntu-dockerfile-mailutils-install

RUN sudo apt-get update
RUN sudo apt-get upgrade -y
RUN sudo apt-get install software-properties-common -y
RUN sudo add-apt-repository ppa:opencpu/opencpu-2.2 -y
RUN sudo apt-get update
RUN sudo apt-get install -y opencpu-server

RUN sudo a2ensite opencpu
RUN sudo apachectl restart

# LIBRERIAS ML
RUN R -e "install.packages(c('tidymodels', 'ranger', 'tidypredict'), dependencies = T)"

# NUESTRO PAQUETE
RUN R -e "devtools::install_github('https://github.com/VicenteYago/deployingMLinR', ref = 'dev')"

#KERAS + TENSORFLOW ---> https://tensorflow.rstudio.com/installation/
#RUN R -e "install.packages('tensorflow')"
#RUN R -e "tensorflow::install_tensorflow()"
#RUN R -e "install.packages('keras')"
