# ユーザー関連


# パスワード有効期限設定

※PDB,CDBそれぞれ実施

```
-- 確認 
col profile format a20
col resource_name format a20
col limit format a20
select profile, resource_name,limit from dba_profiles
where RESOURCE_NAME='PASSWORD_LIFE_TIME';

-- 設定
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
```