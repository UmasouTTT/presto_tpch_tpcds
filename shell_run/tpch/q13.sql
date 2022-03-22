 
SELECT 
  c_count, 
  count(*) as custdist
FROM (
  SELECT 
    c.custkey, 
    count(o.orderkey)
  FROM 
    hive.tpch_100.customer c
    LEFT OUTER JOIN
    hive.tpch_100.orders o
  ON 
    c.custkey = o.custkey
    AND o.comment NOT LIKE '%special%requests%'
  GROUP BY c.custkey
) AS c_orders (c_custkey, c_count)
GROUP BY 
  c_count
ORDER BY 
  custdist DESC, 
  c_count DESC
;
