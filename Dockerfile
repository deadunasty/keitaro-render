# Используем официальный образ CentOS Stream 9 в качестве базового
FROM centos:stream9

# Обновляем конфигурацию репозиториев, чтобы использовать Vault (если необходимо)
# Для CentOS Stream 9 это обычно не требуется, но оставим настройки репозиториев на всякий случай
# RUN sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-Base.repo \
#     && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo

# Устанавливаем EPEL репозиторий для доступа к дополнительным пакетам
RUN dnf install -y epel-release

# Устанавливаем необходимые зависимости, включая jq и gettext
RUN dnf -y update && dnf install -y \
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
