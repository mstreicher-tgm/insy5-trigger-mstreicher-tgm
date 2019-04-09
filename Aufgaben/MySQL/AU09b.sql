DROP DATABASE restaurant;
CREATE DATABASE restaurant;

CREATE TABLE kellner (
             knr         INTEGER,
             name        VARCHAR(255),
             PRIMARY KEY (knr)
             );

INSERT INTO kellner VALUES (1, 'Kellner1');
INSERT INTO kellner VALUES (2, 'Kellner2');
INSERT INTO kellner VALUES (3, 'Kellner3');

CREATE TABLE speise (
             snr         INTEGER,
             bezeichnung VARCHAR(255),
             preis       DECIMAL(6,2),
             PRIMARY KEY (snr)
             );

INSERT INTO speise VALUES (1, 'Heisse Liebe',         3);
INSERT INTO speise VALUES (2, 'Schoko Palatschinken', 4);
INSERT INTO speise VALUES (3, 'Pute gebacken',        7);
INSERT INTO speise VALUES (4, 'Pute natur',           8);
INSERT INTO speise VALUES (5, 'Puten-Cordon',         9);
INSERT INTO speise VALUES (6, 'Menue fuer 2',        15);
INSERT INTO speise VALUES (7, 'Menue fuer 3',        19);
INSERT INTO speise VALUES (8, 'Menue fuer 4',        22);

CREATE TABLE rechnung (
             rnr         INTEGER,
             datum       DATE,
             tisch       SMALLINT,
             status      CHAR(8),
             knr         INTEGER,
             PRIMARY KEY (rnr),
             FOREIGN KEY (knr) REFERENCES kellner (knr)
                               ON UPDATE CASCADE ON DELETE CASCADE
             );

INSERT INTO rechnung VALUES (1, '2013-03-07', 1, 'bezahlt', 1);
INSERT INTO rechnung VALUES (2, '2013-03-07', 2, 'offen', 2);
INSERT INTO rechnung VALUES (3, '2013-03-07', 1, 'gedruckt', 3);
INSERT INTO rechnung VALUES (4, '2013-03-07', 1, 'gedruckt', 1);
INSERT INTO rechnung VALUES (5, '2013-03-07', 1, 'bezahlt', 1);
INSERT INTO rechnung VALUES (6, '2013-03-07', 2, 'offen', 2);

CREATE TABLE bestellung (
             anzahl      SMALLINT,
             rnr         INTEGER,
             snr         INTEGER,
             PRIMARY KEY (rnr, snr),
             FOREIGN KEY (rnr) REFERENCES rechnung (rnr)
                               ON UPDATE CASCADE ON DELETE CASCADE,
             FOREIGN KEY (snr) REFERENCES speise (snr)
                               ON UPDATE CASCADE ON DELETE CASCADE
             );

INSERT INTO bestellung VALUES (9, 1, 1);
INSERT INTO bestellung VALUES (1, 1, 4);
INSERT INTO bestellung VALUES (1, 1, 5);
INSERT INTO bestellung VALUES (1, 2, 7);
INSERT INTO bestellung VALUES (1, 3, 8);
INSERT INTO bestellung VALUES (9, 4, 1);
INSERT INTO bestellung VALUES (9, 5, 1);
INSERT INTO bestellung VALUES (9, 6, 2);

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
