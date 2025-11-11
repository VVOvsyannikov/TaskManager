#!/bin/sh -e

## Проверка и установка гемов
bundle check || bundle install

# Удаление server.pid-файла для безошибочного запуска сервера Puma
if [ -f "$APP_PATH/tmp/pids/server.pid" ]; then
  rm "$APP_PATH/tmp/pids/server.pid"
fi

# If running the rails server then create or migrate existing database
if [ "${@: -2:1}" == "./bin/rails" ] && [ "${@: -1:1}" == "server" ]; then
  ./bin/rails db:prepare
fi

# Выполнение переданных команд в скрипт
exec "${@}"
