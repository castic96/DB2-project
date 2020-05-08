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

--
-- Funkce, ktera vraci TRUE, pokud prave hrajici hrac v dane hre vyhral, jinak vraci FALSE.
--
CREATE OR REPLACE FUNCTION vyhra ( hra_id IN INTEGER, hrac_id IN INTEGER ) RETURN BOOLEAN AS

hra_radek hra%ROWTYPE;
pocet_symbolu INTEGER := 0;
posledni_index INTEGER := -1;
existuje_tah_radek INTEGER := 0;
hrac_id_prom INTEGER := hrac_id;

CURSOR tah_radek_kurzor ( hra_id_kurzor IN INTEGER, hrac_id_kurzor IN INTEGER, cislo_radku_kurzor IN INTEGER ) IS
    SELECT * 
    FROM tah
    WHERE tah.hra_id = hra_id_kurzor 
        AND tah.hrac_id = hrac_id_kurzor
        AND tah.radek_souradnice = cislo_radku_kurzor
    ORDER BY tah.sloupec_souradnice;
    
CURSOR tah_sloupec_kurzor ( hra_id_kurzor IN INTEGER, hrac_id_kurzor IN INTEGER, cislo_sloupce_kurzor IN INTEGER ) IS
    SELECT * 
    FROM tah
    WHERE tah.hra_id = hra_id_kurzor 
        AND tah.hrac_id = hrac_id_kurzor
        AND tah.sloupec_souradnice = cislo_sloupce_kurzor
    ORDER BY tah.radek_souradnice;   

BEGIN

    SELECT * INTO hra_radek 
    FROM hra 
    WHERE hra.id = hra_id
        AND rownum = 1;
    
    -- RADKY
    FOR aktualni_radek IN 1..hra_radek.radek_velikost LOOP
        
        pocet_symbolu := 0;
        posledni_index := -1;
        
        FOR tah_radek IN tah_radek_kurzor ( hra_id, hrac_id, aktualni_radek ) LOOP
            
            IF posledni_index = -1 THEN
                pocet_symbolu := 1;
                posledni_index := tah_radek.sloupec_souradnice;
            ELSE
                IF posledni_index = tah_radek.sloupec_souradnice - 1 THEN
                    pocet_symbolu := pocet_symbolu + 1;
                    posledni_index := tah_radek.sloupec_souradnice;
                    
                    IF pocet_symbolu >= hra_radek.symbol_velikost THEN
                        RETURN TRUE;
                    END IF;
                    
                ELSE
                    pocet_symbolu := 1;
                    posledni_index := tah_radek.sloupec_souradnice;
                END IF;
            END IF;
            
        END LOOP;
        
    END LOOP;
    
    -- SLOUPCE
    FOR aktualni_sloupec IN 1..hra_radek.sloupec_velikost LOOP
        
        pocet_symbolu := 0;
        posledni_index := -1;
        
        FOR tah_radek IN tah_sloupec_kurzor ( hra_id, hrac_id, aktualni_sloupec ) LOOP
            
            IF posledni_index = -1 THEN
                pocet_symbolu := 1;
                posledni_index := tah_radek.radek_souradnice;
            ELSE
                IF posledni_index = tah_radek.radek_souradnice - 1 THEN
                    pocet_symbolu := pocet_symbolu + 1;
                    posledni_index := tah_radek.radek_souradnice;
                    
                    IF pocet_symbolu >= hra_radek.symbol_velikost THEN
                        RETURN TRUE;
                    END IF;
                    
                ELSE
                    pocet_symbolu := 1;
                    posledni_index := tah_radek.radek_souradnice;
                END IF;
            END IF;
            
        END LOOP;
        
    END LOOP;
    
    -- DIAGONÁLY - LEVO DOLE -> PRAVO NAHOŘE
    -- NAD DIAGONÁLOU
    FOR aktualni_radek IN 0..hra_radek.radek_velikost LOOP
        
        pocet_symbolu := 0;
        
        FOR krok in 0..hra_radek.sloupec_velikost LOOP --edit
        
            IF (hra_radek.radek_velikost - krok - aktualni_radek) < 0 THEN
                EXIT;
            END IF;
            
            SELECT COUNT(ID) INTO existuje_tah_radek 
            FROM tah
            WHERE tah.hra_id = hra_radek.id
                AND tah.hrac_id = hrac_id_prom
                AND tah.radek_souradnice = (hra_radek.radek_velikost - krok - aktualni_radek)
                AND tah.sloupec_souradnice = krok
                AND rownum = 1;
                
            IF existuje_tah_radek = 1 THEN 
            
                pocet_symbolu := pocet_symbolu + 1;
                
                IF pocet_symbolu >= hra_radek.symbol_velikost THEN
                    RETURN TRUE;
                END IF;
                
            ELSE
            
                pocet_symbolu := 0;
                
            END IF;
            
        END LOOP;
        
    END LOOP;  
    
    -- POD DIAGONÁLOU
    FOR aktualni_sloupec IN 1..hra_radek.sloupec_velikost LOOP --edit
        
        pocet_symbolu := 0;
        
        FOR krok in 0..hra_radek.radek_velikost LOOP
        
            IF (krok + aktualni_sloupec) > hra_radek.sloupec_velikost THEN
                EXIT;
            END IF;
            
            SELECT COUNT(ID) INTO existuje_tah_radek
            FROM tah 
            WHERE tah.hra_id = hra_radek.id
                AND tah.hrac_id = hrac_id_prom
                AND tah.radek_souradnice = (hra_radek.radek_velikost - krok)
                AND tah.sloupec_souradnice = (krok + aktualni_sloupec)
                AND rownum = 1;
                
            IF existuje_tah_radek = 1 THEN
            
                pocet_symbolu := pocet_symbolu + 1;
                
                IF pocet_symbolu >= hra_radek.symbol_velikost THEN
                    RETURN TRUE;
                END IF;
                
            ELSE
            
                pocet_symbolu := 0;
                
            END IF;
            
        END LOOP;
        
    END LOOP;
    
    -- DIAGONÁLY - LEVO NAHOŘE -> PRAVO DOLE
    -- NAD DIAGONÁLOU
    FOR aktualni_sloupec IN 1..hra_radek.sloupec_velikost LOOP --edit
        
        pocet_symbolu := 0;
        
        FOR krok in 0..hra_radek.radek_velikost LOOP
        
            IF (aktualni_sloupec + krok) > hra_radek.sloupec_velikost THEN
               EXIT;
            END IF;
            
            SELECT COUNT(ID) INTO existuje_tah_radek
            FROM tah 
            WHERE tah.hra_id = hra_radek.id
                AND tah.hrac_id = hrac_id_prom
                AND tah.radek_souradnice = krok
                AND tah.sloupec_souradnice = (aktualni_sloupec + krok)
                AND rownum = 1;
                
            IF existuje_tah_radek = 1 THEN
            
                pocet_symbolu := pocet_symbolu + 1;
                
                IF pocet_symbolu >= hra_radek.symbol_velikost THEN
                    RETURN TRUE;
                END IF;
                
            ELSE
            
                pocet_symbolu := 0;
                
            END IF;
            
        END LOOP;
        
    END LOOP;
    
    -- POD DIAGONÁLOU
    FOR aktualni_radek IN 1..hra_radek.radek_velikost LOOP
        
        pocet_symbolu := 0;
        
        FOR krok in 0..hra_radek.sloupec_velikost LOOP --edit
        
            IF(aktualni_radek + krok) > hra_radek.radek_velikost THEN
                EXIT;
            END IF;
            
            SELECT COUNT(ID) INTO existuje_tah_radek
            FROM tah 
            WHERE tah.hra_id = hra_radek.id
                AND tah.hrac_id = hrac_id_prom
                AND tah.radek_souradnice = (aktualni_radek + krok)
                AND tah.sloupec_souradnice = krok
                AND rownum = 1;
                
            IF existuje_tah_radek = 1 THEN
            
                pocet_symbolu := pocet_symbolu + 1;
                
                IF pocet_symbolu >= hra_radek.symbol_velikost THEN
                    RETURN TRUE;
                END IF;
                
            ELSE
            
                pocet_symbolu := 0;
                
            END IF;
            
        END LOOP;
        
    END LOOP;
    
    RETURN FALSE;

END;
/