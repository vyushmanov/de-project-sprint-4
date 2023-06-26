# Витрина RFM

## 1.1. Требования к целевой витрине.

Витрина позволяет сегментировать клиентов по трем признакам:

- Давность - дата последнего заказа
- Частота - количество закахов
- Денежная ценность - общая выручка

`Расположение`: схема analysis

`Наименование витрины`: dm_rfm_segments

`Поля витрины`:

- user_id (идентификатор клиента)
- recency (число от 1 до 5)
- frequency (число от 1 до 5)
- monetary_value (число от 1 до 5)

`Период данных`: 2022 год

`Периодичность обновления`: обновление не требуется

`Дополнительные требования`:

- учитывать только завершенные заказы (статус closed)
- при необходимости распределить пользователей с равными показателями в различные сегменты, выбор производить случайным образом



## 1.2. Изучите структуру исходных данных.




## 1.3. Проанализируйте качество данных

{См. задание на платформе}
-----------

{Впишите сюда ваш ответ}


## 1.4. Подготовьте витрину данных

{См. задание на платформе}
### 1.4.1. Сделайте VIEW для таблиц из базы production.**

{См. задание на платформе}
```SQL
--Впишите сюда ваш ответ


```

### 1.4.2. Напишите DDL-запрос для создания витрины.**

{См. задание на платформе}
```SQL
--Впишите сюда ваш ответ


```

### 1.4.3. Напишите SQL запрос для заполнения витрины

{См. задание на платформе}
```SQL
--Впишите сюда ваш ответ


```



