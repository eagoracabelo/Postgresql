#!/bin/bash

set -e
set -u

function create_user_and_database() {
	local database=$1
	export $database

	if psql -lqt | cut -d \| -f 1 | grep -qw $database; then
		echo "  Banco de dados '$database' já existe!"
	else
		echo "  Criando banco de dados: '$database'"
		psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-'EOSQL'
		    DO $$
			BEGIN
				IF NOT EXISTS (
					SELECT FROM pg_catalog.pg_roles
					WHERE rolname = 'vrsoftware'
				) THEN
					CREATE ROLE vrsoftware LOGIN PASSWORD 'vrsoftware';
				END IF;
			END $$;
		    --CREATE DATABASE $database;
			--GRANT ALL PRIVILEGES ON DATABASE $database TO vrsoftware;
		EOSQL
		echo "  Criado banco de dados '$database' com sucesso!"
	fi
}

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
	echo "Bancos de dados a serem criados: $POSTGRES_MULTIPLE_DATABASES"
	for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
		create_user_and_database $db
	done
	echo "Bancos de dados criados!"
fi