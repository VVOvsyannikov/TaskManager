## README

# Канбан-доска для команды разработчиков
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

### Приложение доступно по ссылке: https://ovsyannikov.dev/board

Можно создать нового пользователя (менеджер, девелопер), либо зайти под админом.

Логин: admin@mail.ru

Пароль: admin


## Стек:

ruby '2.7.1'

rails '>= 6.1.4.4'


## Дополнительные зависимости для деплоя:

Yarn

./bin/yarn add webpacker-react

yarn add @asseinfo/react-kanban

yarn add @material-ui/core @material-ui/icons

yarn add humps

yarn add axios

yarn add qs

yarn add ramda

yarn add prop-types

yarn add react-select
