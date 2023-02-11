FROM elixir:1.14-alpine AS build

ENV APP_NAME=exchange_rate_api

ENV MIX_ENV=prod

WORKDIR /app

# get deps first so we have a cache
ADD mix.exs mix.lock /app/
RUN \
	cd /app && \
	mix local.hex --force && \
	mix local.rebar --force && \
	mix deps.get

# then make a release build
ADD . /app/
RUN \
	mix compile && \
	mix release

FROM elixir:1.14-alpine

COPY --from=build /app/_build/prod/rel/$APP_NAME /opt/$APP_NAME

EXPOSE 4000

CMD [ "/opt/$APP_NAME/bin/$APP_NAME", "start" ]