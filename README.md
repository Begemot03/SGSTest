# Описание первой части задания (Папка task1/)

## Файлы

**create_tables.sql** - создает базу данных SGSTest, две таблицы (контрейнеры и опреации)

**insert_containers_values.sql** - заполняет таблицу контейнеров фейк данными на 1000 строк

**insert_operation_values.sql** - заполняет таблицу операций фейк данными на 1000 строк (запускать скрипт только после заполнения информации и контейнерах из-за зависимостей!)

**select_operation_for_container_data_as_json.sql** - скрипт для получения операций контейнера под id=1, результат конветрируется в JSON хранится в столбце JSONRESULT

**select_containers_data_as_json.sql** - скрипт дял получения информации о всех контейнерах, результат конветрируется в JSON хранится в столбце JSONRESULT

# Описание второй части задания (Папки task2_html-js/ и task2_vue)

## Файлы (Папка task2_html-js)

**index.js** - добавляет option к первым трем полям формы, а также хранит информацию в 2-х массивах *cityWorkshop* и *workshopEmployee*, 
в дальнейшем эти массивы преобразуются в один большой массив с помощью функции *crossJoin(arr1, arr2)*

Описание работы функции
```
crossJoin(arr1, arr2)

input: 

arr1 [
    { name: 1, dependences: [1-1, 1-2] }
]

arr2 [
    { name: 1-1, dependences: [1-1-1, 1-1-2] },
    { name: 1-2, dependences: [1-2-1, 1-2-2] },
]

output:

resultArr [
    [ 1, 1-1, 1-1-1 ],
    [ 1, 1-1, 1-1-2 ],
    [ 1, 1-2, 1-2-1 ],
    [ 1, 1-2, 1-2-2 ]
]

```

Функция помогает получить все возможные значения в select-ах

```
input: city="", workshop="", employee="1-1-1"

Пробегаемся по всему массиму след образом resultArr[0] === city, resultArr[1] === workshop, resultArr[2] === employee

Так же если проверяемое значение пустое, то подходит любая строка в resultArr, для этого есть функция isEqualOrEmpty(str, value): boolean

```

**index.html \ styles.css** - разметка и стилилизация страницы