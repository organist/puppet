#! /bin/bash
cd /home/deploy
git clone https://github.com/organist/organist.git
cd organist
git checkout develop
ln -s /home/deploy/organist/app/config/parameters.P.yml /home/deploy/organist/app/config/parameters.yml
mkdir app/cache app/logs
setfacl -R -m u:nginx:rwX -m u:deploy:rwX app/cache app/logs
setfacl -dR -m u:nginx:rwX -m u:deploy:rwX app/cache app/logs
