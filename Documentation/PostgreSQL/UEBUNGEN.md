## Übungen (PostgreSQL)

[Zurück zu PostgreSQL](README.md)

README.md)

Portiere die zuletzt verwendete Datenbank restaurant von PostgreSQL nach MySQL und
ergänze das DDL-Script um folgende Trigger-Definitionen:

- Wenn bei einer zu speichernden rechnung die Spalte datum den Wert NULL hat, soll sie
  jeweils durch den aktuellen Wert CURRENT_DATE ersetzt werden.

  ```mysql
  
  THIS IS AN AWNSER
  
  ```

- Wenn in der Tabelle speise ein preis geändert wird, soll ein zusätzlicher Datensatz in
  der Tabelle preisaenderung eingefügt werden. In der Spalte datum soll das aktuelle
  Datum gespeichert werden und in der Spalte aenderung soll die Preisänderung
  gespeichert werden. PK (snr, datum).

  ```mysql
  
  THIS IS AN AWNSER
  
  ```

- Wenn in der Tabelle bestellung ein Datensatz gelöscht wird, soll ein zusätzlicher
  Datensatz in der Tabelle bestellstorno gespeichert werden.

  ```mysql
  
  THIS IS AN AWNSER
  
  ```

- In der Tabelle statistik soll datumsabhängig die Anzahl aller im Restaurant
  angebotenen Speisen dokumentiert werden. Erstelle alle erforderlichen Definitionen!

  ```mysql
  
  THIS IS AN AWNSER
  
  ```

- Die ENGINE=MYISAM gestattet die Verwendung von Triggern. Realisiere eine 1:NBeziehung mit der ENGINE=MYISAM, d.h. das FK-Constraint und die CASCADEVerarbeitung sollen mittels Triggern nachgebildet werden.

