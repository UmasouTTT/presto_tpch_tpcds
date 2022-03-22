 
SELECT
  nation,
  o_year,
  sum(amount) AS sum_profit
FROM (
       SELECT
         n.name                                                          AS nation,
         extract(YEAR FROM o.orderdate)                                  AS o_year,
         l.extendedprice * (1 - l.discount) - ps.supplycost * l.quantity AS amount
       FROM
         varada.tpch_300.part AS p,
         varada.tpch_300.supplier AS s,
         varada.tpch_300.lineitem AS l,
         varada.tpch_300.partsupp AS ps,
         varada.tpch_300.orders AS o,
         varada.tpch_300.nation AS n
       WHERE
         s.suppkey = l.suppkey
         AND ps.suppkey = l.suppkey
         AND ps.partkey = l.partkey
         AND p.partkey = l.partkey
         AND o.orderkey = l.orderkey
         AND s.nationkey = n.nationkey
         AND p.name LIKE '%green%'
     ) AS profit
GROUP BY
  nation,
  o_year
ORDER BY
  nation,
  o_year DESC
;
