FROM msaraiva/elixir:1.2.4
MAINTAINER Eoin Shanaghy <eoin@codespyre.com>

# See the following link for available Alpine Linux erlang packages
# https://pkgs.alpinelinux.org/packages?name=erlang*
RUN apk --update add \
  erlang-dev \
  erlang-syntax-tools \
  erlang-erl-interface \
  erlang-crypto \
  erlang-sasl \
  erlang-inets \
  erlang-ssl \
  erlang-public-key \
  erlang-asn1 \
  && rm -rf /var/cache/apk/*

RUN mix local.hex --force
RUN mix local.rebar --force

RUN mkdir -p /src
WORKDIR /src
COPY . /src

ENV MIX_ENV=prod
RUN mix do deps.get, compile, phoenix.digest, release

CMD ["./rel/chat/bin/chat", "foreground"]
