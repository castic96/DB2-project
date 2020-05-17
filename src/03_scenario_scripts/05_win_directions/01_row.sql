---
--- Vyhra - smer: radek.
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
EXEC proved_tah(101, 1001, 4, 5);
EXEC proved_tah(101, 1002, 4, 3);

-- 2. kolo hry
EXEC proved_tah(101, 1001, 5, 5);
EXEC proved_tah(101, 1002, 4, 4);

-- 3. kolo hry
EXEC proved_tah(101, 1001, 6, 6);
EXEC proved_tah(101, 1002, 6, 5);

-- 4. kolo hry
EXEC proved_tah(101, 1001, 6, 7);
EXEC proved_tah(101, 1002, 5, 7);

-- 5. kolo hry
EXEC proved_tah(101, 1001, 6, 8);
EXEC proved_tah(101, 1002, 4, 8);

-- 6. kolo hry
EXEC proved_tah(101, 1001, 6, 9);
EXEC proved_tah(101, 1002, 7, 7);

-- 7. kolo hry
EXEC proved_tah(101, 1001, 6, 10);

-- Zobrazeni id stavu - kontrola, zda hra skoncila.
SELECT h.stav_id 
FROM hra h
WHERE h.id = 101;