FROM ruby:3.2.0-alpine

RUN apk add --no-cache \
    nodejs \
    npm \
    sqlite-dev \
    openssl-dev \
    alpine-sdk \
    tzdata \
    libc6-compat \
    libsodium \
    vips

RUN gem install bundler
RUN bundle config --global frozen 1

WORKDIR /app
COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . .
RUN rails assets:precompile

EXPOSE 3000
CMD [ "./entrypoint.sh" ]
