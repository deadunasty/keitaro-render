# Используем официальный образ Rocky Linux 9 в качестве базового
FROM rockylinux:9

ENV container docker

# Устанавливаем необходимые пакеты и systemd
RUN dnf -y install epel-release \
    && dnf -y update \
    && dnf install -y --allowerasing \
        curl \
        bash \
        gnupg2 \
        ca-certificates \
        jq \
        gettext \
        procps-ng \
        systemd \
    && dnf clean all

# Создаём файл /etc/centos-release для распознавания ОС Keitaro
RUN echo "CentOS Stream release 9" > /etc/centos-release

# Настройка systemd
STOPSIGNAL SIGRTMIN+3
VOLUME [ "/sys/fs/cgroup" ]

# Создаём рабочую директорию для Keitaro
WORKDIR /opt/keitaro

# Создаём необходимые директории для логов
RUN mkdir -p /opt/keitaro/log /var/log/keitaro

# Загружаем и устанавливаем Keitaro
RUN curl keitaro.io/kctl.sh | bash -s -- install

# Открываем необходимые порты (80 и 443)
EXPOSE 80 443

# Запуск systemd
CMD ["/usr/lib/systemd/systemd"]
