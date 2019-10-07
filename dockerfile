FROM ubuntu:18.04
RUN apt-get update && apt-get upgrade -y
RUN apt-get install openssl -y
RUN mkdir /cert
RUN cd /cert
COPY ./server.csr.config /cert/server.csr.config
COPY ./rootca.csr.config /cert/rootca.csr.config
RUN openssl genrsa -out /cert/rootCA.key 4096 
RUN openssl req -x509 -new -nodes -key /cert/rootCA.key -sha512 -days 1024 -out /cert/rootCA.crt -config /cert/rootca.csr.config 
RUN openssl genrsa -out /cert/server.key 4096 
RUN openssl req -new -key /cert/server.key -out /cert/server.csr -config /cert/server.csr.config 
RUN openssl x509 -req -in /cert/server.csr -CA /cert/rootCA.crt -CAkey /cert/rootCA.key -CAcreateserial -out /cert/server.crt -days 500 -sha512
COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s /usr/local/bin/docker-entrypoint.sh /
VOLUME [ "/data" ]
ENTRYPOINT [ "docker-entrypoint.sh" ]
