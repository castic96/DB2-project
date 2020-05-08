TRUNCATE TABLE tah;

--- 1. kolo
EXEC proved_tah(101, 1001, 17, 4);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 17, 2);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 2. kolo
EXEC proved_tah(101, 1001, 19, 1);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 15, 1);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 3. kolo
EXEC proved_tah(101, 1001, 20, 2);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 16, 1);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 4. kolo
EXEC proved_tah(101, 1001, 19, 5);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 18, 3);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 5. kolo
EXEC proved_tah(101, 1001, 20, 3);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 19, 4);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 6. kolo
EXEC proved_tah(101, 1001, 20, 4);
EXEC vytiskni_boolean(vyhra(101, 1001));
EXEC proved_tah(101, 1002, 20, 5);
EXEC vytiskni_boolean(vyhra(101, 1002));

--- 7. kolo
-- nemel by byt proveden
EXEC proved_tah(101, 1001, 20, 7);
EXEC vytiskni_boolean(vyhra(101, 1001));
