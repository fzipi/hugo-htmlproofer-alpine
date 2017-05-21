FROM ruby:2.4-alpine
MAINTAINER Felipe Zipitria <fzipi@fing.edu.uy>

RUN echo 'gem: --no-document' >> /etc/gemrc

RUN apk add --no-cache --virtual build-dependencies \
  build-base \
  libcurl \
  libxml2-dev \
  libxslt-dev \
  && gem install nokogiri -- --use-system-libraries \
  && gem install html-proofer --no-ri --no-rdoc \
  && apk del build-dependencies \
  && apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
  hugo \
  && apk add --no-cache \
  bash \
  libcurl \
  libxml2 \
  libxslt \
  py-pygments \
  && rm -rf /var/cache/apk/*

EXPOSE 1313

# now you can run hugo and htmlproofer afterwards!
