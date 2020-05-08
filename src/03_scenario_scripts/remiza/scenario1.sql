---
--- Vyprazdneni tabulky tah pro hry s id 103.
---
DELETE FROM tah WHERE hra_id = 103;

---
--- Vyprazdneni tabulky hra pro id 103.
---
DELETE FROM hra WHERE id = 103;

---
--- Vyprazdneni tabulky hrac pro id 1003 a 1004.
---
DELETE FROM hrac WHERE id = 1003 OR id = 1004;

---
--- Registrace hracu se znamymi id - 1003, 1004.
---
EXEC registruj_hrace('petr23', 1003);
EXEC registruj_hrace('Martin18', 1004);

---
--- Vytvoreni hry pro hrace s id 1003 a 1004 se znamym id - 103.
---
EXEC zahaj_hru(1003, 1004, 3, 5, 3, 103);

---
--- Provedeni tahu.
---
--- 1. kolo
EXEC proved_tah(103, 1003, 1, 1);
EXEC vytiskni_boolean(vyhra(103, 1003));
EXEC vytiskni_boolean(remiza(103));
EXEC proved_tah(103, 1004, 1, 2);
EXEC vytiskni_boolean(vyhra(103, 1004));
EXEC vytiskni_boolean(remiza(103));

--- 2. kolo
EXEC proved_tah(103, 1003, 1, 4);
EXEC vytiskni_boolean(vyhra(103, 1003));
EXEC vytiskni_boolean(remiza(103));
EXEC proved_tah(103, 1004, 1, 3);
EXEC vytiskni_boolean(vyhra(103, 1004));
EXEC vytiskni_boolean(remiza(103));

--- 3. kolo
EXEC proved_tah(103, 1003, 1, 5);
EXEC vytiskni_boolean(vyhra(103, 1003));
EXEC vytiskni_boolean(remiza(103));
EXEC proved_tah(103, 1004, 2, 1);
EXEC vytiskni_boolean(vyhra(103, 1004));
EXEC vytiskni_boolean(remiza(103));

--- 4. kolo
EXEC proved_tah(103, 1003, 2, 2);
EXEC vytiskni_boolean(vyhra(103, 1003));
EXEC vytiskni_boolean(remiza(103));
EXEC proved_tah(103, 1004, 2, 4);
EXEC vytiskni_boolean(vyhra(103, 1004));
EXEC vytiskni_boolean(remiza(103));

--- 5. kolo
EXEC proved_tah(103, 1003, 2, 3);
EXEC vytiskni_boolean(vyhra(103, 1003));
EXEC vytiskni_boolean(remiza(103));
EXEC proved_tah(103, 1004, 2, 5);
EXEC vytiskni_boolean(vyhra(103, 1004));
EXEC vytiskni_boolean(remiza(103));

--- 6. kolo
EXEC proved_tah(103, 1003, 3, 1);
EXEC vytiskni_boolean(vyhra(103, 1003));
EXEC vytiskni_boolean(remiza(103));
EXEC proved_tah(103, 1004, 3, 2);
EXEC vytiskni_boolean(vyhra(103, 1004));
EXEC vytiskni_boolean(remiza(103));

--- 7. kolo
EXEC proved_tah(103, 1003, 3, 4);
EXEC vytiskni_boolean(vyhra(103, 1003));
EXEC vytiskni_boolean(remiza(103));
EXEC proved_tah(103, 1004, 3, 3);
EXEC vytiskni_boolean(vyhra(103, 1004));
EXEC vytiskni_boolean(remiza(103));

--- 8. kolo
EXEC proved_tah(103, 1003, 3, 5);
EXEC vytiskni_boolean(vyhra(103, 1003));
EXEC vytiskni_boolean(remiza(103));