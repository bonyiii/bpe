# original idea taken from
# https://github.com/docker-library/redmine/blob/d564a3b0d78016b2f24af2d74bcdace26a1ac0a3/3.1/Dockerfile
FROM ruby:2.3

MAINTAINER Bonaventura Fleischmann <bonaventura.fleischmann@digitalnatives.hu>

# Set default locale
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# install nodejs for execjs
RUN set -x \
        && curl -sL https://deb.nodesource.com/setup_7.x | bash -

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    openjdk-7-jre \
    unzip \
    imagemagick \
    nodejs \
    libmysqlclient18 \
    libsqlite3-0 \
    mysql-client \
    postgresql-client-9.4 \
    git \
    openssh-client \
  && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN set -x \
  && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
  && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
  && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu \
  && gosu nobody true

# grab tini for signal processing and zombie killing
ENV TINI_VERSION v0.9.0
RUN set -x \
  && wget -O /usr/local/bin/tini "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini" \
  && wget -O /usr/local/bin/tini.asc "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini.asc" \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 6380DC428747F6C393FEACA59A84159D7001A4E5 \
  && gpg --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini \
  && rm -r "$GNUPGHOME" /usr/local/bin/tini.asc \
  && chmod +x /usr/local/bin/tini \
  && tini -h

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# Add a user, apps will run as this user,
# hopefully the uid will match the host machine user
# so that no file permission problem occur.
RUN useradd -ms /bin/bash -u 1000 dev

USER dev

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.2.0 \
    && echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc \
    && echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc \
    && PATH=$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH >> ~/.bashrc \
    && asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git \
    && asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

USER root
