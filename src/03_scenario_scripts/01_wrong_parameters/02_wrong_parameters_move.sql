---
--- Scenar pro kontrolu spatnych parametru tahu.
---

-- Vyprazdneni tabulky tah pro hry s id 101, 102, 103.
DELETE FROM tah WHERE hra_id = 101 OR hra_id = 102 OR hra_id = 103;

-- Vyprazdneni tabulky hra pro id 101, 102, 103.
DELETE FROM hra WHERE id = 101 OR id = 102 OR id = 103;

-- Vyprazdneni tabulky hrac pro id 1001, 1002, 1003 a 1004.
DELETE FROM hrac WHERE id = 1001 OR id = 1002 OR id = 1003 OR id = 1004;

-- Registrace hracu se znamymi id - 1001, 1002, 1003, 1004.
EXEC registruj_hrace('petr23', 1001);
EXEC registruj_hrace('Martin18', 1002);
EXEC registruj_hrace('zdenek001', 1003);
EXEC registruj_hrace('PaVel8', 1004);

-- Vytvoreni hry pro hrace s id 1001 a 1002 se znamym id - 101.
EXEC zahaj_hru(1001, 1002, 10, 10, 5, 101);

-- Vytvoreni hry pro hrace s id 1003 a 1004 se znamym id - 102.
EXEC zahaj_hru(1003, 1004, 20, 20, 5, 102);

-- Pokus o provedeni tahu hrace 1001 do neexistujici hry.
EXEC proved_tah(103, 1001, 1, 1);

-- Pokus o provedeni tahu hrace 1001 do hry 102, ve ktere nehraje.
EXEC proved_tah(102, 1001, 1, 1);

-- Pokus o provedeni tahu hrace 1001 do hry 101 mimo hraci plochu.
EXEC proved_tah(101, 1001, 11, 5);

-- Ukonceni hry 102
UPDATE hra
SET stav_id = 2
WHERE id = 102;

-- Pokus o provedeni tahu hrace 1003 do hry 102, ktera je jiz ukoncena.
EXEC proved_tah(102, 1003, 5, 5);

-- Provedeni tahu hrace 1001 do hry 101 - korektni.
EXEC proved_tah(101, 1001, 10, 5);

-- Pokus o provedeni tahu hrace 1001 do hry 101 - 2x za sebou.
EXEC proved_tah(101, 1001, 9, 5);

-- Pokus o provedeni tahu hrace 1002 do hry 101 na jiz obsazene policko.
EXEC proved_tah(101, 1002, 10, 5);
