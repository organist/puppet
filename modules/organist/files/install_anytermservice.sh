#! /bin/bash
cd /home/deploy/organist
sudo app/console publish:anyterm install
sudo service anyterm start
