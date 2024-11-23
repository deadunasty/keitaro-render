# Используем официальный образ CentOS 7 в качестве базового
FROM centos:7

# Обновляем конфигурацию репозиториев, чтобы использовать Vault
RUN sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-Base.repo \
    && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo

# Устанавливаем EPEL репозиторий для доступа к дополнительным пакетам
RUN yum install -y epel-release

# Устанавливаем необходимые зависимости, включая jq из EPEL
RUN yum update -y && yum install -y \
    curl \
    bash \
    gnupg2 \
    ca-certificates \
    jq \
    && yum clean all

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
