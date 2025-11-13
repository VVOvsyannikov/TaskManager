#!/bin/sh
set -e

APP_PATH=/task_manager

# Проверка и установка гемов
bundle check || bundle install

# Удаление server.pid для безошибочного запуска Puma/Rails
if [ -f "$APP_PATH/tmp/pids/server.pid" ]; then
  rm "$APP_PATH/tmp/pids/server.pid"
fi

# Автоматическая подготовка базы для Rails
if echo "$@" | grep -q "rails server"; then
  echo "Preparing database..."
  bundle exec rails db:prepare db:seed
fi

# Выполнение переданной команды
exec "$@"