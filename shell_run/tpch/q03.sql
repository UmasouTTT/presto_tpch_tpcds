 
SELECT
  l.orderkey,
  sum(l.extendedprice * (1 - l.discount)) AS revenue,
  o.orderdate,
  o.shippriority
FROM
  tpcds.sf100.customer AS c,
  tpcds.sf100.orders AS o,
  tpcds.sf100.lineitem AS l
WHERE
  c.mktsegment = 'BUILDING'
  AND c.custkey = o.custkey
  AND l.orderkey = o.orderkey
  AND o.orderdate < DATE '1995-03-15'
  AND l.shipdate > DATE '1995-03-15'
GROUP BY
  l.orderkey,
  o.orderdate,
  o.shippriority
ORDER BY
  revenue DESC,
  o.orderdate
LIMIT 10
;
