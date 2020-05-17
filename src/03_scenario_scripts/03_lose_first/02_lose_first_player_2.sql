---
--- Happy day scenar - prohra zacinajiciho - hrac 2.
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
EXEC proved_tah(102, 1004, 15, 20);
EXEC proved_tah(102, 1003, 16, 17);

-- 2. kolo hry
EXEC proved_tah(102, 1004, 17, 16);
EXEC proved_tah(102, 1003, 16, 20);

-- 3. kolo hry
EXEC proved_tah(102, 1004, 18, 16);
EXEC proved_tah(102, 1003, 17, 19);

-- 4. kolo hry
EXEC proved_tah(102, 1004, 17, 20);
EXEC proved_tah(102, 1003, 18, 18);

-- 5. kolo hry
EXEC proved_tah(102, 1004, 18, 19);
EXEC proved_tah(102, 1003, 19, 17);

-- 6. kolo hry
EXEC proved_tah(102, 1004, 19, 18);
EXEC proved_tah(102, 1003, 20, 16);

-- Zobrazeni pohledu prohry_zacinajici.
SELECT * FROM prohry_zacinajici;