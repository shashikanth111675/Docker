# Docker image to use.
FROM sloopstash/base:v1.1.1

# Add system user for kibana
RUN useradd -m kibana

# Install Kibana
WORKDIR /tmp
RUN set -x \
  && curl -O https://artifacts.elastic.co/downloads/kibana/kibana-8.16.0-linux-x86_64.tar.gz \
  && curl -O https://artifacts.elastic.co/downloads/kibana/kibana-8.16.0-linux-x86_64.tar.gz.sha512 \
  && sha512sum -c kibana-8.16.0-linux-x86_64.tar.gz.sha512 \
  && tar xvzf kibana-8.16.0-linux-x86_64.tar.gz > /dev/null \
  && mv kibana-8.16.0 /usr/local/bin/ \
  && rm kibana-8.16.0-linux-x86_64.tar.gz

# set env for kibana
ENV PATH=$PATH:/usr/local/bin/kibana-8.16.0/bin

# Create Kibana directories.
RUN set -x \
  && mkdir /opt/kibana \
  && mkdir /opt/kibana/data \
  && mkdir /opt/kibana/log \
  && mkdir /opt/kibana/conf \
  && mkdir /opt/kibana/script \
  && mkdir /opt/kibana/system \
  && touch /opt/kibana/system/server.pid \
  && touch /opt/kibana/system/supervisor.ini \
  && ln -s /opt/kibana/system/supervisor.ini /etc/supervisord.d/kibana.ini \
  && history -c

# Set the working directory
WORKDIR /opt/kibana