#!/usr/bin/env python

schemas = [
    # (new_schema, source_schema)
#    ('tpch-10', 'tpch.sf10'),
    ('tpch-100', 'tpch.sf100'),
    #('tpch-300', 'tpch.sf300'),
#    ('tpch-1000', 'tpch.sf1000'),
#    ('tpch-100000', 'tpch.sf10000'),

]

tables = [
    'customer',
    'lineitem',
    'nation',
    'orders',
    'part',
    'partsupp',
    'region',
    'supplier',
]

for (new_schema, source_schema) in schemas:
    format = 'ORC'
    # if new_schema.endswith('_orc'):
    #     format = 'ORC'
    # elif new_schema.endswith('_text'):
    #     format = 'TEXTFILE'
    # else:
    #     raise ValueError(new_schema)

    print('CREATE SCHEMA hive.%s;' % (new_schema,))
    for table in tables:
        print ('CREATE TABLE hive.%s.%s WITH (external_location="s3://%s/%s", format = \'%s\') AS SELECT * FROM %s.%s;' % \
              (new_schema, table, new_schema, table, format, source_schema, table))
