TRUNCATE TABLE tah;

--- 1. kolo
EXEC proved_tah(101, 1001, 4, 4);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 7, 4);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 2. kolo
EXEC proved_tah(101, 1001, 6, 4);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 9, 6);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 3. kolo
EXEC proved_tah(101, 1001, 8, 5);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 5, 5);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 4. kolo
EXEC proved_tah(101, 1001, 7, 6);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 4, 6);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 5. kolo
EXEC proved_tah(101, 1001, 6, 7);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 3, 7);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 6. kolo
EXEC proved_tah(101, 1001, 5, 8);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 4, 9);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 7. kolo
EXEC proved_tah(101, 1001, 9, 4);
EXEC vytiskni_boolean(vyhra(101, 1001));
-- nemel by byt proveden
EXEC proved_tah(101, 1002, 10, 2);
EXEC vytiskni_boolean(vyhra(101, 1002));
