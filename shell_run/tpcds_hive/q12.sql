 
SELECT
  "i_item_id"
, "i_item_desc"
, "i_category"
, "i_class"
, "i_current_price"
, "sum"("ws_ext_sales_price") "hive.tpcds_1000.itemrevenue"
, (("sum"("ws_ext_sales_price") * 100) / "sum"("sum"("ws_ext_sales_price")) OVER (PARTITION BY "i_class")) "revenueratio"
FROM
  hive.tpcds_1000.web_sales
, hive.tpcds_1000.item
, hive.tpcds_1000.date_dim
WHERE ("ws_item_sk" = "i_item_sk")
   AND ("i_category" IN ('Sports                                            ', 'Books                                             ', 'Home                                              '))
   AND ("ws_sold_date_sk" = "d_date_sk")
   AND (CAST("d_date" AS DATE) BETWEEN CAST('1999-02-22' AS DATE) AND (CAST('1999-02-22' AS DATE) + INTERVAL  '30' DAY))
GROUP BY "i_item_id", "i_item_desc", "i_category", "i_class", "i_current_price"
ORDER BY "i_category" ASC, "i_class" ASC, "i_item_id" ASC, "i_item_desc" ASC, "revenueratio" ASC
LIMIT 100;
