-- merge into examples

merge into t1 a
    using (select t1_id, address, age from t2) b
    on a.id = b.t1_id
    when matched then
        update set a.address = b.address, a.age = b.age
    when not matched then
        insert (a.address, a.age) values (b.address, b.age);
