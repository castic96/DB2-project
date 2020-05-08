TRUNCATE TABLE tah;

--- 1. kolo
EXEC proved_tah(101, 1001, 1, 16);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 3, 15);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 2. kolo
EXEC proved_tah(101, 1001, 4, 15);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 4, 16);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 3. kolo
EXEC proved_tah(101, 1001, 6, 17);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 6, 18);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 4. kolo
EXEC proved_tah(101, 1001, 2, 17);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 3, 16);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 5. kolo
EXEC proved_tah(101, 1001, 3, 18);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 3, 17);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 6. kolo
EXEC proved_tah(101, 1001, 4, 19);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 5, 17);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 7. kolo
EXEC proved_tah(101, 1001, 5, 20);
EXEC vytiskni_boolean(vyhra(101, 1001));
-- nemel by byt proveden
EXEC proved_tah(101, 1002, 7, 20);
EXEC vytiskni_boolean(vyhra(101, 1002));
