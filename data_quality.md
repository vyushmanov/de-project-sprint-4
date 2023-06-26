# 1.3. Качество данных

## Оценка качества данные в источнике.

Таблица `users` не содержит пропусков и задвоений, общее количество уникальных клиентов - 1000

Таблица `orders` не содержит пропусков и задвоений в поле orders_id, общее количество - 10000; количество уникальных клиентов соответствует таблице `users`; пропусков и нулевых сумм в полях payment, costs не выявлено

Таблица `products` не содержит пропусков и задвоений, общее количество продуктов - 21

Таблица `orderitems` общее количество строк 47369, пропусков и задвоений не выявлено, количество заказов - 10000, количество уникальных продуктов - 21.

Таблица `orderstatuses` содержит 5 униальных значений

Проверка выполнена с использованием кода:

```SQL
SELECT count(*)
	,count(distinct login)
FROM production.users u;
SELECT Count(order_id) all_count
	,count(distinct order_id) order_count
	,count(distinct user_id) user_count
	,count(case when payment > 0 THEN 1 END) payed_order_count
	,count(case when "cost" > 0 THEN 1 END) cost_order_count
FROM production.orders o;
SELECT count(id)
	,count(distinct name)
	,count(case when price > 0 THEN 1 END) full_prices_count
FROM production.products p;
SELECT count(*)
	,count(distinct order_id) unique_order
	,count(distinct product_id) unique_products
	,count(case when price > 0 then 1 end) prise_exists
	,count(case when discount > 0 then 1 end) discount_exists
	,count(case when quantity > 0 then 1 end) quantity_exists
FROM production.orderitems o;
SELECT *
FROM production.orderstatuses o;
```


## Инструменты обеспечения качество данных в источнике.

| Таблицы             | Объект                      | Инструмент      | Для чего используется |
| ------------------- | --------------------------- | --------------- | --------------------- |
| production.users | id int4 NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о пользователях |
| production.orders | order_id int4 NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о пользователях |
| production.orders | cost = (payment + bonus_payment) | Условие заполнения  | Обеспечивает соответствие бизнес-логике |
| production.orders | order_ts timestamp NOT NULL | Формат данных  | Исключение пропусков при заполнении |
| production.orders | user_id timestamp NOT NULL | Формат данных  | Исключение пропусков при заполнении |
| production.orders | bonus_payment timestamp NOT NULL DEFAULT 0 | Формат данных  | Исключение пропусков при заполнении, замена пропусков на 0 |
| production.orders | payment timestamp NOT NULL DEFAULT 0 | Формат данных  | Исключение пропусков при заполнении, замена пропусков на 0 |
| production.orders | cost timestamp NOT NULL DEFAULT 0 | Формат данныхя  | Исключение пропусков при заполнении, замена пропусков на 0 |
| production.orders | bonus_grant timestamp NOT NULL DEFAULT 0 | Формат данных  | Исключение пропусков при заполнении, замена пропусков на 0 |
| production.orders | status timestamp NOT NULL DEFAULT 0 | Формат данных  | Исключение пропусков при заполнении, замена пропусков на 0 |
| production.orderitems | id int4 NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о пользователях и сквозную нумерацию строк|
| production.orderitems | (discount >= (0)::numeric) AND (discount <= price) | Условие заполнения   | Обеспечивает соответствие бизнес-логике |
| production.orderitems | UNIQUE (order_id, product_id) | Условие заполнения   | Исключает повторное использование записи о продукте в одном заказе |
| production.orderitems | (price >= (0)::numeric) | Условие заполнения   | Исключает отрицательные значения поля price |
| production.orderitems | (quantity > 0) | Условие заполнения   | Обеспечивает заполнение количества продуктов положительным числом |
| production.orderitems | product_id int4 NOT NULL | Формат данных  | Исключение пропусков при заполнении |
| production.orderitems | order_id int4 NOT NULL | Формат данных  | Исключение пропусков при заполнении |
| production.orderitems | name varchar(2048) NOT NULL | Формат данных  | Исключение пропусков при заполнении |
| production.orderitems | price numeric(19, 5) NOT NULL DEFAULT 0 | Формат данных  | Исключение пропусков при заполнении, замена пропусков на 0 |
| production.orderitems | discount numeric(19, 5) NOT NULL DEFAULT 0 | Формат данных  | Исключение пропусков при заполнении, замена пропусков на 0 |
| production.orderitems | quantity int4 NOT NULL | Формат данных  | Исключение пропусков при заполнении |
| production.orderitems | FOREIGN KEY (order_id) REFERENCES production.orders(order_id) |Внешний ключ  | Связь с таблицей orders |
| production.orderitems | FOREIGN KEY (product_id) REFERENCES production.products(id); | Внешний ключ  | Связь с таблицей products |
| production.products | id int4 NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о пользователях |
| production.products | "name" varchar(2048) NOT NULL | Формат данных  | Исключение пропусков при заполнениих |
| production.products | price numeric(19, 5) NOT NULL DEFAULT 0 | Формат данных  | Исключение пропусков при заполнении, замена пропусков на 0 |
| production.products | (price >= (0)::numeric) | Условие заполнения  | Исключение пропусков при заполнении |
| production.orderstatuses | id int4 NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о статусах заказов |
| production.orderstatuses | "key" varchar(255) NOT NULL | Формат данных  | Исключение пропусков при заполнении |
| production.orderstatuslog | id int4 NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о пользователях и сквозную нумерацию строк|
| production.orderstatuslog | UNIQUE (order_id, status_id) | Условие заполнения   | Исключает повторное использование статуса для одного заказа |
| production.orderstatuslog | order_id int4 NOT NULL | Формат данных  | Исключение пропусков при заполнении |
| production.orderstatuslog | status_id int4 NOT NULL | Формат данных  | Исключение пропусков при заполнении |
| production.orderstatuslog | dttm timestamp NOT NULL | Формат данных  | Исключение пропусков при заполнении |
| production.orderstatuslog | FOREIGN KEY (order_id) REFERENCES production.orders(order_id) | Внешний ключ  | Связь с таблицей orders |
| production.orderstatuslog | FOREIGN KEY (status_id) REFERENCES production.orderstatuses(id) | Внешний ключ  | Связь с таблицей orderstatuses |
