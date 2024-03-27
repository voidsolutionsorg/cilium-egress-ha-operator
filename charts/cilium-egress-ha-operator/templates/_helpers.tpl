{{/*
Expand the name of the chart.
*/}}
{{- define "cilium-egress-ha-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cilium-egress-ha-operator.fullname" -}}
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
{{- define "cilium-egress-ha-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cilium-egress-ha-operator.labels" -}}
helm.sh/chart: {{ include "cilium-egress-ha-operator.chart" . }}
{{ include "cilium-egress-ha-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cilium-egress-ha-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cilium-egress-ha-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cilium-egress-ha-operator.serviceAccountName" -}}
{{- default (include "cilium-egress-ha-operator.fullname" .) .Values.serviceAccount.name }}
{{- end }}

{{/*
Create the name of the cluster role to use
*/}}
{{- define "cilium-egress-ha-operator.clusterRoleName" -}}
{{- default (include "cilium-egress-ha-operator.fullname" .) .Values.clusterRole.name }}
{{- end }}

{{/*
Create the name of the cluster role binding to use
*/}}
{{- define "cilium-egress-ha-operator.clusterRoleBindingName" -}}
{{- default (include "cilium-egress-ha-operator.fullname" .) .Values.clusterRoleBinding.name }}
{{- end }}