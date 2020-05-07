--
-- Funkce, ktera vraci retezec odpovidajici konkretnimu radku papiru dane hry.
--
CREATE OR REPLACE FUNCTION radek_papiru ( hra_id IN INTEGER, cislo_radku IN NUMBER ) RETURN NVARCHAR2 AS

hra_radek hra%ROWTYPE;
radek_vypis NVARCHAR2(100) := '';
aktualni_sloupec INTEGER := 1;

CURSOR tah_kurzor ( hra_id_kurzor IN INTEGER, cislo_radku_kurzor IN INTEGER ) IS
    SELECT * 
    FROM tah
    WHERE tah.hra_id = hra_id_kurzor 
        AND tah.radek_souradnice = cislo_radku_kurzor
    ORDER BY tah.sloupec_souradnice;    

BEGIN

    SELECT * INTO hra_radek 
    FROM hra 
    WHERE hra.id = hra_id
        AND rownum = 1;
    
    FOR tah_radek IN tah_kurzor ( hra_id, cislo_radku ) LOOP
        
        WHILE aktualni_sloupec < tah_radek.sloupec_souradnice LOOP
            radek_vypis := radek_vypis|| '|   ';
            aktualni_sloupec := aktualni_sloupec + 1;
        END LOOP;
        
        IF tah_radek.hrac_id = hra_radek.hrac_id_1 THEN
            radek_vypis := radek_vypis|| '| O ';
        END IF;
        
        IF tah_radek.hrac_id = hra_radek.hrac_id_2 THEN
            radek_vypis := radek_vypis|| '| X ';
        END IF;
        
        aktualni_sloupec := aktualni_sloupec + 1;
        
    END LOOP;
    
    WHILE aktualni_sloupec <= hra_radek.sloupec_velikost LOOP
        radek_vypis := radek_vypis|| '|   ';
        aktualni_sloupec := aktualni_sloupec + 1;
    END LOOP;
    
    radek_vypis := radek_vypis|| '|';
    
    RETURN radek_vypis;

END;
/

--
-- Funkce, ktera vykresli papir - vraci retezec odpovidajici vsem radkum papiru dane hry.
--
CREATE OR REPLACE FUNCTION vykresli_papir ( hra_id IN INTEGER ) RETURN NVARCHAR2 AS

hra_radek hra%ROWTYPE;
papir_vypis NVARCHAR2(2100) := '';   

BEGIN

    SELECT * INTO hra_radek 
    FROM hra 
    WHERE hra.id = hra_id
        AND rownum = 1;

    FOR aktualni_radek IN 1..hra_radek.radek_velikost LOOP
        papir_vypis := papir_vypis|| radek_papiru ( hra_id, aktualni_radek )|| chr(10);
    END LOOP;
    
    RETURN papir_vypis;

END;
/

