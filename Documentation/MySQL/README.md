## MySQL

[Zurück zur Übersicht](../../README.md)

### Allgemeine Syntax

```mysql
DROP TRIGGER <trigger_name>;
CREATE TRIGGER <trigger_name> BEFORE | AFTER INSERT | DELETE | UPDATE
ON <tab_name> FOR EACH ROW | STATEMENT
BEGIN
	<trigger_verarbeitung>
END;
```

### Beispiel

```mysql
DELIMITER //
CREATE TRIGGER preis_check BEFORE UPDATE ON speise
	FOR EACH ROW
	BEGIN
		IF NEW.preis < 0 THEN
			SET NEW.preis = 0;
		ELSEIF NEW.preis > 100 THEN
			SET NEW.preis = 100;
		END IF;
	END;//
DELIMITER;
```

Durch die Angaben DELIMITER // sowie DELIMITER ; wird die Zeichenfolge // als
Abschluss der Kommandoeingabe definiert. Damit können innerhalb der Trigger-Definition
mehrere SQL-Anweisungen jeweils durch ; getrennt verwendet werden, ohne dass dies
bei der Eingabe der Trigger-Definition zur Unterbrechung oder vorzeitigen Abarbeitung der
Eingabe führt. Achtung: nach DELIMITER muss unbedingt ein Leerzeichen folgen!

Im Trigger kann auf die Spalten der getriggerten SQL-Anweisung zugegriffen werden:

- OLD.spalte repräsentiert den alten Wert bzw. den Wert vor der Änderung,
- NEW.spalte repräsentiert den neuen Wert bzw. den Wert nach der Änderung.

Der neue Wert kann mit SET NEW.spalte = ; überschrieben werden.

Trigger können auch DML-Anweisungen für Änderungen in anderen Tabellen enthalten.
Diese SQL-Anweisungen müssen ohne OLD. und ohne NEW. formuliert werden, da sich
OLD. bzw. NEW. jeweils nur auf den Datensatz der getriggerten Tabelle beziehen!
Trigger werden häufig zur Vermeidung des Lost-Update-Problems eingesetzt.
Im folgenden Beispiel wird die Versionsnummer in der Tabelle rechnung um 1 erhöht,
sobald ein neuer Datensatz in die Tabelle bestellung eingefügt wird.
Für DELETE und UPDATE sind noch zwei weitere ähnliche Trigger erforderlich!

```mysql
DELIMITER //
CREATE TRIGGER bestellung_a_i
	AFTER INSERT ON bestellung
	FOR EACH ROW
	BEGIN
		UPDATE rechnung
		SET version = version + 1
		WHERE rid = NEW.rid;
	END;//
DELIMITER ;
```

### Übungen
Siehe Hier: [Klick](UEBUNGEN.md)
