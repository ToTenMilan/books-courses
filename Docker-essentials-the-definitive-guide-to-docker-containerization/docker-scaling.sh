#########################
### Docker Compose
#########################

version: '3'
services: 
  python:
    image: python:3
    container_name: my_py
    volumes:
      - .:/src
    command: python3 /src/run.py
    restart: always
  mysql:
    image: mysql:latest
    container_name: my_mysql
    environment:
      - MYSQL_ROOT_PASSWORD=abc123
    restart: always
  ubuntu:
    image: ubuntu:latest
    container_name: my_ubuntu
    command: echo "hello from ubuntu"
    restart: always

- .:/src ## mount present working directory (".") on /src 
         ## what-to-mount:where-to-mount

restart: always ## what to do with container if system restarts

# Run Docker Compose

docker-compose up

# in background

docker-compose up -d

##############################
### Docker Compose scaling
##############################

########## Python Flask application

import socket
from flask import Flask
app = Flask(__name__)

// when access the root, return message
@app.route("/")
def hello():
  return "Hello: My container is named: " + socket.gethostname()

########## Nginx configuration file (LoadBalancer)

upstream serv {
        server docker-scaling_flask_1:5000; # server-name:container-port (Flask default is 5000)
        server docker-scaling_flask_2:5000;
        server docker-scaling_flask_3:5000;
        server docker-scaling_flask_4:5000;
        server docker-scaling_flask_5:5000;
        server docker-scaling_flask_6:5000;
        server docker-scaling_flask_7:5000;
        server docker-scaling_flask_8:5000;
        server docker-scaling_flask_9:5000;
        server docker-scaling_flask_10:5000;
        server docker-scaling_flask_11:5000;
        server docker-scaling_flask_12:5000;
}

server {
        listen 80;         #### this server listens on port 80
        location / {       #### When somebody tries to access root /
                proxy_pass http://serv;    ##### send traffic to one of serv's servers (from upstream)
        }
}

### docker-compose file

version: '3'
services:
  flask:
    build: .    #### look for dockerfile in pwd
    volumes:
      - ./py:/src   ### mount this directory /py folder onto /src folder
    environment:
      - FLASK_APP=/src/app.py
  nginx:
    image: nginx:latest
    ports:
      - "2000:80"      ### will be at localhost:2000 - port forwarding - take port 2000 of host (machine running docker) and forward it to port 80 of container (load balancer is listening on port 80) 
    volumes:
      - ./nginx:/etc/nginx/conf.d   ### mount nginx/nginx.conf file onto container's file wher nginx is usually looks for configuration file
    depends_on:
      - flask       #### start nginx only when all flask instances are already started


#### Dockerfile (Flask image)

FROM python:3

RUN pip3 install flask

CMD flask run --host=0.0.0.0


##### Command to run

docker-compose up --scale flask=12      ##### --scale flask=12 --> start 12 flask containers