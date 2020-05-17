--
-- Tento pohled zobrazi ctvereckovany papir obsahujici vsechny dosud provedené tahy probihajici hry.
--
CREATE OR REPLACE VIEW papir AS
    SELECT vykresli_papir(101) AS "Papír"
    FROM dual;

--
-- Tento pohled zobrazi hry, ve kterych zvitezil zacinajici hrac.
--
CREATE OR REPLACE VIEW vyhry_zacinajici AS
    SELECT
        h.radek_velikost AS "Počet řádků",
        
        h.sloupec_velikost AS "Počet sloupců",
        
        h.symbol_velikost AS "Počet výherních symbolů",
        
        hrac1.prezdivka AS "Hráč 1",
        
        hrac2.prezdivka AS "Hráč 2",
        
        CASE
            WHEN
                (   (   
                        SELECT t1.hrac_id
                        FROM tah t1
                        WHERE t1.id = 
                            ( SELECT MIN(t2.id) FROM tah t2 WHERE t2.hra_id = h.id )
                    ) = hrac1.id
                 )
            THEN
                hrac1.prezdivka
            ELSE
                hrac2.prezdivka
        END AS "Začínal (zvítězil)",
        
        'O' AS "Hráč 1 - symbol",
        
        'X' AS "Hráč 2 - symbol",

        h.cas_hrac_1 + h.cas_hrac_2 AS "Trvání hry",
        
        (   
            SELECT COUNT(t.id)
            FROM tah t
            WHERE t.hra_id = h.id
        ) AS "Počet tahů"
        
    FROM hra h
        INNER JOIN hrac hrac1 ON hrac1.id = h.hrac_id_1
        INNER JOIN hrac hrac2 ON hrac2.id = h.hrac_id_2
    WHERE h.stav_id = 2;

--
-- Tento pohled zobrazi hry, ve kterych prohral zacinajici hrac.
--
CREATE OR REPLACE VIEW prohry_zacinajici AS
    SELECT
        h.radek_velikost AS "Počet řádků",
        
        h.sloupec_velikost AS "Počet sloupců",
        
        h.symbol_velikost AS "Počet výherních symbolů",
        
        hrac1.prezdivka AS "Hráč 1",
        
        hrac2.prezdivka AS "Hráč 2",
        
        CASE
            WHEN
                (   (   
                        SELECT t1.hrac_id
                        FROM tah t1
                        WHERE t1.id = 
                            ( SELECT MIN(t2.id) FROM tah t2 WHERE t2.hra_id = h.id )
                    ) = hrac1.id
                 )
            THEN
                hrac1.prezdivka
            ELSE
                hrac2.prezdivka
        END AS "Začínal (prohrál)",
        
        'O' AS "Hráč 1 - symbol",
        
        'X' AS "Hráč 2 - symbol",

        h.cas_hrac_1 + h.cas_hrac_2 AS "Trvání hry",
        
        (   
            SELECT COUNT(t.id)
            FROM tah t
            WHERE t.hra_id = h.id
        ) AS "Počet tahů"
        
    FROM hra h
        INNER JOIN hrac hrac1 ON hrac1.id = h.hrac_id_1
        INNER JOIN hrac hrac2 ON hrac2.id = h.hrac_id_2
    WHERE h.stav_id = 3;
	
--
-- Tento pohled zobrazi hry, ktere dospely do remizy.
--
CREATE OR REPLACE VIEW remizy AS
    SELECT
        h.radek_velikost AS "Počet řádků",
        
        h.sloupec_velikost AS "Počet sloupců",
        
        h.symbol_velikost AS "Počet výherních symbolů",
        
        hrac1.prezdivka AS "Hráč 1",
        
        hrac2.prezdivka AS "Hráč 2",
        
        CASE
            WHEN
                (   (   
                        SELECT t1.hrac_id
                        FROM tah t1
                        WHERE t1.id = 
                            ( SELECT MIN(t2.id) FROM tah t2 WHERE t2.hra_id = h.id )
                    ) = hrac1.id
                 )
            THEN
                hrac1.prezdivka
            ELSE
                hrac2.prezdivka
        END AS "Začínal",
        
        'O' AS "Hráč 1 - symbol",
        
        'X' AS "Hráč 2 - symbol",

        h.cas_hrac_1 + h.cas_hrac_2 AS "Trvání hry",
        
        (   
            SELECT COUNT(t.id)
            FROM tah t
            WHERE t.hra_id = h.id
        ) AS "Počet tahů"
        
    FROM hra h
        INNER JOIN hrac hrac1 ON hrac1.id = h.hrac_id_1
        INNER JOIN hrac hrac2 ON hrac2.id = h.hrac_id_2
    WHERE h.stav_id = 4;    
    