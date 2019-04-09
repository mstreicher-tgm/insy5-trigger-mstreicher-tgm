## Übungen (MySQL)

[Zurück zu MySQL](README.md)

Portiere die zuletzt verwendete Datenbank restaurant von PostgreSQL nach MySQL und
ergänze das DDL-Script um folgende Trigger-Definitionen:

- Wenn bei einer zu speichernden rechnung die Spalte datum den Wert NULL hat, soll sie
  jeweils durch den aktuellen Wert CURRENT_DATE ersetzt werden.

  ```mysql
  DELIMITER //
  CREATE TRIGGER rechnung_i_a 
  	BEFORE INSERT ON rechnung
  	FOR EACH ROW
  	BEGIN
  		if NEW.datum IS NULL THEN
  			SET NEW.datum = CURRENT_DATE;
  		END IF;
  	END;//
  DELIMITER ;
  
  INSERT INTO rechnung VALUES (7, NULL, 3, "offen", 3);
  SELECT * FROM rechnung WHERE rnr = 7;
  ```

- Wenn in der Tabelle speise ein preis geändert wird, soll ein zusätzlicher Datensatz in
  der Tabelle preisaenderung eingefügt werden. In der Spalte datum soll das aktuelle
  Datum gespeichert werden und in der Spalte aenderung soll die Preisänderung
  gespeichert werden. PK (snr, datum).

  ```mysql
  CREATE TABLE aenderung (
      snr         INTEGER,
      datum 		 DATE,
      aenderung   DECIMAL(6,2),
      PRIMARY KEY (snr, datum)
      FOREIGN KEY (snr) REFERENCES speise (snr)
      ON UPDATE CASCADE 
      ON DELETE CASCADE
  );
             
  DELIMITER //
  CREATE TRIGGER speise_a_u
  	AFTER UPDATE ON speise
  	FOR EACH ROW
  	BEGIN
  		INSERT INTO aenderung VALUES (NEW.snr, CURRENT_DATE, NEW.preis - OLD.preis);
  	END; //
  DELIMITER ;
  
  UPDATE speise SET preis = 24 WHERE snr = 8;
  SELECT * FROM preis WHERE snr = 8;
  ```

- Wenn in der Tabelle bestellung ein Datensatz gelöscht wird, soll ein zusätzlicher
  Datensatz in der Tabelle bestellstorno gespeichert werden.

  ```mysql
  CREATE TABLE bestellstorno (
      anzahl      SMALLINT,
      rnr         INTEGER,
      snr         INTEGER,
      datum		DATE,
      PRIMARY KEY (rnr, snr)
      FOREIGN KEY (snr) REFERENCES rechnung (rnr)
      ON UPDATE CASCADE 
      ON DELETE CASCADE,
      FOREIGN KEY (snr) REFERENCES speise (snr)
      ON UPDATE CASCADE 
      ON DELETE CASCADE
  );
  
  DELIMITER //
  CREATE TRIGGER bestellung_a_d
  	AFTER DELETE ON bestellung
  	BEGIN
  		INSERT INTO bestellstorno VALUES (OLD.anzahl, OLD.rnr, OLD.snr, CURRENT_DATE);
  	END;//
  DELIMITER ;
  ```

- In der Tabelle statistik soll datumsabhängig die Anzahl aller im Restaurant
  angebotenen Speisen dokumentiert werden. Erstelle alle erforderlichen Definitionen!
  ```mysql
  CREATE TABLE statistik (
  	datum 	  DATE,
	snr	      INTEGER
  );

  DELIMITER //
  CREATE TRIGGER speise_a_i
  	AFTER INSERT ON speise
  	FOR EACH ROW
  	BEGIN
  		INSERT INTO statistik VALUES (CURRENT_DATE, NEW.snr);
  	END; //
  DELIMITER ;
  
  
  INSERT INTO speise VALUES (9, 'Familien Menue'  30);
  SELECT * FROM statistik;
  ```

- Die ENGINE=MYISAM gestattet die Verwendung von Triggern. Realisiere eine 1:NBeziehung mit der ENGINE=MYISAM, d.h. das FK-Constraint und die CASCADEVerarbeitung sollen mittels Triggern nachgebildet werden.

