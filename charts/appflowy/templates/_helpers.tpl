{{/*
Expand the name of the chart.
*/}}
{{- define "appflowy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "appflowy.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "appflowy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "appflowy.labels" -}}
helm.sh/chart: {{ include "appflowy.chart" . }}
{{ include "appflowy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "appflowy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "appflowy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "appflowy.job.fullname" -}}
{{- printf "%s-db-setup" (include "appflowy.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "appflowy.gotrueDatabase.url" -}}
{{- printf "postgres://supabase_auth_admin:%s@%s:%d/%s"  .Values.global.secret.postgres.gotrue.postgresPassword.value .Values.global.database.host (.Values.global.database.port | int) .Values.global.database.name }}
{{- end }}

{{- define "appflowy.appflowyDatabase.url" -}}
{{- printf "postgres://%s:%s@%s:%d/%s"  .Values.global.database.username .Values.global.secret.postgres.appflowy.postgresPassword.value .Values.global.database.host (.Values.global.database.port | int) .Values.global.database.name }}
{{- end }}

{{- define "appflowy.aiDatabase.url" -}}
{{- printf "postgresql+psycopg://%s:%s@%s:%d/%s"  .Values.global.database.username .Values.global.secret.postgres.appflowy.postgresPassword.value .Values.global.database.host (.Values.global.database.port | int) .Values.global.database.name }}
{{- end }}
