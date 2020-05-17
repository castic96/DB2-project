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
-- Pomocna procedura pro realizaci tahu.
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
        cas_hrac_1 = herni_cas ( hra_radek.id, hra_radek.hrac_id_1 ),
        cas_hrac_2 = herni_cas ( hra_radek.id, hra_radek.hrac_id_2 )
    WHERE id = hra_radek.id;

END;
/

--
-- Procedura, ktera aktualizuje stav dokoncene hry.
--
CREATE OR REPLACE PROCEDURE aktualizuj_stav_hry ( hra_id IN INTEGER, hrac_id IN INTEGER DEFAULT NULL ) AS

hrac_id_prvni_tah INTEGER;
hra_id_prom INTEGER := hra_id;
    
BEGIN
        
    IF hrac_id IS NULL THEN
    
        UPDATE hra
        SET stav_id = 4
        WHERE id = hra_id_prom;
        
    ELSE
    
        SELECT t1.hrac_id INTO hrac_id_prvni_tah
        FROM tah t1
		WHERE t1.id = 
			( SELECT MIN(t2.id) FROM tah t2 WHERE t2.hra_id = hra_id_prom );
        
        IF hrac_id_prvni_tah = hrac_id THEN
            
            UPDATE hra
            SET stav_id = 2
            WHERE id = hra_id_prom;
                
        ELSE
        
            UPDATE hra
            SET stav_id = 3
            WHERE id = hra_id_prom;
        
        END IF;
        
    END IF;

END;
/

--
-- Procedura, ktera aktualiuje statisticke udaje hracu, kteri dohrali danou hru.
--
CREATE OR REPLACE PROCEDURE statistiky ( hra_id IN INTEGER ) AS

hra_radek hra%ROWTYPE;
hrac_id_prvni INTEGER;
hrac_id_druhy INTEGER;
    
BEGIN

    SELECT * INTO hra_radek 
    FROM hra 
    WHERE hra.id = hra_id
        AND rownum = 1;
		
	SELECT t1.hrac_id INTO hrac_id_prvni
	FROM tah t1
	WHERE t1.id = 
		( SELECT MIN(t2.id) FROM tah t2 WHERE t2.hra_id = hra_radek.id );
    
    IF hrac_id_prvni = hra_radek.hrac_id_1 THEN
    
        hrac_id_druhy := hra_radek.hrac_id_2;
        
    ELSE
    
        hrac_id_druhy := hra_radek.hrac_id_1;
        
    END IF;
    
    CASE hra_radek.stav_id
    
        WHEN 2 THEN
        
            UPDATE hrac
            SET vyhra_zacinal = vyhra_zacinal + 1
            WHERE id = hrac_id_prvni;
            
            UPDATE hrac
            SET prohra_nezacinal = prohra_nezacinal + 1
            WHERE id = hrac_id_druhy;
            
        WHEN 3 THEN
        
            UPDATE hrac
            SET prohra_zacinal = prohra_zacinal + 1
            WHERE id = hrac_id_prvni;
            
            UPDATE hrac
            SET vyhra_nezacinal = vyhra_nezacinal + 1
            WHERE id = hrac_id_druhy;
        
        WHEN 4 THEN
        
            UPDATE hrac
            SET remiza_zacinal = remiza_zacinal + 1
            WHERE id = hrac_id_prvni;
            
            UPDATE hrac
            SET remiza_nezacinal = remiza_nezacinal + 1
            WHERE id = hrac_id_druhy;
			
		ELSE NULL;
        
    END CASE;

END;
/

--
-- Procedura, ktera zabrani vytvoreni nove hry, pokud je libovolny 
-- z parametru hry spatne nastaven.
--
CREATE OR REPLACE PROCEDURE zabran_hre ( radek_velikost IN INTEGER, 
    sloupec_velikost IN INTEGER, symbol_velikost IN INTEGER ) AS
    
omezeni_radek omezeni%ROWTYPE;
cislo_chyby INTEGER;
zprava_chyby NVARCHAR2(256);
    
BEGIN

    SELECT * INTO omezeni_radek 
    FROM omezeni 
    WHERE omezeni.id = 1;
    
    CASE spatny_parametr ( radek_velikost, sloupec_velikost, symbol_velikost )
    
        WHEN 1 THEN
        
            cislo_chyby := -20001;
            zprava_chyby := 'Prilis maly pocet radku na papiru (mensi nez '|| TO_CHAR(omezeni_radek.radek_min)|| ').';
            raise_application_error(cislo_chyby, zprava_chyby);
            
        WHEN 2 THEN
        
            cislo_chyby := -20002;
            zprava_chyby := 'Prilis velky pocet radku na papiru (vetsi nez '|| TO_CHAR(omezeni_radek.radek_max)|| ').';
            raise_application_error(cislo_chyby, zprava_chyby);
        
        WHEN 3 THEN
        
            cislo_chyby := -20003;
            zprava_chyby := 'Prilis maly pocet sloupcu na papiru (mensi nez '|| TO_CHAR(omezeni_radek.sloupec_min)|| ').';
            raise_application_error(cislo_chyby, zprava_chyby);
        
        WHEN 4 THEN
        
            cislo_chyby := -20004;
            zprava_chyby := 'Prilis velky pocet sloupcu na papiru (vetsi nez '|| TO_CHAR(omezeni_radek.sloupec_max)|| ').';
            raise_application_error(cislo_chyby, zprava_chyby);
            
        WHEN 5 THEN
        
            cislo_chyby := -20005;
            zprava_chyby := 'Prilis maly pocet znaku ve vitezne rade (mensi nez '|| TO_CHAR(omezeni_radek.symbol_min)|| ').';
            raise_application_error(cislo_chyby, zprava_chyby);
        
        WHEN 6 THEN
        
            cislo_chyby := -20006;
            zprava_chyby := 'Prilis velky pocet znaku ve vitezne rade (vetsi nez '|| TO_CHAR(omezeni_radek.symbol_max)|| ').';
            raise_application_error(cislo_chyby, zprava_chyby);
            
        WHEN 7 THEN
        
            cislo_chyby := -20007;
            zprava_chyby := 'Vitezna rada delsi, nez sirka papiru.';
            raise_application_error(cislo_chyby, zprava_chyby);
            
        WHEN 8 THEN
        
            cislo_chyby := -20008;
            zprava_chyby := 'Vitezna rada delsi, nez vyska papiru.';
            raise_application_error(cislo_chyby, zprava_chyby);
            
        ELSE NULL;
        
    END CASE;

END;
/

--
-- Procedura, ktera zabrani tahu, ktery neni mozno udelat.
--
CREATE OR REPLACE PROCEDURE zabran_tahu ( hra_id IN INTEGER, hrac_id IN INTEGER, 
    radek_souradnice IN INTEGER, sloupec_souradnice IN INTEGER ) AS
    
hra_radek hra%ROWTYPE;
existuje_hra_radek INTEGER := 0;
hrac_id_posledni_tah INTEGER;
existuje_hrac_id_posledni_tah INTEGER := 0;
je_pozice_obsazena INTEGER := 0;

hra_id_prom INTEGER := hra_id;
hrac_id_prom INTEGER := hrac_id;
radek_souradnice_prom INTEGER := radek_souradnice;
sloupec_souradnice_prom INTEGER := sloupec_souradnice;

cislo_chyby INTEGER;
zprava_chyby NVARCHAR2(256);
    
BEGIN

    SELECT COUNT(id) INTO existuje_hra_radek 
    FROM hra
    WHERE hra.id = hra_id_prom
        AND rownum = 1;
        
    IF existuje_hra_radek = 0 THEN
    
        cislo_chyby := -20010;
        zprava_chyby := 'Hra, do ktere se snazite umistit tah, neexistuje.';
        raise_application_error(cislo_chyby, zprava_chyby);
        
    END IF;
        
    SELECT * INTO hra_radek 
    FROM hra 
    WHERE hra.id = hra_id_prom
        AND rownum = 1;
        
        
    IF hrac_id_prom != hra_radek.hrac_id_1 AND hrac_id_prom != hra_radek.hrac_id_2 THEN
    
        cislo_chyby := -20011;
        zprava_chyby := 'Hrac se snazi realizovat tah ve hre, ve ktere nehraje.';
        raise_application_error(cislo_chyby, zprava_chyby);
        
    END IF;
        
    IF radek_souradnice_prom > hra_radek.radek_velikost OR sloupec_souradnice_prom > hra_radek.sloupec_velikost 
        OR radek_souradnice_prom < 1 OR sloupec_souradnice_prom < 1 THEN
    
        cislo_chyby := -20012;
        zprava_chyby := 'Hrac se snazi realizovat tah, ktery je mimo hraci plochu.';
        raise_application_error(cislo_chyby, zprava_chyby);
        
    END IF;
    
    IF hra_radek.stav_id != 1 THEN
    
        cislo_chyby := -20013;
        zprava_chyby := 'Hrac se snazi realizovat tah v jiz ukoncene hre.';
        raise_application_error(cislo_chyby, zprava_chyby);
        
    END IF;
    
    
    SELECT COUNT(id) INTO existuje_hrac_id_posledni_tah
    FROM tah 
    WHERE hra_id = hra_radek.id ;
    
    IF existuje_hrac_id_posledni_tah > 0 THEN
        
        SELECT t1.hrac_id INTO hrac_id_posledni_tah
        FROM tah t1
        WHERE t1.id = 
            ( SELECT MAX(t2.id) FROM tah t2 WHERE t2.hra_id = hra_radek.id );
            
        SELECT COUNT(id) INTO je_pozice_obsazena
        FROM tah
        WHERE tah.hra_id = hra_radek.id
            AND tah.radek_souradnice = radek_souradnice_prom
            AND tah.sloupec_souradnice = sloupec_souradnice_prom;
            
        IF hrac_id_posledni_tah = hrac_id_prom THEN
            
            cislo_chyby := -20014;
            zprava_chyby := 'Hrac se snazi hrat 2x za sebou. Ted je na rade oponent.';
            raise_application_error(cislo_chyby, zprava_chyby);
            
        END IF;
        
        IF je_pozice_obsazena > 0 THEN
            
            cislo_chyby := -20015;
            zprava_chyby := 'Hrac se snazi polozit svoji znacku na jiz obsazene policko ve hre.';
            raise_application_error(cislo_chyby, zprava_chyby);
            
        END IF;
    
    END IF;
    
END;
/