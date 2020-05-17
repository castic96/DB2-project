---
--- Vyhra - smer: diagonala - levo nahore -> pravo dole - pod.
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
EXEC proved_tah(101, 1001, 17, 4);
EXEC proved_tah(101, 1002, 17, 2);

-- 2. kolo hry
EXEC proved_tah(101, 1001, 19, 1);
EXEC proved_tah(101, 1002, 15, 1);

-- 3. kolo hry
EXEC proved_tah(101, 1001, 20, 2);
EXEC proved_tah(101, 1002, 16, 1);

-- 4. kolo hry
EXEC proved_tah(101, 1001, 19, 5);
EXEC proved_tah(101, 1002, 18, 3);

-- 5. kolo hry
EXEC proved_tah(101, 1001, 20, 3);
EXEC proved_tah(101, 1002, 19, 4);

-- 6. kolo hry
EXEC proved_tah(101, 1001, 20, 4);
EXEC proved_tah(101, 1002, 20, 5);

-- Zobrazeni id stavu - kontrola, zda hra skoncila.
SELECT h.stav_id 
FROM hra h
WHERE h.id = 101;