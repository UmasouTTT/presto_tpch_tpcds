 
SELECT 
  o.orderpriority, 
  count(*) AS order_count 
FROM 
  hive.tpch_300.orders o
WHERE  
  o.orderdate >= DATE '1993-07-01'
  AND o.orderdate < DATE '1993-07-01' + INTERVAL '3' MONTH
  AND EXISTS (
    SELECT 
      * 
    FROM 
      hive.tpch_300.lineitem l
    WHERE 
      l.orderkey = o.orderkey 
      AND l.commitdate < l.receiptdate
  )
GROUP BY 
  o.orderpriority
ORDER BY 
  o.orderpriority
;
