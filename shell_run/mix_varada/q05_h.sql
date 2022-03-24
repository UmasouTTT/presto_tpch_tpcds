 
SELECT
  n.name,
  sum(l.extendedprice * (1 - l.discount)) AS revenue
FROM
  varada.tpch_300.customer AS c,
  varada.tpch_300.orders AS o,
  varada.tpch_300.lineitem AS l,
  varada.tpch_300.supplier AS s,
  varada.tpch_300.nation AS n,
  varada.tpch_300.region AS r
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
