---
--- Vyhra - smer: diagonala - levo dole -> pravo nahore - pod.
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
EXEC proved_tah(101, 1001, 15, 20);
EXEC proved_tah(101, 1002, 16, 17);

-- 2. kolo hry
EXEC proved_tah(101, 1001, 17, 16);
EXEC proved_tah(101, 1002, 16, 20);

-- 3. kolo hry
EXEC proved_tah(101, 1001, 18, 16);
EXEC proved_tah(101, 1002, 17, 19);

-- 4. kolo hry
EXEC proved_tah(101, 1001, 17, 20);
EXEC proved_tah(101, 1002, 18, 18);

-- 5. kolo hry
EXEC proved_tah(101, 1001, 18, 19);
EXEC proved_tah(101, 1002, 19, 17);

-- 6. kolo hry
EXEC proved_tah(101, 1001, 19, 18);
EXEC proved_tah(101, 1002, 20, 16);

-- Zobrazeni id stavu - kontrola, zda hra skoncila.
SELECT h.stav_id 
FROM hra h
WHERE h.id = 101;