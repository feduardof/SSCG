 
# SSCG

This program has a propose to generate a free and valid certificate for your intranet.
This program generate a self signed certificate CARoot and a signed certificate from CARoot to be used with your internal server https. 

## Dependecies 

The dependecy of this program are only docker and docker-compose

## How to use

> **Warning**: Don't execute this procedure in your server, because the only thing that is necessary is the file generated by this program. 

First thing that you need to do is clone this project, go to project path and open the files of configuration `server.csr.config` and `rootca.csr.config`. 

Change the properties of `req_distinguished_name` and `alt_names` (only in server.srv.config)

>[req_distinguished_name] 
countryName  = US
localityName = 
organizationName  = 
organizationalUnitName  = 
commonName =


After this, execute:
> docker-compose up

The program will generate somes files in data/cert path. The only files that is important to you are: 

- rootCA.crt
- server.crt
- server.key

The rootCA.crt need be install in the PC of the users. The server.crt and server.key need be install in the server http.