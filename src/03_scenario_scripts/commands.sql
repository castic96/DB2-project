---
--- Registrace hracu se znamymi id - 1001, 1002.
---
EXEC registruj_hrace('honza001', 1001);
EXEC registruj_hrace('pavel96', 1002);

---
--- Vytvoreni hry pro hrace s id 1001 a 1002 se znamym id - 101.
---
EXEC zahaj_hru(1001, 1002, 15, 15, 5, 101);

---
--- Hrac 1001 provede tah ve hre 101 na pozici 5,4.
---
EXEC proved_tah(101, 1001, 5, 4);

---
--- Zobrazeni papiru pro aktualni hru.
---
SELECT * FROM papir;