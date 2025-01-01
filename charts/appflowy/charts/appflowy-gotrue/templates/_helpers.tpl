{{/*
Expand the name of the chart.
*/}}
{{- define "appflowy-gotrue.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "appflowy-gotrue.fullname" -}}
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
{{- define "appflowy-gotrue.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "appflowy-gotrue.labels" -}}
helm.sh/chart: {{ include "appflowy-gotrue.chart" . }}
{{ include "appflowy-gotrue.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "appflowy-gotrue.selectorLabels" -}}
app.kubernetes.io/name: {{ include "appflowy-gotrue.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "appflowy-gotrue.callback" -}}
{{- printf "%s://%s:%d/gotrue/callback" .Values.global.scheme .Values.global.externalHost (.Values.global.externalPort | int) }}
{{- end }}

{{- define "appflowy-gotrue.strip-prefix-middleware.fullname" -}}
{{- printf "%s-strip-prefix" (include "appflowy-gotrue.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}
