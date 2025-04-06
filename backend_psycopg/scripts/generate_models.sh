
DB_USER="postgres"
DB_PASS="root"
DB_HOST="localhost"
DB_PORT="5432"
DB_NAME="northwind"
DB_SCHEMA="northwind"

OUTPUT_PATH="models/models.py"

sqlacodegen postgresql://$DB_USER:$DB_PASS@$DB_HOST:$DB_PORT/$DB_NAME --schema=$DB_SCHEMA  --outfile=$OUTPUT_PATH

echo "✅ Models generated successfully at $OUTPUT_PATH"
