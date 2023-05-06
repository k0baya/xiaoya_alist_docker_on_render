FROM xiaoyaliu/alist:latest

WORKDIR /

RUN mkdir -p data

ADD data/ /data
