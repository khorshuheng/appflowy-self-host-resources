# appflowy

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

AppFlowy Web Services

## Requirements

| Repository | Name | Version |
|------------|------|---------|
|  | appflowy-cloud | 0.1.0 |
|  | appflowy-gotrue | 0.1.0 |
| https://charts.bitnami.com/bitnami | minio | 14.7.14 |
| https://charts.bitnami.com/bitnami | postgresql | 15.5.24 |
| https://charts.bitnami.com/bitnami | redis | 20.0.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.scheme | string | `"http"` | Accepted values: "http" or "https" |
| global.external_host | string | `"appflowy.mydomain.com"` | The host name which can be used for the AppFlowy client to reach the API server |
| global.external_port | int | `80` | The port number which can be used for the AppFlowy client to reach the API server |
| global.ingress.nginx.enabled | bool | `true` | Enable to create ingress for NGINX Ingress Controller |
| global.ingress.nginx.className | string | `"nginx"` | The class name of the NGINX Ingress Controller ingress |
| global.ingress.traefik.enabled | bool | `false` | Enable to create IngressRoute for Traefik Ingress Controller |
| global.ingress.traefik.entryPoint | string | `"web"` | The entry point for the Traefik Ingress Controller if the scheme is "http" |
| global.ingress.traefik.secureEntryPoint | string | `"websecure"` | The entry point for the Traefik Ingress Controller if the scheme is "https" |
| global.ingress.websocket.timeout | int | `86400` | Define timeout for websocket connection. Currently only used for the Nginx ingress. |
| global.ingress.cors.allowOrigins | string | `"*"` | Configure the domains which are allowed to access the API server eg. domain for AppFlowy Web |
| global.ingress.cors.maxAge | string | `"3600"` | CORS max age |
| global.database.host | string | `"appflowy-postgres"` | Database host name |
| global.database.name | string | `"appflowy"` | Database name |
| global.database.port | int | `5432` | Database port |
| global.database.username | string | `"appflowy"` | Postgres user, to be used by the AppFlowy API server |
| global.database.adminUsername | string | `"postgres"` | Postgres admin user, to be used by the setup job. |
| global.smtp.host | string | `"smtp.gmail.com"` | SMTP host name, required for sending invitation emails and magic links. |
| global.smtp.port | int | `465` | SMTP port number. Make sure that TLS is supported. STARTTLS, such as port 587 for gmail and mailgun, is not supported. |
| global.smtp.user | string | `"user@gmail.com"` | SMTP user name |
| global.secret.name | string | `"appflowy"` | Name of the secret which stores all the sensitive information required for AppFlowy |
| global.secret.create | bool | `true` | Create or update the Kubernetes secret. If set to false, the secret must be created manually, and the name should be adjusted accordingly. |
| global.secret.postgres.adminPassword.key | string | `"postgresAdminPassword"` | Secret key name for the Postgres admin password |
| global.secret.postgres.adminPassword.value | string | `"password"` | Secret value for the Postgres admin password |
| global.secret.postgres.gotrue.postgresPassword.key | string | `"gotruePostgresPassword"` | Secret key name for the password of the gotrue postgres user (supabase_admin_auth) |
| global.secret.postgres.gotrue.postgresPassword.value | string | `"password"` | Secret value for the password of the gotrue postgres user (supabase_admin_auth) |
| global.secret.postgres.gotrue.databaseUrl.key | string | `"gotrueDatabaseUrl"` | Database url, as inferred from the postgres credentials. Takes the form of: postgres://supabase_auth_admin:<password>@<host>:<port>/<database name> |
| global.secret.postgres.appflowy.postgresPassword.key | string | `"postgresPassword"` | Secret key name for the password of the appflowy postgres user |
| global.secret.postgres.appflowy.postgresPassword.value | string | `"password"` | Secret value for the password of the appflowy postgres user |
| global.secret.postgres.appflowy.databaseUrl.key | string | `"appflowyDatabaseUrl"` | Database url, as inferred from the postgres credentials. Takes the form of: postgres://<appflowy user>:<password>@<host>:<port>/<database name> |
| global.secret.gotrue.adminPassword.key | string | `"gotrueAdminPassword"` | Secret key name for the Gotrue admin password |
| global.secret.gotrue.adminPassword.value | string | `"password"` | Secret value for the Gotrue admin password |
| global.secret.oauth.googleClientSecret.key | string | `"oauthGoogleClientSecret"` | Secret key name for the Google OAuth client secret |
| global.secret.oauth.googleClientSecret.value | string | `""` | Secret value for the Google OAuth client secret |
| global.secret.oauth.discordClientSecret.key | string | `"oauthDiscordClientSecret"` | Secret key name for the Discord OAuth client secret |
| global.secret.oauth.discordClientSecret.value | string | `""` | Secret value for the Discord OAuth client secret |
| global.secret.oauth.githubClientSecret.key | string | `"oauthGithubClientSecret"` | Secret key name for the Github OAuth client secret |
| global.secret.oauth.githubClientSecret.value | string | `""` | Secret value for the Github OAuth client secret |
| global.secret.oauth.appleClientSecret.key | string | `"oauthAppleClientSecret"` | Secret key name for the Apple OAuth client secret |
| global.secret.oauth.appleClientSecret.value | string | `""` | Secret value for the Apple OAuth client secret |
| global.secret.jwt.secret.key | string | `"jwtSecret"` | Secret key name for the JWT secret |
| global.secret.jwt.secret.value | string | `"hello456"` | Secret value for the JWT secret |
| global.secret.smtp.password.key | string | `"smtpPassword"` | Secret key name for the SMTP password |
| global.secret.smtp.password.value | string | `"password"` | Secret value for the SMTP password. For gmail, make sures to use an app password instead of the regular user password. |
| global.secret.s3.secret.key | string | `"s3Secret"` | Secret key name for the S3 secret |
| global.secret.s3.secret.value | string | `"password"` | Secret value for the S3 secret |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `"appflowy"` | Override the name of the resources created by the chart |
| postgresql.enabled | bool | `true` |  |
| postgresql.fullnameOverride | string | `"appflowy-postgres"` |  |
| postgresql.image.repository | string | `"zmegalodon/appflowy-postgres"` |  |
| postgresql.image.tag | string | `"0.1.0"` |  |
| postgresql.auth.username | string | `"appflowy"` |  |
| postgresql.auth.database | string | `"appflowy"` |  |
| postgresql.auth.password | string | `"password"` |  |
| postgresql.auth.postgresPassword | string | `"password"` |  |
| postgresql.primary.persistence.enabled | bool | `true` |  |
| postgresql.primary.persistence.size | string | `"1Gi"` |  |
| appflowy-gotrue.enabled | bool | `true` |  |
| appflowy-gotrue.fullnameOverride | string | `"appflowy-gotrue"` |  |
| appflowy-gotrue.mailer.enabled | bool | `true` |  |
| appflowy-gotrue.mailer.autoConfirm | bool | `false` |  |
| appflowy-gotrue.extraEnv | list | `[]` |  |
| appflowy-cloud.enabled | bool | `true` |  |
| appflowy-cloud.fullnameOverride | string | `"appflowy-cloud"` |  |
| appflowy-cloud.redis.uri | string | `"redis://appflowy-redis-headless:6379"` |  |
| appflowy-cloud.gotrue.baseUrl | string | `"http://appflowy-gotrue"` |  |
| appflowy-cloud.gotrue.adminEmail | string | `"admin@example.com"` |  |
| appflowy-cloud.s3.createBucket | string | `"true"` |  |
| appflowy-cloud.s3.useMinio | string | `"true"` |  |
| appflowy-cloud.s3.minioUrl | string | `"http://appflowy-minio:9000"` |  |
| appflowy-cloud.s3.accessKey | string | `"minioadmin"` |  |
| appflowy-cloud.accessControl.enabled | bool | `true` |  |
| appflowy-cloud.ingress.enabled | bool | `true` |  |
| redis.enabled | bool | `true` |  |
| redis.auth.enabled | bool | `false` |  |
| redis.architecture | string | `"standalone"` |  |
| redis.fullnameOverride | string | `"appflowy-redis"` |  |
| redis.master.persistence.enabled | bool | `false` |  |
| minio.enabled | bool | `true` |  |
| minio.auth.rootPassword | string | `"password"` |  |
| minio.auth.rootUser | string | `"minioadmin"` |  |
| minio.persistence.size | string | `"1Gi"` |  |
| minio.resources.limits.memory | string | `"256Mi"` |  |
| minio.resources.requests.cpu | string | `"10m"` |  |
| minio.resources.requests.memory | string | `"256Mi"` |  |
| setupJob.enabled | bool | `true` |  |
| setupJob.postgresConnectTimeout | int | `60` |  |
| setupJob.backoffLimit | int | `5` |  |
| setupJob.resources | object | `{}` |  |
| setupJob.nodeSelector | object | `{}` |  |
| setupJob.tolerations | list | `[]` |  |
| setupJob.affinity | object | `{}` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
