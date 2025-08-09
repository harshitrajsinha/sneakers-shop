FROM postgres:latest

COPY init.sh /docker-entrypoint-initdb.d/
COPY init.sql /docker-entrypoint-initdb.d/
COPY logs_init.sql /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh
