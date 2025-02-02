 
SELECT
  "c_customer_id" "customer_id"
, "concat"("concat"("c_last_name", ', '), "c_first_name") "varada.tpcds_orc_1000.customername"
FROM
  varada.tpcds_orc_1000.customer
, varada.tpcds_orc_1000.customer_address
, varada.tpcds_orc_1000.customer_demographics
, varada.tpcds_orc_1000.household_demographics
, varada.tpcds_orc_1000.income_band
, varada.tpcds_orc_1000.store_returns
WHERE ("ca_city" = 'Edgewood')
   AND ("c_current_addr_sk" = "ca_address_sk")
   AND ("ib_lower_bound" >= 38128)
   AND ("ib_upper_bound" <= (38128 + 50000))
   AND ("ib_income_band_sk" = "hd_income_band_sk")
   AND ("cd_demo_sk" = "c_current_cdemo_sk")
   AND ("hd_demo_sk" = "c_current_hdemo_sk")
   AND ("sr_cdemo_sk" = "cd_demo_sk")
ORDER BY "c_customer_id" ASC
LIMIT 100;
