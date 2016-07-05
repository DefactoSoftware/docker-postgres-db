FROM ubuntu
 
ENV PG_VERSION 9.3
ENV USER docker
ENV PASS docker
ENV PGDATA /var/lib/postgresql/$PG_VERSION/main
ENV PGRUN /var/run/postgresql
 
RUN \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" \
       > /etc/apt/sources.list.d/pgdg.list && \
  curl -sL https://www.postgresql.org/media/keys/ACCC4CF8.asc \
       | apt-key add - && \
  apt-get update && \
  apt-get -y install \
          postgresql-${PG_VERSION} \
          postgresql-contrib-${PG_VERSION} && \
  rm -rf /var/lib/apt/lists/*
 
RUN \
  echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/${PG_VERSION}/main/pg_hba.conf && \
  echo "listen_addresses='*'" >> /etc/postgresql/${PG_VERSION}/main/postgresql.conf
 
COPY start.sh start.sh
 
EXPOSE 5432
RUN rm /usr/sbin/policy-rc.d
CMD ["/start.sh"]