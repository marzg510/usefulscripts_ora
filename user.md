# ユーザー関連


## パスワード有効期限設定

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

## ORA-28001

パスワード期限切れ警告が出た場合は、有効期限設定だけでは解除されない。
パスワードを設定しなおす必要あり。

```
alter user scott identified by "scott";
```

## アカウントアンロック

パスワード期限切れの時はパスワードも変更してあげないとだめ。前と同じでも効く。

```
alter user scott identified by "scott";
alter user scott account unlock;
```
