# use the .env luke
#docker run -it --name sapi -p 3000:3000 -v /home/boni/public_html/synlab/synlab-api/gems:/usr/local/bundle -v /home/boni/public_html/synlab/synlab-api:/var/www/synlab-api --link synlab-mysql:mysql --link synlab-ldap:ldap -e RAILS_ENV=development -e LDAP_PORT=1389 --add-host=redis:172.17.0.1 synlab-api

# google-chrome supporting version
docker run -it \
       --name sapi \
       -p 3000:3000 \
       --security-opt seccomp:chrome.seccomp.json \
       -e DISPLAY=unix$DISPLAY \
       -v /home/boni/public_html/synlab/synlab-api/gems:/usr/local/bundle \
       -v /home/boni/public_html/synlab/synlab-api:/var/www/synlab-api \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $HOME/Downloads:/home/dev/Downloads \
       -v $HOME/.config/google-chrome/:/home/dev/data \
       -v /dev/snd:/dev/snd --privileged \
       -v /dev/shm:/dev/shm \
       --group-add audio \
       --group-add video \
       --link synlab-mysql:mysql \
       --link synlab-ldap:ldap \
       -e RAILS_ENV=development \
       -e LDAP_PORT=1389 \
       --add-host=redis:172.17.0.1 synlab-api 

#docker run -it --net host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v $HOME/.config/google-chrome/:/data --device /dev/snd -v /dev/shm:/dev/shm --name chrome jess/chrome
