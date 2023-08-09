/*********************************
Oracle temporary table

*********************************/

-- 1. transaction
create global temporary table temp_table_transaction
(
    col1 varchar2(100),
    col2 varchar2(100),
    col3 varchar2(100)
)
    on commit delete rows;

-- 2. session
create global temporary table temp_table_session
(
    col1 varchar2(100),
    col2 varchar2(100),
    col3 varchar2(100)
)
    on commit preserve rows;
