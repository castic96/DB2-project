---
--- Vyhra - smer: diagonala - levo dole -> pravo nahore - nad.
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
EXEC proved_tah(101, 1001, 4, 4);
EXEC proved_tah(101, 1002, 7, 4);

-- 2. kolo hry
EXEC proved_tah(101, 1001, 6, 4);
EXEC proved_tah(101, 1002, 9, 6);

-- 3. kolo hry
EXEC proved_tah(101, 1001, 8, 5);
EXEC proved_tah(101, 1002, 5, 5);

-- 4. kolo hry
EXEC proved_tah(101, 1001, 7, 6);
EXEC proved_tah(101, 1002, 4, 6);

-- 5. kolo hry
EXEC proved_tah(101, 1001, 6, 7);
EXEC proved_tah(101, 1002, 3, 7);

-- 6. kolo hry
EXEC proved_tah(101, 1001, 5, 8);
EXEC proved_tah(101, 1002, 4, 9);

-- 7. kolo hry
EXEC proved_tah(101, 1001, 9, 4);

-- Zobrazeni id stavu - kontrola, zda hra skoncila.
SELECT h.stav_id 
FROM hra h
WHERE h.id = 101;