# create networs
docker network create net_1

# list networks
docker network ls

# Add container to a network
docker run \
--rm \
-d \
--net net_1 \
--name my_py \
-v $(pwd):/src \
python:3 \
python3 /src/run.py

# Add second container to a network
docker run \
--rm \
-it \
--net net_1 \
node:latest \
/bin/bash
# from inside this container, you can execute `ping my_py` since on they are on the same network



# Create a new network
docker network create net_2

# Add a mysql container to the network
docker run \
-d \
--rm \
-e MYSQL_ROOT_PASSWORD=abc123 \
--name my_mysql \
--net net_2 \
mysql:latest

# Add second mysql container to the network
# and connect to the first one from it
docker run \
-it \
--rm \
-e MYSQL_ROOT_PASSWORD=abc123 \
--name my_mysql2 \
--net net_2 \
mysql:latest \
/bin/bash

# access another container from my_mysql2 shell
mysql -h my_mysql -u root -p
# execute mysql commands i.e.
CREATE DATABASE test123;

-v $(pwd):/src/run.py \ ## mount present working directory (from host) on /src (of container)