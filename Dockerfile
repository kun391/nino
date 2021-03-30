# As such, a valid Dockerfile must have FROM as its first instruction.
FROM nginx:1.15.12

# The MAINTAINER instruction allows you to set the Author field of the generated images.
MAINTAINER KUN <nguyentruongthanh.dn@gmail.com>

USER root

RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        gcc \
        g++ \
        make \
        git \
        libssl-dev \
        python \
        rsync \
        software-properties-common \
        devscripts \
        autoconf \
        ssl-cert \
    && apt-get clean

# install node 10
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

RUN npm i -g yarn

ADD conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443

CMD ["nginx", "start"]