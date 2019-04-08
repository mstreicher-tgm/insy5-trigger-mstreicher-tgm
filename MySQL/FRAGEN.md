## Kontrollfragen (MySQL)

[Zurück zu MySQL](README.md)

Beantworte folgende Kontrollfragen:

- Sind mehrere Trigger für dasselbe Aktivierungs-Event (z.B. BEFORE INSERT ON xxx)
  zulässig?
- Können innerhalb BEGIN … END mehrere SQL-Anweisungen definiert werden?
- Können Trigger die Anweisungen START TRANSACTION, COMMIT oder ROLLBACK
  enthalten?
- Was bewirkt das Constraint NOT NULL in Kombination mit einem BEFORE-Trigger?
  IF NEW.xxx IS NULL THEN SET NEW.xxx = ... END IF;
- Kann in einem Trigger auf Datensätze einer anderen Tabelle zugegriffen werden?
- Welche der folgenden Kombinationen / Zugriffe sind zulässig? Ergänze die folgende Tabelle! Begründe die Aussagen!