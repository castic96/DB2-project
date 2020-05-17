---
--- Happy day scenar - remiza - zacinajici hrac - hrac 2.
---

-- Vyprazdneni tabulky tah pro hru s id 102.
DELETE FROM tah WHERE hra_id = 102;

-- Vyprazdneni tabulky hra pro id 102.
DELETE FROM hra WHERE id = 102;

-- Vyprazdneni tabulky hrac pro id 1003 a 1004.
DELETE FROM hrac WHERE id = 1003 OR id = 1004;

-- Registrace hracu se znamymi id - 1003 a 1004.
EXEC registruj_hrace('zdenek001', 1003);
EXEC registruj_hrace('PaVel8', 1004);

-- Vytvoreni hry pro hrace s id 1003 a 1004 se znamym id - 102.
EXEC zahaj_hru(1003, 1004, 5, 5, 5, 102);

-- 1. kolo hry
EXEC proved_tah(102, 1004, 1, 1);
EXEC proved_tah(102, 1003, 1, 2);

-- 2. kolo hry
EXEC proved_tah(102, 1004, 1, 4);
EXEC proved_tah(102, 1003, 1, 3);

-- 3. kolo hry
EXEC proved_tah(102, 1004, 1, 5);
EXEC proved_tah(102, 1003, 2, 1);

-- 4. kolo hry
EXEC proved_tah(102, 1004, 2, 2);
EXEC proved_tah(102, 1003, 2, 4);

-- 5. kolo hry
EXEC proved_tah(102, 1004, 2, 3);
EXEC proved_tah(102, 1003, 2, 5);

-- 6. kolo hry
EXEC proved_tah(102, 1004, 3, 1);
EXEC proved_tah(102, 1003, 3, 2);

-- 7. kolo hry
EXEC proved_tah(102, 1004, 3, 4);
EXEC proved_tah(102, 1003, 3, 3);

-- 8. kolo hry
EXEC proved_tah(102, 1004, 3, 5);
EXEC proved_tah(102, 1003, 4, 2);

-- 9. kolo hry
EXEC proved_tah(102, 1004, 4, 1);
EXEC proved_tah(102, 1003, 4, 4);

-- 10. kolo hry
EXEC proved_tah(102, 1004, 4, 3);
EXEC proved_tah(102, 1003, 4, 5);

-- 11. kolo hry
EXEC proved_tah(102, 1004, 5, 1);
EXEC proved_tah(102, 1003, 5, 3);

-- 12. kolo hry
EXEC proved_tah(102, 1004, 5, 2);
EXEC proved_tah(102, 1003, 5, 5);

-- 13. kolo hry
EXEC proved_tah(102, 1004, 5, 4);

-- Zobrazeni pohledu remizy.
SELECT * FROM remizy;