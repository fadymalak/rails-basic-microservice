FROM  ruby:3.1.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get -y install mariadb-client
ENV INSTABUG /app 
RUN mkdir $INSTABUG
WORKDIR $INSTABUG
ENV BUNDLE_PATH /gems
ENV REDIS_URL redis://redis:6379/1
ENV REDIS_HOST redis://redis:6379/0
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install
COPY . ./
