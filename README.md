# Домашняя работа №2, Боголюбов Т.С., Фт-320008

## Создание Docker контейнера с веб-сервером Caddy

Работа выполняется в Windows Subsystem for Linux. 
В скопированном репозитории сервера Caddy создадим Dockerfile, в котором определим, как будет собираться наш Docker-образ. Содержимое файла:
```
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
```

Далее, в той же директории, создадим Caddyfile с конфигурацией Caddy сервера:
```
{
    # Глобальные настройки
    email tbogolyubovv@ya.ru
}

localhost {
    root * /srv
    file_server
    tls internal
    redir https://{host}{uri}
}
```

Далее переходим в WSL в нашу директорию /home/tbogolyubov/caddy и собираем Docker образ командой docker build -t caddy-server .
![{D7314457-CC0C-46EF-84E2-C05FA1EE9463}](https://github.com/user-attachments/assets/fa0d970c-a6cf-4ac0-b543-3f574343e057)

Теперь запустим контейнер командой docker run -d -p 80:80 -p 443:443 --name my-caddy-container caddy-server
![{39FBCEDA-D57E-41F6-83C2-850087BF3238}](https://github.com/user-attachments/assets/546863dc-06e9-45ed-b5cd-df886752a767)

Убедимся, что контейнер запущен успешно:
![{AD36D1D3-336E-406E-8FCB-F90CD6484A93}](https://github.com/user-attachments/assets/2a48a709-eaf5-4f2a-92e1-75d40d09194c)

Запустим Caddy сервер. Для этого введем команду docker exec -it my-caddy-container /bin/sh, а затем команду caddy run
![{A4BFD754-FB1A-459F-82F8-38D7CA891459}](https://github.com/user-attachments/assets/391d1b25-a9ee-405f-a2cc-c4bb0245f9ad)

Видим, что сервер работает успешно
