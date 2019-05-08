FROM ruby:2.5.1-slim-stretch
ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN set -x \
  && gem install \
        --no-ri --no-doc \
        --default \
        bundler:2.0.1 \
  && bundler config default 2.0.1

ENV BUNDLER_VERSION 2.0.1
ENV LANG en_US.UTF-8
RUN set -x \
  && apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential git-core locales \
  && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
  && dpkg-reconfigure --frontend=noninteractive locales \
  && update-locale LANG=$LANG \
  && gem install \
        --no-ri --no-doc \
        solargraph:0.32.2 \
  && DEBIAN_FRONTEND=noninteractive apt-get purge -y \
    build-essential \
  && DEBIAN_FRONTEND=noninteractive apt-get autoremove -y \
  && DEBIAN_FRONTEND=noninteractive apt-get clean -y

ENTRYPOINT [ "solargraph" ]
CMD [ "socket", "--host", "0.0.0.0" ]
