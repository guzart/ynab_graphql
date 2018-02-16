FROM ruby:2.5-alpine

ENV RAILS_ENV=production

RUN mkdir /var/ynab_graphql
WORKDIR /var/ynab_graphql

RUN apk --update add \
      build-base libxml2-dev patch ruby-dev zlib-dev xz-dev tzdata

COPY Gemfile Gemfile.lock /var/ynab_graphql/
RUN gem install bundler --no-ri --no-rdoc \
    && bundle install --without development test

COPY . /var/ynab_graphql

CMD ["bundle", "exec", "rails", "s"]
