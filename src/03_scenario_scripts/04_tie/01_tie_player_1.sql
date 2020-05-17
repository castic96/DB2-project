---
--- Happy day scenar - remiza - zacinajici hrac - hrac 1.
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
EXEC zahaj_hru(1001, 1002, 5, 5, 5, 101);

-- 1. kolo hry
EXEC proved_tah(101, 1001, 1, 1);
EXEC proved_tah(101, 1002, 1, 2);

-- 2. kolo hry
EXEC proved_tah(101, 1001, 1, 4);
EXEC proved_tah(101, 1002, 1, 3);

-- 3. kolo hry
EXEC proved_tah(101, 1001, 1, 5);
EXEC proved_tah(101, 1002, 2, 1);

-- 4. kolo hry
EXEC proved_tah(101, 1001, 2, 2);
EXEC proved_tah(101, 1002, 2, 4);

-- 5. kolo hry
EXEC proved_tah(101, 1001, 2, 3);
EXEC proved_tah(101, 1002, 2, 5);

-- 6. kolo hry
EXEC proved_tah(101, 1001, 3, 1);
EXEC proved_tah(101, 1002, 3, 2);

-- 7. kolo hry
EXEC proved_tah(101, 1001, 3, 4);
EXEC proved_tah(101, 1002, 3, 3);

-- 8. kolo hry
EXEC proved_tah(101, 1001, 3, 5);
EXEC proved_tah(101, 1002, 4, 2);

-- 9. kolo hry
EXEC proved_tah(101, 1001, 4, 1);
EXEC proved_tah(101, 1002, 4, 4);

-- 10. kolo hry
EXEC proved_tah(101, 1001, 4, 3);
EXEC proved_tah(101, 1002, 4, 5);

-- 11. kolo hry
EXEC proved_tah(101, 1001, 5, 1);
EXEC proved_tah(101, 1002, 5, 3);

-- 12. kolo hry
EXEC proved_tah(101, 1001, 5, 2);
EXEC proved_tah(101, 1002, 5, 5);

-- 13. kolo hry
EXEC proved_tah(101, 1001, 5, 4);

-- Zobrazeni pohledu remizy.
SELECT * FROM remizy;