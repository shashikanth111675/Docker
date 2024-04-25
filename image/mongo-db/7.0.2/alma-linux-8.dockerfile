# Docker image to use.
FROM sloopstash/base-alma-linux-8:v1.1.1

# Switch work directory.
WORKDIR /tmp

# Download, extract, and install MongoDB.
COPY ["mongodb-org-server-7.0.2-1.el7.x86_64.rpm", "mongodb-org-mongos-7.0.2-1.el7.x86_64.rpm", "./"]
RUN set -x \
  && dnf install -y mongodb-org-server-7.0.2-1.el7.x86_64.rpm --quiet \
  && dnf install -y mongodb-org-mongos-7.0.2-1.el7.x86_64.rpm --quiet \
  && rm -rf mongodb-org*

# Create MongoDB directories.
RUN set -x \
  && mkdir /opt/mongo-db \
  && mkdir /opt/mongo-db/data \
  && mkdir /opt/mongo-db/log \
  && mkdir /opt/mongo-db/conf \
  && history -c

# Set default work directory.
WORKDIR /opt/mongo-db
