FROM ruby:2.4-alpine
LABEL maintainer "Felipe Zipitria <fzipi@fing.edu.uy>"

RUN echo 'gem: --no-document' >> /etc/gemrc

RUN mkdir -p /home/hugo && \
  addgroup -Sg 1000 hugo && \
  adduser -SG hugo -u 1000 -h /home/hugo hugo && \
  chown hugo:hugo /home/hugo && \
  apk add --no-cache --virtual build-dependencies \
  build-base \
  libcurl \
  libxml2-dev \
  libxslt-dev && \
  gem install nokogiri -- --use-system-libraries && \
  gem install html-proofer --no-ri --no-rdoc && \
  apk del build-dependencies && \
  apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
  hugo && \
  apk add --no-cache \
  bash \
  git \
  libcurl \
  libxml2 \
  libxslt \
  py-pygments && \
  rm -rf /var/cache/apk/* && \
  mkdir -p /srv/hugo && \
  chown hugo:hugo /srv/hugo && \
  echo 'hugo ALL=NOPASSWD:ALL' >> /etc/sudoers && \
  rm -rf /usr/lib/ruby/gems/*/cache/*.gem

WORKDIR /srv/hugo

EXPOSE 1313

CMD ["hugo",  "version"]

# now you can run hugo and htmlproofer afterwards!
