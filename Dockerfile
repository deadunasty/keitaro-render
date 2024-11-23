# Используем официальный образ CentOS Stream 9 в качестве базового
FROM centos:stream9

# Устанавливаем EPEL репозиторий и необходимые зависимости
RUN dnf -y install epel-release \
    && dnf -y update \
    && dnf install -y \
        curl \
        bash \
        gnupg2 \
        ca-certificates \
        jq \
        gettext \
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
