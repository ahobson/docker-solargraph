FROM ruby:2.4.3-slim-stretch
ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN set -x \
  && apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
  && gem install \
     --no-ri --no-doc \
     solargraph \
  && DEBIAN_FRONTEND=noninteractive apt-get purge -y \
    build-essential \
  && DEBIAN_FRONTEND=noninteractive apt-get autoremove -y \
  && DEBIAN_FRONTEND=noninteractive apt-get clean -y

ENTRYPOINT [ "solargraph" ]
CMD [ "socket", "--host", "0.0.0.0" ]
