 
SELECT 
  cntrycode, 
  count(*) AS numcust, 
  sum(acctbal) AS totacctbal
FROM 
  (
    SELECT 
      substr(c.phone,1,2) AS cntrycode,
      c.acctbal
    FROM 
      hive.tpch_100.customer c
    WHERE 
      substr(c.phone,1,2) IN ('13', '31', '23', '29', '30', '18', '17')
      AND c.acctbal > (
        SELECT 
          avg(c.acctbal) 
        FROM 
          hive.tpch_100.customer c
        WHERE 
          c.acctbal > 0.00 
          AND substr(c.phone,1,2) IN ('13', '31', '23', '29', '30', '18', '17')
      ) 
      AND NOT EXISTS (
        SELECT 
          * 
        FROM 
          hive.tpch_100.orders o
        WHERE 
          o.custkey = c.custkey
      )
  ) AS custsale
GROUP BY 
  cntrycode
ORDER BY 
  cntrycode
;
