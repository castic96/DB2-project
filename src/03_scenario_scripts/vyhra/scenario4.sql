TRUNCATE TABLE tah;

--- 1. kolo
EXEC proved_tah(101, 1001, 15, 20);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 16, 17);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 2. kolo
EXEC proved_tah(101, 1001, 17, 16);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 16, 20);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 3. kolo
EXEC proved_tah(101, 1001, 18, 16);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 17, 19);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 4. kolo
EXEC proved_tah(101, 1001, 17, 20);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 18, 18);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 5. kolo
EXEC proved_tah(101, 1001, 18, 19);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 19, 17);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 6. kolo
EXEC proved_tah(101, 1001, 19, 18);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 20, 16);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 7. kolo
-- nemel by byt proveden
EXEC proved_tah(101, 1001, 20, 18);
EXEC vytiskni_boolean(vyhra(101, 1001));
