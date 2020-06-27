##
##
##



##_META:
##


## <JINJA>
{% set var = "" %}
## </JINJA>



#
"F3CC978A-ABBC-4DB4-AE92-0AF5FB502DD7":
  sqlite3.table_present:
    - db: /var/www/data/app.sqlite
    - schema: CREATE TABLE `users` (`username` TEXT COLLATE NOCASE UNIQUE NOT NULL, `password` BLOB NOT NULL, `salt` BLOB NOT NULL, `last_login` INT)



## EOF
