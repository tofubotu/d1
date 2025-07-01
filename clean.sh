#!/bin/bash
set -e

echo "Cleaning up development artifacts..."

# Remove Vue build output
rm -rf frontend/dist

# Remove Node modules and lockfile (safe for full rebuilds)
rm -rf frontend/node_modules frontend/package-lock.json

# Remove Python cache files
find . -type d -name '__pycache__' -exec rm -rf {} +
find . -type f -name '*.pyc' -delete

# Remove Django database if you're using SQLite (optional)
read -p "Delete db.sqlite3? [y/N]: " confirm_db
if [[ "$confirm_db" == "y" || "$confirm_db" == "Y" ]]; then
    rm -f db.sqlite3
    echo "Removed db.sqlite3"
fi

# Remove orphaned Docker containers
docker compose down --remove-orphans

# Fix ownership (optional)
sudo chown -R "$USER":"$USER" .

echo "Cleanup complete."

