nutes
=====

PostgresQL import of USDA nutrient database.

Requires:
* curl
* make
* postgresql
* go

The Makefile will:

1. Download the USDA nutrient database
2. Prepare the text files for import (remove unicode, use TSV, etc.)
3. Create a database schema according to the USDA's documentation.
4. Import the data files into the database.

For this to work you will need to edit the Makefile to fit your particular
postgresql install. By default psql is assumed to work without username, password,
or database. (Tested using Postgres.app on my mac)
