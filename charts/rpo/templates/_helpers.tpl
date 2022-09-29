{{/*
return the proper image values project
*/}}
{{- define "project.image" -}}
{{- $registryname :=  .Values.image.registry -}}
{{- $repositoryname := .Values.image.repository -}}
{{- $tag := .Values.image.tag | toString -}}
{{- printf "%s/%s:%s" $registryname $repositoryname $tag -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "project.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "project.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "project.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "project.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{ default (include "project.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
{{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Define properties in key=value fasion for otel/spring configmaps
*/}}
{{- define "list-properties"}}
{{- range $key, $val := first .}}
{{ $key }}={{ $val }}
{{- end}}
{{- end }}



{{/*
Common labels
*/}}
{{- define "project.labels" -}}
app: {{ template "project.name" . }}
release: {{ .Release.Name }}
chart: {{ template "project.chart" . }}
heritage: {{ .Release.Service }}
helm.sh/chart: {{ include "project.chart" . }}
{{ include "project.selector.labels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "project.selector.labels" -}}
app.kubernetes.io/name: {{ include "project.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

