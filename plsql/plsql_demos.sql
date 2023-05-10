/***************************************************************
  plsql demos
  在sqlplus中或者PLSQL Develoer Command Window执行需要/结尾
  PLSQL Developer SQL Window中不需要
****************************************************************/

/****plsql hello world****/
DECLARE
    message varchar2(20) := 'Hello, World!';
BEGIN
    dbms_output.put_line(message);
END;
/

/****类型****/
DECLARE
    num1 INTEGER; -- Oracle提供的子类型
    num2 REAL;
    num3 DOUBLE PRECISION;
BEGIN
    null;
END;
/

/****自定义子类型****/
declare
    subtype name is char(20);
    subtype message is varchar2(100);
    salutation name;
    greetings  message;
begin
    salutation := 'Reader';
    greetings := 'Welcome to the World of PL/SQL';
    dbms_output.put_line('Hello ' || salutation || greetings);
end;
/

/****常量****/
DECLARE
    PI CONSTANT NUMBER := 3.14;
    RADIUS NUMBER(5, 2);
    DIA    NUMBER(5, 2);
    CIRC   NUMBER(7, 2);
    AREA   NUMBER(10, 2);
BEGIN
    RADIUS := 9.5;
    DIA    := RADIUS * 2;
    CIRC   := 2 * PI * RADIUS;
    AREA   := PI * RADIUS * RADIUS;
    DBMS_OUTPUT.PUT_LINE(AREA);
END;
/

/****字符****/
DECLARE
    MESSAGE VARCHAR2(30) := 'hello world';
BEGIN
    DBMS_OUTPUT.PUT_LINE(MESSAGE);
END;
/

/****Flow Control****/
-- IF
DECLARE
    A NUMBER(2) := 10;
BEGIN
    A := 10;
    -- check the boolean condition using if statement
    IF (A < 20) THEN
        -- if condition is true then print the following
        DBMS_OUTPUT.PUT_LINE('a is less than 20 ');
    END IF;
    DBMS_OUTPUT.PUT_LINE('value of a is : ' || A);
END;
/


-- if then elsif
DECLARE
    a number(3) := 100;
BEGIN
    IF ( a = 10 ) THEN
        dbms_output.put_line('Value of a is 10' );
    ELSIF ( a = 20 ) THEN
        dbms_output.put_line('Value of a is 20' );
    ELSIF ( a = 30 ) THEN
        dbms_output.put_line('Value of a is 30' );
    ELSE
        dbms_output.put_line('None of the values is matching');
    END IF;
    dbms_output.put_line('Exact value of a is: '|| a );
END;
/

/****循环****/
-- LOOP
DECLARE
    X NUMBER := 10;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(X);
        X := X + 10;
        IF X > 50 THEN
            EXIT;
        END IF;
    END LOOP;
    -- after exit, control resumes here
    DBMS_OUTPUT.PUT_LINE('After Exit x is: ' || X);
END;
/

-- WHILE
DECLARE
    A NUMBER(2) := 10;
BEGIN
    WHILE A < 20 LOOP
        DBMS_OUTPUT.PUT_LINE('value of a: ' || A);
        A := A + 1;
    END LOOP;
END;
/

-- FOR
DECLARE
    A NUMBER(2);
BEGIN
    FOR A IN 10 .. 20 LOOP
        DBMS_OUTPUT.PUT_LINE('value of a: ' || A);
    END LOOP;
END;
/

-- REVERSE FOR
DECLARE
    A NUMBER(2);
BEGIN
    FOR A IN REVERSE 10 .. 20 LOOP
        DBMS_OUTPUT.PUT_LINE('value of a: ' || A);
    END LOOP;
END;
/

/****数组 VARRAY****/
CREATE OR REPLACE TYPE varray_type_name IS VARRAY(n) OF VARCHAR2(10);
/

DECLARE
    TYPE NAMEARRAY IS VARRAY(5) OF VARCHAR2(10);
    TYPE GRADES IS VARRAY(5) OF INTEGER;
    NAMES NAMEARRAY;
    MARKS GRADES;
    TOTAL INTEGER;
BEGIN
    NAMES := NAMEARRAY('Jerry', 'Dave', 'Tom');
    MARKS := GRADES(98, 97, 99);
    TOTAL := NAMES.COUNT;
    DBMS_OUTPUT.PUT_LINE('Total ' || TOTAL || ' Students');
    FOR I IN 1 .. TOTAL LOOP
        DBMS_OUTPUT.PUT_LINE('Student:' || NAMES(I) || ' Marks: ' || MARKS(I));
    END LOOP;
END;
/

/**** procedure ****/
-- definition
CREATE OR REPLACE PROCEDURE greetings
AS
BEGIN
    dbms_output.put_line('Hello World!');
END;
/
-- 执行procedure, 使用 exec或execute
exec greeting;
execute greetings;

/****************************************************
function:
CREATE [OR REPLACE] FUNCTION function_name
[parameter_name [IN | OUT| IN OUT] TYPE [,...]]
RETURN return_datatype
{IS | AS}
BEGIN
  <function_body>
END [function_name];
****************************************************/
CREATE OR REPLACE FUNCTION totalCustomers
    RETURN number IS
    total number(2) := 0;
BEGIN
    SELECT count(*) into total
    FROM customers;
    RETURN total;
END;
/

-- 调用function
DECLARE
    c number(2);
BEGIN
    c := totalCustomers();
    dbms_output.put_line('当前客户的总数为: ' || c);
END;
/

/********************************************
  游标
  两种类型: 隐式游标, 显示游标
  cursor cursor_name is select_statement;
*********************************************/

DECLARE
    c_id customers.id%type;
    c_name customers.name%type;
    c_addr customers.address%type;
    -- 声明游标
    CURSOR c_customers is SELECT id, name, address FROM customers;
BEGIN
    -- 打开游标
    OPEN c_customers;
    LOOP
        -- 获取游标
        FETCH c_customers into c_id, c_name, c_addr;
        EXIT WHEN c_customers%notfound;
        dbms_output.put_line(c_id || ' ' || c_name || ' ' || c_addr);
    END LOOP;
    -- 关闭游标
    CLOSE c_customers;
END;
/

/****记录****/
-- 基于表
DECLARE
    customer_rec customers%rowtype;
BEGIN
    SELECT * into customer_rec FROM customers WHERE id = 5;
    dbms_output.put_line('客户ID: ' || customer_rec.id);
    dbms_output.put_line('客户姓名: ' || customer_rec.name);
    dbms_output.put_line('客户地址: ' || customer_rec.address);
    dbms_output.put_line('客户薪资: ' || customer_rec.salary);
END;
/

-- 基于游标
DECLARE
    CURSOR customer_cur is SELECT id, name, address FROM customers;
    customer_rec customer_cur%rowtype;
BEGIN
    OPEN customer_cur;
    LOOP
        FETCH customer_cur into customer_rec;
        EXIT WHEN customer_cur%notfound;
        DBMS_OUTPUT.put_line(customer_rec.id || ' ' || customer_rec.name);
    END LOOP;
END;
/

/********************

异常处理
********************/
DECLARE
    exception_name EXCEPTION;
BEGIN
    IF condition THEN
        RAISE exception_name;
    END IF;
EXCEPTION
    WHEN exception_name THEN
    statement;
END;
/
