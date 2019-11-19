FROM elixir:1.9.0-alpine as build

# install build dependencies
RUN apk add --update git build-base nodejs npm python

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ARG HOST
ARG PORT
ARG MIX_ENV
ARG DATABASE_URL
ARG SECRET_KEY_BASE
ARG SMTP_USERNAME
ARG SMTP_PASSWORD

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only prod
RUN mix deps.compile

# build assets
COPY assets assets
RUN cd assets && npm install && npm run deploy
RUN mix phx.digest

# build project
COPY priv priv
COPY lib lib
RUN mix compile

# build release
# COPY rel rel
RUN mix release

# prepare release image
# FROM alpine:3.9 AS app
FROM elixir:1.9.0-alpine as app
RUN apk add --update bash openssl

RUN mkdir /app
WORKDIR /app

COPY --from=build /app/_build/prod/rel/app ./
RUN chown -R nobody: /app
USER nobody

ENV HOME=/app

RUN ls -A

CMD ["/app/bin/app", "start"]
