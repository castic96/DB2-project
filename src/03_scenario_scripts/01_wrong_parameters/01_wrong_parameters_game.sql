---
--- Scenar pro kontrolu spatnych parametru hry.
---

-- Vyprazdneni tabulky hra pro id 101.
DELETE FROM hra WHERE id = 101;

-- Vyprazdneni tabulky hrac pro id 1001 a 1002.
DELETE FROM hrac WHERE id = 1001 OR id = 1002;

-- Registrace hracu se znamymi id - 1001, 1002.
EXEC registruj_hrace('petr23', 1001);
EXEC registruj_hrace('Martin18', 1002);

-- Pokus o vytvoreni hry pro hrace s id 1001 a 1002 se znamym id - 101.
-- Prilis maly pocet radku na papiru.
EXEC zahaj_hru(1001, 1002, 3, 10, 5, 101);

-- Prilis velky pocet radku na papiru.
EXEC zahaj_hru(1001, 1002, 25, 10, 5, 101);

-- Prilis maly pocet sloupcu na papiru.
EXEC zahaj_hru(1001, 1002, 10, 1, 5, 101);

-- Prilis velky pocet sloupcu na papiru.
EXEC zahaj_hru(1001, 1002, 10, 30, 5, 101);

-- Prilis maly pocet znaku ve vitezne rade.
EXEC zahaj_hru(1001, 1002, 10, 10, 2, 101);

-- Prilis velky pocet znaku ve vitezne rade.
EXEC zahaj_hru(1001, 1002, 20, 20, 16, 101);

-- Vitezna rada delsi, nez sirka papiru.
EXEC zahaj_hru(1001, 1002, 19, 10, 11, 101);

-- Vitezna rada delsi, nez vyska papiru.
EXEC zahaj_hru(1001, 1002, 10, 19, 11, 101);
