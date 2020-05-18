# DB2-project
Semestrální práce z předmětu KIV/DB2.

## Skriptování databáze
- zdrojové soubory aplikace jsou uloženy v adresáři `src`
- databázi je nutné skriptovat v určeném pořadí:
	- `src\01_create_scripts`:
		- `01_create_tables.sql`,
		- `02_create_functions.sql`,
		- `03_create_procedures.sql`,
		- `04_create_views.sql`,
		- `05_create_triggers.sql`,
	- `src\02_init_data_scripts`:
		- `01_insert_init_data`.

## Testovací scénáře
- testovací scénáře jsou uloženy ve složce `src\03_scenario_scripts` v podsložkách:
	- `src\01_wrong_parameters`,
	- `src\02_win_first`,
	- `src\03_lose_first`,
	- `src\04_tie`,
	- `src\05_win_directions`.

