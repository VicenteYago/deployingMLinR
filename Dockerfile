FROM rocker/tidyverse

# OPENCPU ---> https://opencpu.github.io/server-manual/opencpu-server.pdf
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt-get install -y mailutils

RUN sudo apt-get update 
RUN sudo apt-get upgrade -y
RUN sudo apt-get install software-properties-common -y
RUN sudo add-apt-repository ppa:opencpu/opencpu-2.2 -y
RUN sudo apt-get update
RUN sudo apt-get install -y opencpu-server

RUN sudo a2ensite opencpu
RUN sudo apachectl restart

# LIBRERIAS TOP
RUN R -e "install.packages(c('tidymodels', 'ranger', 'tidypredict'), dependencies = T)"

#KERAS + TENSORFLOW ---> https://tensorflow.rstudio.com/installation/
#RUN R -e "install.packages('tensorflow')"
#RUN R -e "tensorflow::install_tensorflow()"
#RUN R -e "install.packages('keras')"

# NUESTRO PAQUETE 
RUN R -e "devtools::install_github('https://github.com/VicenteYago/deployingMLinR', ref = 'dev')"


