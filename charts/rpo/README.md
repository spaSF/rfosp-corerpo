# Springboot Helm Chart

* Installs the springboot application


## Installing the Chart

To install the chart with the release name `my-release`:

```console
# TODO
helm install my-release .
```
## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```


The command removes all the Kubernetes components associated with the chart and deletes the release.
## Configuration

| Parameter                                 | Description                                     | Default                                                 |
|-------------------------------------------|-------------------------------------------------|---------------------------------------------------------|
| `image.registry`                          | Registry containing the image                   | `some-registry.example.com` - needs to be changed       |
| `image.repository`                        | Repository in the registry containing the image | `repo/image` - needs to be changed                      |
| `image.tag`                               | Image tag                                       | `1.0.0` - needs to be changed                           |
| `image.pullPolicy`                        | Image pull policy                               | `IfNotPresent`                                          |
| `image.pullSecrets`                       | Image pull secrets                              | `{}`  TODO - not used                                   |
| `replicas`                                | Number of nodes                                 | `2 `                                                    |
| `nameOverride`                            | String to partially override project.fullname   | `""`                                                    |
| `fulnameOverride`                         | String to fully override project.fullname       | `""`                                                    |
| `java.exec`                               | Name of the executable jar file                 | `springboot-0.0.1-SNAPSHOT.jar`                         |
| `stateful`                                | Defines if StatefulSet or Depl. is created      | `false`                                                 |
| `persistentVolumes.accessMode`            | Persistence access mode for stateful volume     | `ReadWriteOnce`                                         |
| `persistentVolumes.size`                  | Persistent volume size                          | `200M`                                                  |
| `annotations`                             | StatefulSet/Deployment annotations              | `{}`                                                    |
| `service.annotations`                     | Service annotations                             | `{}`                                                    |
| `service.labels`                          | Custom labels                                   | `{}`                                                    |
| `service.type`                            | Kubernetes service type                         | `ClusterIP`                                             |
| `serviceAccount.annotations`              | ServiceAccount annotations                      | `{}`                                                    |
| `serviceAccount.create`                   | Create service account                          | `true`                                                  |
| `serviceAccount.name`                     | Service account name to use, when empty will be set to created account if `serviceAccount.create` is set else to `default` | `` |
| `otel.enabled`                            | Specifies whether otel agent should be loaded   | `false`                                                 |
| `otel.endpoint`                           | Uri to opentelemetry metrics receiver           | `""`                                                    |
| `otel.protocol`                           | Specifies receivers protocol (http, grpc)       | `grpc`                                                  |
| `otel.config`                             | Additional configuration of the otel agent      | `{ otel.instrumentation.jdbc.enabled: false }`          |
| `remotedebug.enabled`                     | Enables remote debugging                        | `false`                                                 |
| `remotedebug.port`                        | Remote debug port                               | `5005`                                                  |
| `metrics.enabled`                         | Enables metrics annotations for prometheus      | `false`                                                 |
| `metrics.scrape`                          | Specifies if prometheus should scrape endpoint  | `false`                                                 |
| `metrics.port`                            | Specifies metrics endpoint port                 | `"9090"`                                                |
| `metrics.path`                            | Specifies metrics endpoint path                 | `"/actuator/prometheus"`                                |
| `resources`                               | Resources limits and requests                   | `{}` TODO                                               |
| `nodeSelector`                            | Node labels for springboot app pods assignment  | `{}`                                                    |
| `tolerations`                             | Tolerations for springboot app  pods assignment | `[]`                                                    |
| `affinity`                                | Affinity for springboot app pods assignment     | see values.yaml                                         |
| `affinity`                                | Affinity for springboot app pods assignment     | see values.yaml                                         |
| `config`                                  | Springboot config to application.yaml           | ``                                                      |
| `configSecrets`                           | Springboot config secrets names                 | `{}`                                                    |
| `configFiles`                             | Springboot config files, e.g. keystore          | `[]`                                                    |
