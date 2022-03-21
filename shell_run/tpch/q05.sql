 
SELECT
  n.name,
  sum(l.extendedprice * (1 - l.discount)) AS revenue
FROM
  tpcds.sf100.customer AS c,
  tpcds.sf100.orders AS o,
  tpcds.sf100.lineitem AS l,
  tpcds.sf100.supplier AS s,
  tpcds.sf100.nation AS n,
  tpcds.sf100.region AS r
WHERE
  c.custkey = o.custkey
  AND l.orderkey = o.orderkey
  AND l.suppkey = s.suppkey
  AND c.nationkey = s.nationkey
  AND s.nationkey = n.nationkey
  AND n.regionkey = r.regionkey
  AND r.name = 'ASIA'
  AND o.orderdate >= DATE '1994-01-01'
  AND o.orderdate < DATE '1994-01-01' + INTERVAL '1' YEAR
GROUP BY
  n.name
ORDER BY
  revenue DESC
;
