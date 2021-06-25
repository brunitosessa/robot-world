FROM ruby:2.7.3-alpine3.13

RUN apk add --update build-base nodejs tzdata postgresql-dev postgresql-client libxslt-dev libxml2-dev

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundle
RUN bundle install

COPY . .
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]



