管理者に与えておきたい権限
スーパーではなく、ミスっても環境破壊をおこさない程度の権限

```SQL
-- 各種ディクショナリビューの参照権限（V$シリーズもこれでOK）
GRANT SELECT ANY DICTIONARY TO nbdba;
```
