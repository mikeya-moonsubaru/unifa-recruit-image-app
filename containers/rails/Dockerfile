FROM ruby:3.4.7-slim

RUN apt-get update -qq
ENV RUNTIME_PACKAGES="\
      build-essential\
      libpq-dev\
      nodejs\
      make\
      gcc\
      libc-dev\
      libmariadb-dev-compat\
      libmariadb-dev\
      git\
      curl\
      vim\
      libyaml-dev\
    "

RUN apt-get install -y ${RUNTIME_PACKAGES}

RUN mkdir /myapp
ENV APP_ROOT /myapp
WORKDIR $APP_ROOT

ADD ./image-app/Gemfile $APP_ROOT/Gemfile
ADD ./image-app/Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install

ADD ./image-app/ $APP_ROOT
