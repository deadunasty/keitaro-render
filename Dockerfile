# Используем официальный образ CentOS 9 Stream в качестве базового
FROM centos:9-stream

# Обновляем систему и устанавливаем необходимые зависимости
RUN dnf -y update && dnf install -y \
    curl \
    bash \
    gnupg2 \
    ca-certificates \
    epel-release \
    gettext \
    jq \
    && dnf clean all

# Создаём рабочую директорию для Keitaro
WORKDIR /opt/keitaro

# Создаём необходимые директории для логов
RUN mkdir -p /opt/keitaro/log /var/log/keitaro

# Загружаем и устанавливаем Keitaro
RUN curl keitaro.io/kctl.sh | bash -s -- install

# Открываем необходимые порты (80 и 443)
EXPOSE 80 443

# Устанавливаем команду запуска Keitaro
CMD ["bash", "-c", "/opt/keitaro/kctl start"]
