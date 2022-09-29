{{- define "project.podTemplate" -}}
{{- $fullname := include "project.fullname" . -}}
metadata:
  annotations:
    checksum/app-config: {{ include (print $.Template.BasePath "/app-configmap.yaml") . | sha256sum }}
    checksum/otel-config: {{ include (print $.Template.BasePath "/otel-configmap.yaml") . | sha256sum }}
    {{- if .Values.configFiles }}
    {{- range .Values.configFiles }}
    checksum/config-file-{{ .name }}: {{ .data | b64dec | sha256sum }}
    {{- end }}
    {{- end }}
{{- if .Values.podAnnotations }}
{{ toYaml .Values.podAnnotations | indent 4 }}
{{- end }}
  {{- if .Values.metrics.enabled }}
    prometheus.io/scrape: "{{ .Values.metrics.scrape }}"
    prometheus.io/port: "{{ .Values.metrics.port }}"
    prometheus.io/path: "{{ .Values.metrics.path }}"
  {{- end }}
  labels:
{{ include "project.labels" . | indent 4 }}
{{- if .Values.podLabels }}
{{ toYaml .Values.podLabels | indent 4 }}
{{- end }}
spec:
  serviceAccountName: {{ template "project.serviceAccountName" . }}
  containers:
    - name: {{ $fullname }}
      image: {{ template "project.image" . }}
      imagePullPolicy: {{ .Values.image.pullPolicy | quote }}
      env:
        - name: KUBERNETES_NODE_NAME
          valueFrom:
            fieldRef:
              fieldPath: spec.nodeName
        - name: KUBERNETES_POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: KUBERNETES_POD_IP
          valueFrom:
            fieldRef:
              fieldPath: status.podIP
        - name: KUBERNETES_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: SPRING_PROFILES_ACTIVE
          value: "kubernetes"
        - name: JAVA_OPTS
          value: >-
        {{- if .Values.remotedebug.enabled }}
            -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address={{ .Values.remotedebug.port | default 5005 }}
        {{- end }}
        {{- if .Values.otel.enabled }}
            -javaagent:/otel/opentelemetry-javaagent.jar
            -Dotel.javaagent.configuration-file=/otel/otel-agent.properties
        {{- end }}
        {{- if .Values.chaosmesh.byteman.enabled }}
        - name: BYTEMAN_HOME
          value: /opt/byteman-agent/byteman
        {{- end }}
        - name: JAVA_EXEC
          value: {{ .Values.java.exec | quote }}
      volumeMounts:
        {{- if .Values.stateful }}
        - name: data
          mountPath: /var/data
        {{- end }}
        {{- if .Values.configSecrets }}
        - name: config-secrets
          mountPath: /var/secrets
          readOnly: true
        {{- end }}
        {{- if .Values.configFiles }}
        - name: config-files
          mountPath: /var/configs
          readOnly: true
        {{- end }}
        {{- if .Values.otel.enabled }}
        - name: {{ $fullname }}-otel
          mountPath: /otel/otel-agent.properties
          subPath: otel-agent.properties
          readOnly: true
        {{- end }}
        {{- if .Values.chaosmesh.byteman.enabled }}
        - name: byteman
          mountPath: /opt/byteman-agent
        {{- end }}
      ports:
        - name: http
          containerPort: 8080
          protocol: TCP
        - name: management
          containerPort: 9090
          protocol: TCP
        {{- if .Values.remotedebug.enabled }}
        - name: remotedebug
          containerPort: {{ .Values.remotedebug.port | default 5005 }}
          protocol: TCP
        {{- end }}
     {{- with .Values.resources }}
      resources:
        {{- toYaml .Values.resources | nindent 8 }}
      {{- end }}
  {{- if .Values.chaosmesh.byteman.enabled }}
  initContainers:
  - name: byteman-install
    image: {{.Values.chaosmesh.byteman.registry}}/{{ .Values.chaosmesh.byteman.image }}:{{ .Values.chaosmesh.byteman.tag }}
    command: ['cp', '-r', '/opt/byteman', '/tmp']
    volumeMounts:
    - name: byteman
      mountPath: "/tmp"
  {{- end }}
  volumes:
    {{- if .Values.configSecrets }}
    - name: config-secrets
      projected:
        sources:
          {{- range $key, $value := .Values.configSecrets }}
          - secret:
              name: {{ $value.secretName }}
              items:
                - key: {{ $value.key | default "password" }}
                  path: {{ $key }}
          {{- end }}
    {{- end }}
    {{- if .Values.configFiles }}
    - name: config-files
      projected:
        sources:
          {{- range .Values.configFiles }}
          - configMap:
              name: {{ $fullname }}-{{ .name }}
              items:
                - key: {{ .filename }}
                  path: {{ .filename }}
         {{- end }}
    {{- end }}
    {{- if .Values.otel.enabled }}
    - name: {{ $fullname }}-otel
      configMap:
        name: {{ $fullname }}-otel
        items:
          - key: otel-agent.properties
            path: otel-agent.properties
    {{- end }}
    {{- if .Values.chaosmesh.byteman.enabled }}
    - name: byteman
      emptyDir: {}
    {{- end }}
  {{- with .Values.nodeSelector }}
  nodeSelector:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.affinity }}
  affinity:
    {{- toYaml . | nindent 4 }}
  {{- end -}}
  {{- with .Values.tolerations }}
  tolerations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  restartPolicy: Always
{{- end -}}
