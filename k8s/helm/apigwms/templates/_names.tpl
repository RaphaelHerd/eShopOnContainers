{{- define "suffix-name" -}}
{{- if .Values.app.name -}}
{{- .Values.app.name -}}
{{- else -}}
{{- .Release.Name -}}
{{- end -}}
{{- end -}}

{{- define "sql-name" -}}
{{- if .Values.inf.sql.host -}}
{{- .Values.inf.sql.host -}}
{{- else -}}
{{- printf "%s" "sql-data" -}}
{{- end -}}
{{- end -}}

{{- define "mongo-name" -}}
{{- if .Values.inf.mongo.host -}}
{{- .Values.inf.mongo.host -}}
{{- else -}}
{{- printf "%s" "nosql-data" -}}
{{- end -}}
{{- end -}}

{{- define "url-of" -}}
{{- $name := first .}}
{{- $ctx := last .}}
{{- $suffix := include "suffix-name" $ctx -}}
{{- if $ctx.Values.inf.k8s.dnsprefix -}}
{{- printf "%s.%s/%s" $suffix $ctx.Values.inf.k8s.dns $name -}}     {{/* Value is <prefix>.<dns>/<name> */}}
{{- else -}}
{{- if $ctx.Values.inf.k8s.suffix -}}
{{- printf "%s/%s-%s" $ctx.Values.inf.k8s.dns $name $suffix -}}     {{/*Value is <dns>/<name>-<sufix> */}}
{{- else -}}
{{- printf "%s/%s" $ctx.Values.inf.k8s.dns $name -}}                {{/*Value is just <dns>/<name> */}}
{{- end -}}
{{- end -}}
{{- end -}}



{{ define "pathBase" -}}
{{- $name := first .}}
{{- $ctx := last .}}
{{- if $ctx.Values.inf.k8s.suffix -}}
{{- $suffix := include "suffix-name" $ctx -}}
{{- printf "/%s-%s"  $name $suffix -}}
{{- else -}}
{{- printf "/%s" $name -}}
{{- end -}}
{{- end -}}