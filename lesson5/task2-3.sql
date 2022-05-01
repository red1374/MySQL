-- Подсчитайте произведение чисел в столбце таблицы.
DROP TABLE IF EXISTS test_mult;
CREATE TABLE test_mult(
    `value` int
);
INSERT INTO test_mult VALUES
    (1), (2), (3), (4), (5);

SELECT EXP(SUM(LOG(`value`))) AS mult
    FROM test_mult;