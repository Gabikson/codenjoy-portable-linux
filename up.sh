#!/usr/bin/env bash

if [ "x$CONFIG" = "x" ]; then
    . config.sh ;
fi

eval_echo() {
    to_run=$1
    echo "[94m"
    echo $to_run
    echo "[0m"

    eval $to_run
}

eval_echo "docker-compose down"

if [ "x$OPEN_PORTS" = "xtrue" ]; then
    echo "[93mWARNING: All applications ports are exposed out of containers[0m"
    open="-f open-ports.yml"
fi

if [ "x$PGADMIN" = "xtrue" ]; then
    echo "[93mWARNING: PGAdmin will start on port $PGADMIN_PORT[0m"
    pgadmin="-f pgadmin.yml"
fi

eval_echo "docker-compose -f docker-compose.yml $open $pgadmin up -d codenjoy_db"
sleep 10
eval_echo "docker-compose -f docker-compose.yml $open $pgadmin up -d"

