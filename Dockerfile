# Используем официальный образ CentOS в качестве базового
FROM centos:7

# Устанавливаем необходимые зависимости
RUN yum update -y && yum install -y \
    curl \
    bash \
    gnupg2 \
    ca-certificates \
    && yum clean all

# Создаём рабочую директорию
WORKDIR /opt/keitaro

# Создаём необходимые директории для Keitaro
RUN mkdir -p /opt/keitaro/log /var/log/keitaro

# Загружаем и устанавливаем Keitaro
RUN curl keitaro.io/kctl.sh | bash -s -- install

# Открываем необходимые порты (например, 80 и 443)
EXPOSE 80 443

# Устанавливаем команду запуска Keitaro
CMD ["bash", "-c", "/opt/keitaro/kctl start"]
