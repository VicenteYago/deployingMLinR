FROM opencpu/ubuntu-20.04

RUN sudo apt install build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev
RUN R -e "install.packages(c('xml2', 'devtools'), dependencies = T)"
RUN R -e "devtools::install_github('https://github.com/VicenteYago/deployingMLinR', ref = 'dev' )"


