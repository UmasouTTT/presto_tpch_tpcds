 
SELECT
  c.name,
  c.custkey,
  o.orderkey,
  o.orderdate,
  o.totalprice,
  sum(l.quantity)
FROM
  tpcds.sf100.customer AS c,
  tpcds.sf100.orders AS o,
  tpcds.sf100.lineitem AS l
WHERE
  o.orderkey IN (
    SELECT l.orderkey
    FROM
      tpcds.sf100.lineitem AS l
    GROUP BY
      l.orderkey
    HAVING
      sum(l.quantity) > 300
  )
  AND c.custkey = o.custkey
  AND o.orderkey = l.orderkey
GROUP BY
  c.name,
  c.custkey,
  o.orderkey,
  o.orderdate,
  o.totalprice
ORDER BY
  o.totalprice DESC,
  o.orderdate
LIMIT 100
;
