FROM ruby:2.7.1-alpine

ARG RAILS_ROOT=/task_manager
ARG PACKAGES="nano openssl-dev postgresql-dev build-base curl nodejs yarn less tzdata git postgresql-client bash screen gcompat"

ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true

RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $PACKAGES

RUN gem install bundler:2.1.4

RUN mkdir $RAILS_ROOT
WORKDIR $RAILS_ROOT
COPY Gemfile Gemfile.lock  ./
RUN bundle install --without development test

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . $RAILS_ROOT
ENV PATH=$RAILS_ROOT/bin:${PATH}

RUN RAILS_ENV=production bin/rails assets:precompile

ENTRYPOINT ["/task_manager/bin/docker-entrypoint.sh"]

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]