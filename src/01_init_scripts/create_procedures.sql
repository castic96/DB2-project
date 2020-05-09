--
-- Pomocna procedura pro registraci hrace.
--
CREATE OR REPLACE PROCEDURE registruj_hrace ( prezdivka IN NVARCHAR2, id IN INTEGER DEFAULT NULL ) AS

BEGIN

    IF id IS NULL THEN
        INSERT INTO hrac 
            ( prezdivka, vyhra_zacinal, vyhra_nezacinal, remiza_zacinal, remiza_nezacinal, prohra_zacinal, prohra_nezacinal ) 
        VALUES 
            ( prezdivka, 0, 0, 0, 0, 0, 0 );
    ELSE
        INSERT INTO hrac 
            ( id, prezdivka, vyhra_zacinal, vyhra_nezacinal, remiza_zacinal, remiza_nezacinal, prohra_zacinal, prohra_nezacinal ) 
        VALUES 
            ( id, prezdivka, 0, 0, 0, 0, 0, 0 );
    END IF;
    
    COMMIT;

END;
/

--
-- Pomocna procedura pro zahajeni hry.
--
CREATE OR REPLACE PROCEDURE zahaj_hru ( hrac_id_1 IN INTEGER, hrac_id_2 IN INTEGER, radek_velikost IN INTEGER, 
    sloupec_velikost IN INTEGER, symbol_velikost IN INTEGER, id IN INTEGER DEFAULT NULL ) AS
    
    stav_id INTEGER := 1;
    
BEGIN

    IF id IS NULL THEN
        INSERT INTO hra 
            ( stav_id, hrac_id_1, hrac_id_2, radek_velikost, sloupec_velikost, symbol_velikost ) 
        VALUES 
            ( stav_id, hrac_id_1, hrac_id_2, radek_velikost, sloupec_velikost, symbol_velikost );
    ELSE
        INSERT INTO hra 
            ( id, stav_id, hrac_id_1, hrac_id_2, radek_velikost, sloupec_velikost, symbol_velikost ) 
        VALUES 
            ( id, stav_id, hrac_id_1, hrac_id_2, radek_velikost, sloupec_velikost, symbol_velikost );
    END IF;
    
    COMMIT;

END;
/

--
-- Pomocna procedura pro tah.
--
CREATE OR REPLACE PROCEDURE proved_tah ( hra_id IN INTEGER, hrac_id IN INTEGER, radek_souradnice IN INTEGER, 
    sloupec_souradnice IN INTEGER ) AS
    
BEGIN

    INSERT INTO tah 
            ( hra_id, hrac_id, radek_souradnice, sloupec_souradnice ) 
        VALUES 
            ( hra_id, hrac_id, radek_souradnice, sloupec_souradnice );
    
    COMMIT;

END;
/

--
-- Procedura, ktera spocita herni casy prave dokoncene hry.
--
CREATE OR REPLACE PROCEDURE konec_hry ( hra_id IN INTEGER, hrac_id IN INTEGER ) AS

hra_radek hra%ROWTYPE;
    
BEGIN

    SELECT * INTO hra_radek 
    FROM hra 
    WHERE hra.id = hra_id
        AND rownum = 1;
        
    UPDATE hra
    SET 
        cas_hrac_1 = herni_cas ( hra_id, hra_radek.hrac_id_1 ),
        cas_hrac_2 = herni_cas ( hra_id, hra_radek.hrac_id_2 )
    WHERE id = hra_id;

END;
/

--
-- Procedura, ktera aktualizuje stav dokoncene hry.
--
CREATE OR REPLACE PROCEDURE aktualizuj_stav_hry ( hra_id IN INTEGER, hrac_id IN INTEGER DEFAULT NULL ) AS

hrac_id_prvni_tah INTEGER;
    
BEGIN
        
    IF hrac_id IS NULL THEN
    
        UPDATE hra
        SET stav_id = 4
        WHERE id = hra_id;
        
    ELSE
    
        SELECT hrac_id INTO hrac_id_prvni_tah
        FROM tah
        WHERE tah.hra_id = hra_id
            AND rownum = 1
        ORDER BY tah.id;
        
        IF hrac_id_prvni_tah = hrac_id THEN
            
            UPDATE hra
            SET stav_id = 2
            WHERE id = hra_id;
                
        ELSE
        
            UPDATE hra
            SET stav_id = 3
            WHERE id = hra_id;
        
        END IF;
        
    END IF;

END;
/