# Используем официальный образ Ubuntu в качестве базового
FROM ubuntu:20.04

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    gnupg2 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Создаём рабочую директорию
WORKDIR /opt/keitaro

# Создаём необходимые директории для Keitaro
RUN mkdir -p /opt/keitaro/log

# Загружаем и устанавливаем Keitaro
RUN curl keitaro.io/kctl.sh | bash -s -- install

# Открываем необходимые порты (например, 80 и 443)
EXPOSE 80 443

# Устанавливаем команду запуска Keitaro
CMD ["bash", "-c", "/opt/keitaro/kctl start"]
