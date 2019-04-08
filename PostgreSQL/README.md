## PostgreSQL 

[Zurück zur Übersicht](../README.md)

### Allgemeine Syntax

```mysql
CREATE TRIGGER name { BEFORE | AFTER | INSTEAD OF } { event [ OR ... ] }
	ON table_name
	[ FROM referenced_table_name ]
	[ NOT DEFERRABLE | [ DEFERRABLE ] { INITIALLY IMMEDIATE | INITIALLY DEFERRED }]
	[ FOR [ EACH ] { ROW | STATEMENT } ]
	[ WHEN ( condition ) ]
	EXECUTE PROCEDURE function_name ( arguments )
```
*where event can be one of:*

```mysql
	INSERT
	UPDATE [ OF column_name [, ... ] ]
	DELETE
	TRUNCATE
```

### Links

- Übungen: [Klick](UEBUNGEN.md)

