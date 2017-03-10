FROM bpe_base

ARG APP_DIR=/var/www/bpe

# Install phantomjs
COPY dockers/api/phantomjs-2.1.1-linux-x86_64.tar.bz2 /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar -xjf /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /home/dev/ \
    && cp /home/dev/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /home/dev/bin \
    && rm /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2

# Add phantomjs executable path
RUN echo 'PATH=/home/dev/bin:$PATH' >> /home/dev/.bashrc \
    && echo 'alias ll="ls -l"' >> /home/dev/.bashrc \
    && mkdir -p $APP_DIR \
    && chown dev $APP_DIR \
    && chown dev:dev /home/dev/bin -R

WORKDIR $APP_DIR

COPY . $APP_DIR/
COPY docker-entrypoint.sh /

# Add all files to user under which app is runing
RUN bundle install \
    && chown dev:dev $APP_DIR -R

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
