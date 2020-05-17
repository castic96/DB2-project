---
--- Happy day scenar - vyhra zacinajiciho - hrac 2.
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
EXEC zahaj_hru(1003, 1004, 20, 20, 5, 102);

-- 1. kolo hry
EXEC proved_tah(102, 1004, 4, 4);
EXEC proved_tah(102, 1003, 7, 4);

-- 2. kolo hry
EXEC proved_tah(102, 1004, 6, 4);
EXEC proved_tah(102, 1003, 9, 6);

-- 3. kolo hry
EXEC proved_tah(102, 1004, 8, 5);
EXEC proved_tah(102, 1003, 5, 5);

-- 4. kolo hry
EXEC proved_tah(102, 1004, 7, 6);
EXEC proved_tah(102, 1003, 4, 6);

-- 5. kolo hry
EXEC proved_tah(102, 1004, 6, 7);
EXEC proved_tah(102, 1003, 3, 7);

-- 6. kolo hry
EXEC proved_tah(102, 1004, 5, 8);
EXEC proved_tah(102, 1003, 4, 9);

-- 7. kolo hry
EXEC proved_tah(102, 1004, 9, 4);

-- Zobrazeni pohledu vyhry_zacinajici.
SELECT * FROM vyhry_zacinajici;