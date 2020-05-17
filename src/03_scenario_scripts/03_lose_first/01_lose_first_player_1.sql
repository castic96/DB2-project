---
--- Happy day scenar - prohra zacinajiciho - hrac 1.
---

-- Vyprazdneni tabulky tah pro hru s id 101.
DELETE FROM tah WHERE hra_id = 101;

-- Vyprazdneni tabulky hra pro id 101.
DELETE FROM hra WHERE id = 101;

-- Vyprazdneni tabulky hrac pro id 1001 a 1002.
DELETE FROM hrac WHERE id = 1001 OR id = 1002;

-- Registrace hracu se znamymi id - 1001 a 1002.
EXEC registruj_hrace('petr23', 1001);
EXEC registruj_hrace('Martin18', 1002);

-- Vytvoreni hry pro hrace s id 1001 a 1002 se znamym id - 101.
EXEC zahaj_hru(1001, 1002, 20, 20, 5, 101);

-- 1. kolo hry
EXEC proved_tah(101, 1001, 10, 5);
EXEC proved_tah(101, 1002, 13, 7);

-- 2. kolo hry
EXEC proved_tah(101, 1001, 8, 9);
EXEC proved_tah(101, 1002, 9, 9);

-- 3. kolo hry
EXEC proved_tah(101, 1001, 10, 8);
EXEC proved_tah(101, 1002, 10, 9);

-- 4. kolo hry
EXEC proved_tah(101, 1001, 11, 7);
EXEC proved_tah(101, 1002, 11, 9);

-- 5. kolo hry
EXEC proved_tah(101, 1001, 12, 6);
EXEC proved_tah(101, 1002, 12, 9);

-- 6. kolo hry
EXEC proved_tah(101, 1001, 12, 8);
EXEC proved_tah(101, 1002, 13, 9);

-- Zobrazeni pohledu prohry_zacinajici.
SELECT * FROM prohry_zacinajici;