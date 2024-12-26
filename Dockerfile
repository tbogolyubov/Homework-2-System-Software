# Используем официальный образ Caddy
FROM caddy:2

# Копируем Caddyfile в контейнер
COPY Caddyfile /etc/caddy/Caddyfile

# Указываем рабочую директорию
WORKDIR /srv

# Копируем статические файлы в контейнер
COPY . .

# Открываем порты 80 и 443
EXPOSE 443 443

# Запускаем Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
