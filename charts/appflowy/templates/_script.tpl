{{- define "setup_appflowy_db.sql" }}
CREATE EXTENSION IF NOT EXISTS vector;
{{- end -}}

{{- define "setup.sh" }}
#!/bin/bash
set -e
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
  -f /scripts/setup_appflowy_db.sql
{{- end }}
