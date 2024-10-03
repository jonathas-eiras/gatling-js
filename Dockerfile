# Usar a imagem base do Alpine Linux
FROM node:18-alpine

# Definir a versão do Gatling
ENV GATLING_VERSION 3.9.5
ENV GATLING_HOME /opt/gatling

# Instalar dependências necessárias: wget, bash e unzip
RUN apk add --update wget bash unzip libc6-compat && \
    rm -rf /var/cache/apk/*

# Baixar o Gatling bundle e extraí-lo
RUN mkdir -p /tmp/downloads && \
    wget -q -O /tmp/downloads/gatling-$GATLING_VERSION.zip \
    https://repo1.maven.org/maven2/io/gatling/gatling-charts-highcharts-bundle/$GATLING_VERSION/gatling-charts-highcharts-bundle-$GATLING_VERSION-bundle.zip && \
    mkdir -p /tmp/archive && \
    unzip /tmp/downloads/gatling-$GATLING_VERSION.zip -d /tmp/archive && \
    mv /tmp/archive/gatling-charts-highcharts-bundle-$GATLING_VERSION/* /opt/gatling/ && \
    rm -rf /tmp/*

# Definir o diretório de trabalho para Gatling
WORKDIR /opt/gatling

# Copiar os arquivos package.json e package-lock.json para instalar dependências do Node.js
COPY ./javascript/package.json ./javascript/package-lock.json ./

# Instalar as dependências do projeto
RUN npm install @gatling.io/core @gatling.io/http @faker-js/faker

# Copiar o script de simulação para o diretório correto
COPY ./javascript/src/purchaseTicket-load.gatling.js /opt/gatling/user-files/simulations/purchaseTicket-load.gatling.js

# Expor o diretório de resultados
VOLUME /opt/gatling/results

# Comando para executar o Gatling
CMD ["bin/gatling.sh", "-s", "purchaseTicket-load"]
