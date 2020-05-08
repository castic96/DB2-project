INSERT INTO stav (id, nazev) VALUES (1, 'rozehraná');
INSERT INTO stav (id, nazev) VALUES (2, 'vítězství začínajícího hráče');
INSERT INTO stav (id, nazev) VALUES (3, 'prohra začínajícího hráče');
INSERT INTO stav (id, nazev) VALUES (4, 'remíza');

COMMIT;


INSERT INTO omezeni (id, radek_max, radek_min, sloupec_max, sloupec_min, symbol_max, symbol_min) 
VALUES (1, 20, 5, 20, 5, 15, 5);

COMMIT;