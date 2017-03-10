FROM rails-base

ARG APP_DIR=/var/www/bpe

# Install Chrome
#ADD https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb /src/google-talkplugin_current_amd64.deb
COPY google-talkplugin_current_amd64.deb /src/google-talkplugin_current_amd64.deb
RUN apt-get update && apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  hicolor-icon-theme \
  libgl1-mesa-dri \
  libgl1-mesa-glx \
  libpulse0 \
  libv4l-0 \
  --no-install-recommends \
  && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
  && apt-get update && apt-get install -y \
  google-chrome-stable \
  --no-install-recommends \
  && dpkg -i '/src/google-talkplugin_current_amd64.deb' \
  && apt-get purge --auto-remove -y curl \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /src/*.deb

# Install chromedriver for capybara
RUN wget https://chromedriver.storage.googleapis.com/2.27/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip -d /home/dev/bin \
    && rm chromedriver_linux64.zip

# Install phantomjs
#RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
#    && tar -xjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /home/dev/ \
#    && cp /home/dev/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /home/dev/bin \
#    && rm phantomjs-2.1.1-linux-x86_64.tar.bz2
COPY phantomjs-2.1.1-linux-x86_64.tar.bz2 /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar -xjf /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /home/dev/ \
    && cp /home/dev/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /home/dev/bin \
    && rm /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2

# Add phantomjs and chromedriver executable path
RUN echo 'PATH=/home/dev/bin:$PATH' >> /home/dev/.bashrc \
    && echo 'alias ll="ls -l"' >> /home/dev/.bashrc \
    && mkdir -p $APP_DIR \
    && chown dev $APP_DIR \
    && chown dev:dev /home/dev/bin -R
    
WORKDIR $APP_DIR

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
