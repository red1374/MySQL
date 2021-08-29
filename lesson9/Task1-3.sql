-- Пусть имеется таблица с календарным полем created_at. 
-- В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16'
-- и 2018-08-17. Составьте запрос, который выводит полный список дат за август,
-- выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
DROP TABLE IF EXISTS test_dates;
CREATE TABLE test_dates (
    id serial,
    created_at DATE NOT NULL
);
INSERT INTO test_dates VALUES
    (NULL, '2018-08-01'),
    (NULL, '2016-08-04'),
    (NULL, '2018-08-16'),
    (NULL, '2018-08-17');

SET @start_date='2018-08-01';
SET @end_date='2018-08-31';
SELECT created_at, IF(created_at IN (
    SELECT concat(date_format(@start_date, '%Y-%m-'),
            IF (SEQ.SeqValue < 10, concat('0', SEQ.SeqValue), SEQ.SeqValue)
        ) month_day
        FROM (
            SELECT (TENS.SeqValue + ONES.SeqValue) SeqValue
            FROM (
                SELECT 0  SeqValue
                UNION ALL
                SELECT 1 SeqValue
                UNION ALL
                SELECT 2 SeqValue
                UNION ALL
                SELECT 3 SeqValue
                UNION ALL
                SELECT 4 SeqValue
                UNION ALL
                SELECT 5 SeqValue
                UNION ALL
                SELECT 6 SeqValue
                UNION ALL
                SELECT 7 SeqValue
                UNION ALL
                SELECT 8 SeqValue
                UNION ALL
                SELECT 9 SeqValue
            ) ONES,
            (
                SELECT 0 SeqValue
                UNION ALL
                SELECT 10 SeqValue
                UNION ALL
                SELECT 20 SeqValue
                UNION ALL
                SELECT 30 SeqValue        
            ) TENS
        ) SEQ
    WHERE SEQ.SeqValue >= date_format(@start_date, '%d') AND SEQ.SeqValue <= date_format(@end_date, '%d')
    ORDER BY SEQ.SeqValue
), 1, 0) in_table
    FROM test_dates td;