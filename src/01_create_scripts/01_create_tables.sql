DROP TABLE hra CASCADE CONSTRAINTS;

DROP TABLE hrac CASCADE CONSTRAINTS;

DROP TABLE omezeni CASCADE CONSTRAINTS;

DROP TABLE stav CASCADE CONSTRAINTS;

DROP TABLE tah CASCADE CONSTRAINTS;

CREATE TABLE hra (
    id                 INTEGER NOT NULL,
    stav_id            INTEGER NOT NULL,
    hrac_id_1          INTEGER NOT NULL,
    hrac_id_2          INTEGER NOT NULL,
    cas_hrac_1         INTEGER,
    cas_hrac_2         INTEGER,
    radek_velikost     INTEGER NOT NULL,
    sloupec_velikost   INTEGER NOT NULL,
    symbol_velikost    INTEGER NOT NULL
);

ALTER TABLE hra ADD CONSTRAINT pk_hra_id PRIMARY KEY ( id );

CREATE TABLE hrac (
    id                 INTEGER NOT NULL,
    prezdivka          NVARCHAR2(255) NOT NULL,
    vyhra_zacinal      INTEGER NOT NULL,
    vyhra_nezacinal    INTEGER NOT NULL,
    remiza_zacinal     INTEGER NOT NULL,
    remiza_nezacinal   INTEGER NOT NULL,
    prohra_zacinal     INTEGER NOT NULL,
    prohra_nezacinal   INTEGER NOT NULL
);

ALTER TABLE hrac ADD CONSTRAINT pk_hrac_id PRIMARY KEY ( id );

CREATE TABLE omezeni (
    id            INTEGER NOT NULL,
    radek_max     INTEGER NOT NULL,
    radek_min     INTEGER NOT NULL,
    sloupec_max   INTEGER NOT NULL,
    sloupec_min   INTEGER NOT NULL,
    symbol_max    INTEGER NOT NULL,
    symbol_min    INTEGER NOT NULL
);

ALTER TABLE omezeni ADD CONSTRAINT pk_omezeni_id PRIMARY KEY ( id );

CREATE TABLE stav (
    id      INTEGER NOT NULL,
    nazev   NVARCHAR2(32) NOT NULL
);

ALTER TABLE stav ADD CONSTRAINT pk_stav_id PRIMARY KEY ( id );

CREATE TABLE tah (
    id                   INTEGER NOT NULL,
    hra_id               INTEGER NOT NULL,
    hrac_id              INTEGER NOT NULL,
    radek_souradnice     INTEGER NOT NULL,
    sloupec_souradnice   INTEGER NOT NULL,
    cas_zacatku          TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE tah ADD CONSTRAINT pk_tah_id PRIMARY KEY ( id );

ALTER TABLE hra
    ADD CONSTRAINT fk_hra__hrac_id_1__hrac FOREIGN KEY ( hrac_id_1 )
        REFERENCES hrac ( id );

ALTER TABLE hra
    ADD CONSTRAINT fk_hra__hrac_id_2__hrac FOREIGN KEY ( hrac_id_2 )
        REFERENCES hrac ( id );

ALTER TABLE hra
    ADD CONSTRAINT fk_hra__stav_id__stav FOREIGN KEY ( stav_id )
        REFERENCES stav ( id );

ALTER TABLE tah
    ADD CONSTRAINT fk_tah__hra_id__hra FOREIGN KEY ( hra_id )
        REFERENCES hra ( id );

ALTER TABLE tah
    ADD CONSTRAINT fk_tah__hrac_id__hrac FOREIGN KEY ( hrac_id )
        REFERENCES hrac ( id );

DROP SEQUENCE hrac_id_seq;

CREATE SEQUENCE hrac_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER hra_id_trg BEFORE
    INSERT ON hra
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    SELECT
        hra_id_seq.NEXTVAL
    INTO :new.id
    FROM
        dual;

END;
/


DROP SEQUENCE hrac_id_seq;

CREATE SEQUENCE hrac_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER hrac_id_trg BEFORE
    INSERT ON hrac
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    SELECT
        hrac_id_seq.NEXTVAL
    INTO :new.id
    FROM
        dual;

END;
/

DROP SEQUENCE omezeni_id_seq;

CREATE SEQUENCE omezeni_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER omezeni_id_trg BEFORE
    INSERT ON omezeni
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    SELECT
        omezeni_id_seq.NEXTVAL
    INTO :new.id
    FROM
        dual;

END;
/

DROP SEQUENCE stav_id_seq;

CREATE SEQUENCE stav_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER stav_id_trg BEFORE
    INSERT ON stav
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    SELECT
        stav_id_seq.NEXTVAL
    INTO :new.id
    FROM
        dual;

END;
/

DROP SEQUENCE tah_id_seq;

CREATE SEQUENCE tah_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tah_id_trg BEFORE
    INSERT ON tah
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    SELECT
        tah_id_seq.NEXTVAL
    INTO :new.id
    FROM
        dual;

END;
/