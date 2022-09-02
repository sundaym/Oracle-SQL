/* merge into examples */

-- example1 存在更新不存在删除
merge into t1 a
    using (select t1_id, address, age from t2) b
    on (a.id = b.t1_id)
    when matched then
        update set a.address = b.address, a.age = b.age
    when not matched then
        insert (a.address, a.age) values (b.address, b.age);

-- example2 只更新
merge into t2
using t1
on (t1.name = t2.name)
when matched then
    update set t2.address = t1.address

-- example3 只插入
merge into t2
using t1
on (t1.name = t2.name)
when not matched then
    insert
    values (t1.name, t2.address)

-- example4 交换更新, 将t1表id=1的address改为id=2的address, id=2的address改为id=1的address
merge into t1
using (select 1 id, (select address from t1 where id = 2) address
       from dual
       union all
       select 2, (select address from t1 where id = 1)
       from dual) t
on (t1.id = t.id)
when matched then
    update
    set t1.address=t.address
