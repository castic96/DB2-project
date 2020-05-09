--
-- Trigger, ktery hlida a vyhodnoti stav hry, tj. zda nedospela do remizy nebo vitezneho stavu
-- jednoho z hracu.
--
CREATE OR REPLACE TRIGGER vyhodnot_stav_hry
    FOR INSERT ON tah
    COMPOUND TRIGGER
    
    hra_id_prom INTEGER;
    hrac_id_prom INTEGER;
    
    AFTER EACH ROW IS
    BEGIN
    
        hra_id_prom := :new.hra_id;
        hrac_id_prom := :new.hrac_id;
        
    END AFTER EACH ROW;
    
    AFTER STATEMENT IS
    BEGIN
    
        IF vyhra ( hra_id_prom, hrac_id_prom ) THEN
            konec_hry ( hra_id_prom, hrac_id_prom );
            aktualizuj_stav_hry ( hra_id_prom, hrac_id_prom );
            statistiky ( hra_id_prom );
        END IF;
    
        IF remiza ( hra_id_prom ) THEN
            konec_hry ( hra_id_prom, hrac_id_prom );
            aktualizuj_stav_hry ( hra_id_prom );
            statistiky ( hra_id_prom );
        END IF;
    
    END AFTER STATEMENT;

    
END vyhodnot_stav_hry;
/

--
-- Trigger, ktery hlida parametry nove hry pri vytvoreni, jestli splnuji dana omezeni.
--
CREATE OR REPLACE TRIGGER zkontroluj_parametry_hry
    BEFORE INSERT ON hra
    FOR EACH ROW
    
BEGIN
    
    zabran_hre ( :new.radek_velikost, :new.sloupec_velikost, :new.symbol_velikost );
    
END;
/

--
-- Trigger, ktery hlida tah hrace, aby byl jeho tah platny.
--
CREATE OR REPLACE TRIGGER zkontroluj_tah_hrace
    BEFORE INSERT ON tah
    FOR EACH ROW
    
BEGIN
    
    zabran_tahu ( :new.hra_id, :new.hrac_id, :new.radek_souradnice, :new.sloupec_souradnice );
    
END;
/