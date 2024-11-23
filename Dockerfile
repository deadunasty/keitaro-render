FROM centos:7

RUN yum update -y && yum install -y \
    curl \
    bash \
    gnupg2 \
    ca-certificates \
    && yum clean all

WORKDIR /opt/keitaro

RUN mkdir -p /opt/keitaro/log /var/log/keitaro

RUN curl keitaro.io/kctl.sh | bash -s -- install

EXPOSE 80 443

CMD ["bash", "-c", "/opt/keitaro/kctl start"]
