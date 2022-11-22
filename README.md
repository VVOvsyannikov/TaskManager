[![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2FVVOvsyannikov%2FTaskManager%2Fbadge%3Fref%3Ddevelop&style=flat)](https://actions-badge.atrox.dev/VVOvsyannikov/TaskManager/goto?ref=develop) [![Coverage Status](https://coveralls.io/repos/github/VVOvsyannikov/TaskManager/badge.svg?branch=develop)](https://coveralls.io/github/VVOvsyannikov/TaskManager?branch=develop)

# Канбан-доска
### Учебный проект

Здесь можно создавать таски, поручать их членам команды и перемещать их между колонками в соответствии с жизненным циклом проекта:
- новая
- в разработке
- код-ревью
- тестирование
- подготовка к релизу
- релиз
- архив

## Роли пользователей
### Admin, Manager, Developer

В демонстрационных целях авторизация присутствует только для роли Admin (скрытая админка).

Cоздавать и редактировать задачи могут все пльзователи.

### Приложение доступно по ссылке: https://board.ovsyannikov.dev/

Можно создать нового пользователя (менеджер, девелопер), либо зайти под админом.

Логин: admin@mail.ru

Пароль: admin

## Установка и запуск на локальной машине

Клонируем репозиторий

Запускаем докер-контейнер и баш-сессию

    docker-compose run --rm --service-ports web /bin/bash

Устанавливаем гемы

    bundle install

Запускаем локальный сервер

    rails server

Открываем в браузере

    localhost:8080

  
