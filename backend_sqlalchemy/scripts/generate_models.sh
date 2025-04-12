#!/bin/bash

DB_USER="postgres"
DB_PASS="root"
DB_HOST="localhost"
DB_PORT="5432"
DB_NAME="northwind"
DB_SCHEMA="northwind"

OUTPUT_PATH="../app/models/models.py"

# Executa o sqlacodegen com um patch para a função version, evitando o erro com 'citext'
python -c "import importlib.metadata as md; orig = md.version; md.version = lambda dist: 'unknown' if dist=='citext' else orig(dist); from sqlacodegen.cli import main; import sys; sys.exit(main())" \
  postgresql://$DB_USER:$DB_PASS@$DB_HOST:$DB_PORT/$DB_NAME --schema=$DB_SCHEMA --outfile=$OUTPUT_PATH

echo "✅ Models generated successfully at $OUTPUT_PATH"
