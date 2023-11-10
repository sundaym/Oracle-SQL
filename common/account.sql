-- Oracle用户查询
SELECT * FROM DBA_USERS；

/**** 密码过期策略修改 ******/
-- 查询
SELECT *
  FROM DBA_PROFILES
 WHERE PROFILE IN ('DEFAULT')
   AND RESOURCE_NAME = 'PASSWORD_LIFE_TIME';
-- 修改过期限制
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;

-- 解锁LOCKED用户
alter user PLM_ERP_INT account unlock;

-- 已过期用户(ACCOUNT_STATUS为EXPIRED)，解除只能通过再次修改密码接触，密码可以相同
alter user SCOTT identified by 123456;
