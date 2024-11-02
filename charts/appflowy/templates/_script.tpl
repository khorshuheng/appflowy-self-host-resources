{{- define "setup_appflowy_db.sql" }}
CREATE OR REPLACE FUNCTION create_roles(roles text []) RETURNS void LANGUAGE plpgsql AS $$
DECLARE role_name text;
BEGIN FOREACH role_name IN ARRAY roles LOOP IF NOT EXISTS (
    SELECT 1
    FROM pg_roles
    WHERE rolname = role_name
) THEN EXECUTE 'CREATE ROLE ' || role_name;
END IF;
END LOOP;
END;
$$;
DO $$ BEGIN IF NOT EXISTS (
    SELECT
    FROM pg_catalog.pg_roles
    WHERE rolname = 'supabase_auth_admin'
) THEN CREATE USER supabase_auth_admin BYPASSRLS NOINHERIT CREATEROLE LOGIN NOREPLICATION;
END IF;
END $$;

CREATE SCHEMA IF NOT EXISTS auth AUTHORIZATION supabase_auth_admin;
GRANT USAGE ON SCHEMA auth TO {{ .Values.global.database.username }};
GRANT CREATE ON DATABASE {{ .Values.global.database.name }} TO supabase_auth_admin;
GRANT supabase_auth_admin TO {{ .Values.global.database.username }};
ALTER USER supabase_auth_admin SET search_path = 'auth';
ALTER USER supabase_auth_admin WITH PASSWORD :'supabase_auth_admin_password';
CREATE EXTENSION IF NOT EXISTS vector;
{{- end -}}

{{- define "setup.sh" }}
#!/bin/bash
set -ex
echo "Waiting to connect to postgres..."
timeout={{ .Values.setupJob.postgresConnectTimeout }}
start_time=$(date +%s)
while true; do
  if pg_isready -h {{ .Values.global.database.host }} -p {{ .Values.global.database.port }} -U {{ .Values.global.database.adminUsername }}; then
    break
  fi
  current_time=$(date +%s)
  elapsed_time=$((current_time - start_time))
  if [ $elapsed_time -ge $timeout ]; then
    echo "Failed to connect to postgres within $timeout seconds."
    exit 1
  fi
  sleep 5
done
echo "Connected to postgres. Running setup script..."
psql \
  -v ON_ERROR_STOP=1 \
  -U {{ .Values.global.database.adminUsername }} \
  -h {{ .Values.global.database.host }} \
  -p {{ .Values.global.database.port }} \
  -d {{ .Values.global.database.name }} \
  -f /scripts/setup_appflowy_db.sql \
  -v supabase_auth_admin_password=$SUPABASE_AUTH_ADMIN_PASSWORD
{{- end }}
