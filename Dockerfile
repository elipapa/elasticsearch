#
# Elasticsearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM java:8-jre

ENV ES_PKG_NAME elasticsearch-1.4.4

# Install Elasticsearch.
RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch
  
# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

#install required plugins
RUN  /elasticsearch/bin/plugin --install elasticsearch/elasticsearch-lang-python/2.4.1 --timeout 5m
RUN  /elasticsearch/bin/plugin --install karmi/elasticsearch-paramedic --timeout 5m
RUN  /elasticsearch/bin/plugin --install royrusso/elasticsearch-HQ --timeout 5m
RUN  /elasticsearch/bin/plugin --install elasticsearch/elasticsearch-cloud-aws/2.7.1 --timeout 5m


# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
