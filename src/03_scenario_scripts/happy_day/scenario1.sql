TRUNCATE TABLE tah;

--- 1. kolo
EXEC proved_tah(101, 1001, 4, 5);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 4, 3);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 2. kolo
EXEC proved_tah(101, 1001, 5, 5);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 4, 4);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 3. kolo
EXEC proved_tah(101, 1001, 6, 6);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 6, 5);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 4. kolo
EXEC proved_tah(101, 1001, 6, 7);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 5, 7);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 5. kolo
EXEC proved_tah(101, 1001, 6, 8);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 4, 8);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 6. kolo
EXEC proved_tah(101, 1001, 6, 9);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 7, 7);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 7. kolo
EXEC proved_tah(101, 1001, 6, 10);
EXEC vytiskni_boolean(vyhra(101, 1001));
-- nemel by byto proveden
EXEC proved_tah(101, 1002, 7, 3);
EXEC vytiskni_boolean(vyhra(101, 1002));