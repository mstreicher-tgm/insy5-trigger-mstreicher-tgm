## Kontrollfragen (MySQL)

[Zurück zu MySQL](README.md)

Beantworte folgende Kontrollfragen:

- Sind mehrere Trigger für dasselbe Aktivierungs-Event (z.B. BEFORE INSERT ON xxx)
  zulässig?

  **Antwort:**

  *Das ist eine Antwort*

  

- Können innerhalb BEGIN … END mehrere SQL-Anweisungen definiert werden?

  **Antwort:**  *Ja, es können mehrere SQL-Anweisungen definiert werden wenn diese jeweils durch ein ; getrennt werden und ein DELIMITER // bzw. DELIMITER ; um den Trigger definiert wird. [Siehe Beispiele](README.md#Beispiel)*

  

- Können Trigger die Anweisungen START TRANSACTION, COMMIT oder ROLLBACK
  enthalten?

  **Antwort:**  *Nein, Der Trigger darf keine Anweisungen benutzen, die explizit oder implizit eine Transaktion starten oder beenden, wie etwa `START TRANSACTION`, `COMMIT` oder `ROLLBACK`.*

  

- Was bewirkt das Constraint NOT NULL in Kombination mit einem BEFORE-Trigger?
  IF NEW.xxx IS NULL THEN SET NEW.xxx = ... END IF;

  **Antwort:** 

  *Das ist eine Antwort*

  

- Kann in einem Trigger auf Datensätze einer anderen Tabelle zugegriffen werden?

  **Antwort:** 

  *Das ist eine Antwort*

  

- Welche der folgenden Kombinationen / Zugriffe sind zulässig? Ergänze die folgende Tabelle! Begründe die Aussagen!

  ![Tabelle](C:\Users\Matthias Streicher\AppData\Roaming\Typora\typora-user-images\1554749808470.png)

  **Antwort:** 

  *Das ist eine Antwort*