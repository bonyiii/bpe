FROM rails-base

ARG APP_DIR=/var/www/bpe

RUN apt-key adv --fetch-keys http://dl.yarnpkg.com/debian/pubkey.gpg \
     && echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
     && apt-get update && apt-get install -y --no-install-recommends \
             yarn \
             build-essential \
     && npm install -g webpack 

WORKDIR $APP_DIR

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

#EXPOSE 3000
CMD ["npm", "start"]
