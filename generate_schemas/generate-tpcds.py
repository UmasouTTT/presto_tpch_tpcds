#!/usr/bin/env python

schemas = [
    # (new_schema, source_schema)
#    ('tpcds-10', 'tpcds.sf10'),
#    ('tpcds-100', 'tpcds.sf100'),
    ('tpcds-100', 'tpcds.sf300'),
#    ('tpcds-1000', 'tpcds.sf1000'),
]

tables = [
    'call_center',
    'catalog_page',
    'catalog_returns',
    'catalog_sales',
    'customer',
    'customer_address',
    'customer_demographics',
    'date_dim',
    'household_demographics',
    'income_band',
    'inventory',
    'item',
    'promotion',
    'reason',
    'ship_mode',
    'store',
    'store_returns',
    'store_sales',
    'time_dim',
    'warehouse',
    'web_page',
    'web_returns',
    'web_sales',
    'web_site',
]

for (new_schema, source_schema) in schemas:
    format = 'ORC'
    # if new_schema.endswith('_orc'):
    #     format = 'ORC'
    # elif new_schema.endswith('_text'):
    #     format = 'TEXTFILE'
    # else:
    #     raise ValueError(new_schema)

    print("CREATE SCHEMA hive.%s;" % (new_schema,))
    for table in tables:
        print('CREATE TABLE hive.%s.%s WITH (external_location="s3://%s/%s", "format = \'%s\") AS SELECT * FROM %s."%s";' % \
              (new_schema, table, new_schema,table, format, source_schema, table))
