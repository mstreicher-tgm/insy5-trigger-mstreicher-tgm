## Übungen (PostgreSQL)

[Zurück zu PostgreSQL](README.md)

Portiere die zuletzt verwendete Datenbank restaurant von PostgreSQL nach MySQL und
ergänze das DDL-Script um folgende Trigger-Definitionen:

- Wenn bei einer zu speichernden rechnung die Spalte datum den Wert NULL hat, soll sie
  jeweils durch den aktuellen Wert CURRENT_DATE ersetzt werden.

  ```mysql
  
  CREATE FUNCTION rechnung_b_i() RETURNS trigger AS $$
    BEGIN
      IF NEW.datum IS NULL THEN
        NEW.datum := current_date;
      END IF;
      RETURN NEW;
    END;
  $$ LANGUAGE plpgsql;
  
  CREATE trigger trigger_rechnung_b_i
    BEFORE INSERT ON rechnung
    FOR EACH ROW
    EXECUTE PROCEDURE rechnung_b_i();
  
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
  
  CREATE FUNCTION speise_a_u() RETURNS trigger AS $$
    BEGIN
      INSERT INTO aenderung VALUES (NEW.snr, CURRENT_DATE, NEW.preis - OLD.preis);
      RETURN NEW;
    END;
  $$ LANGUAGE plpgsql;
  
  CREATE TRIGGER trigger_speise_a_u
  	AFTER UPDATE ON speise
  	FOR EACH ROW
    EXECUTE PROCEDURE speise_a_u();
  
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
      datum		    DATE
  );
  
  CREATE FUNCTION bestellung_a_d() RETURNS trigger AS $$
    BEGIN
      INSERT INTO bestellstorno VALUES (OLD.anzahl, OLD.rnr, OLD.snr, CURRENT_DATE);
      RETURN NEW;
    END;
  $$ LANGUAGE plpgsql;
  
  CREATE TRIGGER trigger_bestellung_a_d
  	AFTER DELETE ON bestellung
    FOR EACH ROW
    EXECUTE PROCEDURE bestellung_a_d();
  
  DELETE FROM bestellung WHERE rnr = 1 AND snr = 1;
  SELECT * FROM bestellstorno;
  
  ```

- In der Tabelle statistik soll datumsabhängig die Anzahl aller im Restaurant
  angebotenen Speisen dokumentiert werden. Erstelle alle erforderlichen Definitionen!

  ```mysql
  
  CREATE TABLE statistik (
  	datum 	  DATE,
    snr	      INTEGER
  );
  
  CREATE FUNCTION speise_a_i() RETURNS trigger AS $$
    BEGIN
      INSERT INTO statistik VALUES (CURRENT_DATE, NEW.snr);
    END;
  $$ LANGUAGE plpgsql;
  
  CREATE TRIGGER trigger_speise_a_i
    AFTER INSERT ON speise
    FOR EACH ROW
    EXECUTE PROCEDURE speise_a_i();
  
  INSERT INTO speise VALUES (9, 'Familien Menue'  30);
  SELECT * FROM statistik;
  
  ```

