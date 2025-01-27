{{/*
Expand the name of the chart.
*/}}
{{- define "appflowy-web.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 50 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 50 chars instead of 63 because there are some resources in this chart (such as traefik middleware) that derive
the resource name from the full name with suffix.
*/}}
{{- define "appflowy-web.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 50 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 50 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 50 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "appflowy-web.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 50 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "appflowy-web.labels" -}}
helm.sh/chart: {{ include "appflowy-web.chart" . }}
{{ include "appflowy-web.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "appflowy-web.selectorLabels" -}}
app.kubernetes.io/name: {{ include "appflowy-web.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "appflowy-web.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "appflowy-web.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "appflowy-web.gotrue.externalUrl" -}}
{{- printf "%s://%s:%d/gotrue" .Values.global.scheme .Values.global.externalHost (.Values.global.externalPort | int) }}
{{- end }}

{{- define "appflowy-web.appflowyCloud.externalUrl" -}}
{{- printf "%s://%s:%d" .Values.global.scheme .Values.global.externalHost (.Values.global.externalPort | int) }}
{{- end }}
