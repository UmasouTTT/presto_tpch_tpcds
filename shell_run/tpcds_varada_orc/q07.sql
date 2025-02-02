 
SELECT
  "i_item_id"
, "avg"("ss_quantity") "agg1"
, "avg"("ss_list_price") "agg2"
, "avg"("ss_coupon_amt") "agg3"
, "avg"("ss_sales_price") "agg4"
FROM
  varada.tpcds_orc_1000.store_sales
, varada.tpcds_orc_1000.customer_demographics
, varada.tpcds_orc_1000.date_dim
, varada.tpcds_orc_1000.item
, varada.tpcds_orc_1000.promotion
WHERE ("ss_sold_date_sk" = "d_date_sk")
   AND ("ss_item_sk" = "i_item_sk")
   AND ("ss_cdemo_sk" = "cd_demo_sk")
   AND ("ss_promo_sk" = "p_promo_sk")
   AND ("cd_gender" = 'M')
   AND ("cd_marital_status" = 'S')
   AND ("cd_education_status" = 'College             ')
   AND (("p_channel_email" = 'N')
      OR ("p_channel_event" = 'N'))
   AND ("d_year" = 2000)
GROUP BY "i_item_id"
ORDER BY "i_item_id" ASC
LIMIT 100;
