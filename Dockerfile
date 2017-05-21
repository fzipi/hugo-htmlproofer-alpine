FROM ruby:2.4-alpine
MAINTAINER Felipe Zipitria <fzipi@fing.edu.uy>

RUN echo 'gem: --no-document' >> /etc/gemrc

RUN apk add --no-cache --virtual build-dependencies \
  bash \
  build-base \
  libxml2-dev \
  libxslt-dev \
  py-pygments \
  && rm -rf /var/cache/apk/*

RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
  hugo \
  && rm -rf /var/cache/apk/*

RUN gem install nokogiri -- --use-system-libraries \
  && gem install html-proofer --no-ri --no-rdoc

EXPOSE 1313

# now you can run hugo and htmlproofer!
