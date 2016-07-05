#!/usr/bin/env bash
#===============================================================================
CONF="/etc/postgresql/${PG_VERSION}/main/postgresql.conf"
POSTGRES="/usr/lib/postgresql/${PG_VERSION}/bin/postgres"
#-------------------------------------------------------------------------------
chown -R postgres /var/lib/postgresql
mkdir -p "${PGRUN}/${PG_VERSION}-main.pg_stat_tmp"
chown -R postgres $PGRUN
su postgres -c "/usr/lib/postgresql/${PG_VERSION}/bin/initdb"
 
echo "Creating superuser: ${USER}"
su postgres -c "${POSTGRES} --single -D ${PGDATA} -c config_file=${CONF}" <<EOF
CREATE USER $USER WITH SUPERUSER PASSWORD '$PASS';
EOF
#-------------------------------------------------------------------------------
exec su postgres -c "${POSTGRES} -D ${PGDATA} -c config_file=${CONF}"
#===============================================================================