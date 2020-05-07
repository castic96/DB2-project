--
-- Tento pohled zobrazi ctvereckovany papir obsahujici vsechny dosud provedené tahy probihajici hry.
--
CREATE OR REPLACE VIEW papir AS
    SELECT vykresli_papir(101) AS "Papír"
    FROM dual;
    