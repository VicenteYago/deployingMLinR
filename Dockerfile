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


