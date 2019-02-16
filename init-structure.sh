#!/usr/bin/env bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "[92m========================================================================================================================"
echo "==================================================== Init structure ===================================================="
echo "========================================================================================================================[0m"

if [ "x$BASIC_AUTH_LOGIN" = "x" ]; then
    BASIC_AUTH_LOGIN=codenjoy
fi

if [ "x$BASIC_AUTH_PASSWORD" = "x" ]; then
    BASIC_AUTH_PASSWORD=codenjoy
fi

eval_echo() {
    to_run=$1
    echo "[94m"
    echo $to_run
    echo "[0m"

    eval $to_run
}

JETTY_UID=999

# for nginx
generate_htpasswd() {
    rm ./config/nginx/.htpasswd
    touch ./config/nginx/.htpasswd
    sudo sh -c "echo -n '$BASIC_AUTH_LOGIN:' >> ./config/nginx/.htpasswd"
    sudo sh -c "openssl passwd -apr1 $BASIC_AUTH_PASSWORD >> ./config/nginx/.htpasswd"
    cat ./config/nginx/.htpasswd
}
eval_echo "generate_htpasswd"

eval_echo "chown root:root ./cert/*"
ls -la ./cert

eval_echo "chown root:root ./config/nginx/*"
ls -la ./config/nginx

# for postgres codenjoy_db
eval_echo "mkdir -p ./materials/database"
eval_echo "chown root:root ./materials/database"
# for sqlite
#L# eval_echo "chown $JETTY_UID:$JETTY_UID ./materials/database"
ls -la ./materials/database

# for codenjoy_balancer / codenjoy_contest
eval_echo "mkdir -p ./config/codenjoy"
eval_echo "chown $JETTY_UID:$JETTY_UID ./config/codenjoy"
ls -la ./config/codenjoy

eval_echo "mkdir -p ./logs/codenjoy"
eval_echo "touch ./logs/codenjoy/codenjoy-balancer.log"
eval_echo "touch ./logs/codenjoy/codenjoy-contest.log"
eval_echo "chown $JETTY_UID:$JETTY_UID ./logs/codenjoy/codenjoy-balancer.log"
eval_echo "chown $JETTY_UID:$JETTY_UID ./logs/codenjoy/codenjoy-contest.log"
ls -la ./logs/codenjoy
