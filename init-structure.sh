JETTY_UID=999

# for nginx
rm ./config/nginx/.htpasswd
touch ./config/nginx/.htpasswd
sudo sh -c "echo -n 'codenjoy:' >> ./config/nginx/.htpasswd"
sudo sh -c "openssl passwd -apr1 3141592 >> ./config/nginx/.htpasswd"
cat ./config/nginx/.htpasswd

chown root:root ./cert/*
chown root:root ./config/nginx/*

# for postgres codenjoy_db
mkdir -p ./content/database
chown root:root ./content/database

# for sqlite
#L# mkdir -p ./content/codenjoy/database
#L# chown $JETTY_UID:$JETTY_UID ./content/codenjoy/database

# for codenjoy_balancer / codenjoy_contest
mkdir -p ./config/codenjoy
chown $JETTY_UID:$JETTY_UID ./config/codenjoy

mkdir -p ./logs/codenjoy
touch ./logs/codenjoy/codenjoy-balancer.log
touch ./logs/codenjoy/codenjoy-contest.log
chown $JETTY_UID:$JETTY_UID ./logs/codenjoy/codenjoy-balancer.log
chown $JETTY_UID:$JETTY_UID ./logs/codenjoy/codenjoy-contest.log

