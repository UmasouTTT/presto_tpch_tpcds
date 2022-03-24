 
SELECT 
  sum(l.extendedprice)/7.0 as avg_yearly 
FROM 
  varada.tpch_300.lineitem l,
  varada.tpch_300.part p
WHERE 
  p.partkey = l.partkey 
  AND p.brand = 'Brand#23' 
  AND p.container = 'MED BOX'
  AND l.quantity < (
    SELECT 
      0.2*avg(l.quantity) 
    FROM 
      varada.tpch_300.lineitem l
    WHERE 
    l.partkey = p.partkey
  )
;
