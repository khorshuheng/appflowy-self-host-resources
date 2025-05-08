# appflowy

![Version: 0.2.1](https://img.shields.io/badge/Version-0.2.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

AppFlowy Cloud Helm Chart

## Requirements

| Repository | Name | Version |
|------------|------|---------|
|  | appflowy-admin | 0.1.0 |
|  | appflowy-ai | 0.1.0 |
|  | appflowy-cloud | 0.1.0 |
|  | appflowy-gotrue | 0.1.0 |
|  | appflowy-web | 0.1.0 |
|  | appflowy-worker | 0.1.0 |
| https://charts.bitnami.com/bitnami | minio | 14.7.14 |
| https://charts.bitnami.com/bitnami | postgresql | 15.5.24 |
| https://charts.bitnami.com/bitnami | redis | 20.0.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.scheme | string | `"http"` | Accepted values: "http" or "https" |
| global.externalHost | string | `"appflowy.mydomain.com"` | The host name which can be used for the AppFlowy client to reach the API server |
| global.externalPort | int | `80` | The port number which can be used for the AppFlowy client to reach the API server |
| global.ingress.nginx.enabled | bool | `true` | Enable to create ingress for NGINX Ingress Controller |
| global.ingress.nginx.className | string | `"nginx"` | The class name of the NGINX Ingress Controller ingress |
| global.ingress.nginx.tls.enabled | bool | `false` | Add TLS to the NGINX Ingress |
| global.ingress.nginx.tls.secretName | string | `""` | Nginx TLS secret name if using https |
| global.ingress.nginx.extraAnnotations | object | `{}` | Nginx extra annotations |
| global.ingress.traefik.enabled | bool | `false` | Enable to create IngressRoute for Traefik Ingress Controller |
| global.ingress.traefik.entryPoint | string | `"web"` | The entry point for the Traefik Ingress Controller if the scheme is "http" |
| global.ingress.traefik.secureEntryPoint | string | `"websecure"` | The entry point for the Traefik Ingress Controller if the scheme is "https" |
| global.ingress.traefik.extraMiddlewares | list | `[]` | Traefik extra middlewares extraMiddlewares: - name: "example-middleware"   namespace: "default" |
| global.ingress.websocket.timeout | int | `86400` | Define timeout for websocket connection. Currently only used for the Nginx ingress. |
| global.appflowyCloud.baseUrl | string | `"http://appflowy-cloud"` | The url which can be used withib Kubernetes to reach the AppFlowy Cloud service |
| global.gotrue.baseUrl | string | `"http://appflowy-gotrue"` | The url which can be used withib Kubernetes to reach the Gotrue service |
| global.gotrue.adminEmail | string | `"admin@example.com"` | Gotrue admin user to be created when Gotrue is deployed for the first time |
| global.database.host | string | `"appflowy-postgres"` | Database host name |
| global.database.name | string | `"appflowy"` | Database name |
| global.database.port | int | `5432` | Database port |
| global.database.username | string | `"appflowy"` | Postgres user, to be used by the AppFlowy API server |
| global.database.adminUsername | string | `"postgres"` | Postgres admin user |
| global.redis.uri | string | `"redis://appflowy-redis-headless:6379"` | Redis URI |
| global.s3.createBucket | string | `"true"` | Create bucket on startup. If false, bucket must be created manually. |
| global.s3.useMinio | string | `"true"` | Set this to true when using Minio or other S3-compatible services. |
| global.s3.bucket | string | `"appflowy"` | S3 Bucket name |
| global.s3.minioUrl | string | `"http://appflowy-minio:9000"` | Url for the S3-compatible service |
| global.s3.accessKey | string | `"minioadmin"` | S3 access key |
| global.s3.region | string | `"us-east-1"` | S3 region. Not used for Minio. |
| global.smtp.host | string | `"smtp.gmail.com"` | SMTP host name, required for sending invitation emails and magic links. |
| global.smtp.port | int | `465` | SMTP port number. By default, only TLS is supported. STARTTLS, such as port 587 for gmail and mailgun, is only supported if you change tls kind to opportunistic. |
| global.smtp.user | string | `"user@gmail.com"` | SMTP user name |
| global.smtp.email | string | `"user@gmail.com"` | SMTP email |
| global.smtp.tlsKind | string | `"wrapper"` | SMTP TLS kind. Accepted values: "none", "wrapper", "required", "opportunistic" |
| global.ai.enabled | bool | `false` | Enable AI related functionalities. Require OpenAI API key to be set under secret. |
| global.ai.host | string | `"appflowy-ai"` | Hostname that appflowy-cloud will use when connecting to the Appflowy AI service |
| global.ai.port | int | `5001` | Port number that appflowy-cloud will use when connecting to the Appflowy AI service |
| global.secret.name | string | `"appflowy"` | Name of the secret which stores all the sensitive information required for AppFlowy |
| global.secret.create | bool | `true` | secret will be created with the values specified in helm values. |
| global.secret.postgres.adminPassword.key | string | `"postgresAdminPassword"` | Secret key name for the Postgres admin password |
| global.secret.postgres.adminPassword.value | string | `"password"` | Secret value for the Postgres admin password. |
| global.secret.postgres.gotrue.postgresPassword.key | string | `"gotruePostgresPassword"` | Secret key name for the password of the gotrue postgres user (supabase_admin_auth) |
| global.secret.postgres.gotrue.postgresPassword.value | string | `"password"` | Secret value for the password of the gotrue postgres user (supabase_admin_auth). |
| global.secret.postgres.gotrue.databaseUrl.key | string | `"gotrueDatabaseUrl"` | Database url, as inferred from the postgres credentials. Takes the form of: postgres://<user>:<password>@<host>:<port>/<database name>?search_path=auth |
| global.secret.postgres.appflowy.postgresPassword.key | string | `"postgresPassword"` | Secret key name for the password of the appflowy postgres user |
| global.secret.postgres.appflowy.postgresPassword.value | string | `"password"` | Secret value for the password of the appflowy postgres user |
| global.secret.postgres.appflowy.databaseUrl.key | string | `"appflowyDatabaseUrl"` | Database url, as inferred from the postgres credentials. Takes the form of: postgres://<appflowy user>:<password>@<host>:<port>/<database name> |
| global.secret.postgres.ai.databaseUrl.key | string | `"aiDatabaseUrl"` | Database url, as inferred from the postgres credentials. Takes the form of: postgresql+psycopg://<appflowy user>:<password>@<host>:<port>/<database name> |
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
| global.secret.oauth.samlPrivateKey.key | string | `"oauthSAMLPrivateKey"` | Secret key name for the SAML private key |
| global.secret.oauth.samlPrivateKey.value | string | `""` | Secret value for the SAML private key |
| global.secret.jwt.secret.key | string | `"jwtSecret"` | Secret key name for the JWT secret |
| global.secret.jwt.secret.value | string | `"hello456"` | Secret value for the JWT secret |
| global.secret.smtp.password.key | string | `"smtpPassword"` | Secret key name for the SMTP password |
| global.secret.smtp.password.value | string | `"password"` | Secret value for the SMTP password. For gmail, make sures to use an app password instead of the regular user password. |
| global.secret.s3.secret.key | string | `"s3Secret"` | Secret key name for the S3 secret |
| global.secret.s3.secret.value | string | `"password"` | Secret value for the S3 secret |
| global.secret.ai.openAIAPIKey.key | string | `"openAIAPIKey"` | Secret key name for the OpenAI API key |
| global.secret.ai.openAIAPIKey.value | string | `""` | Secret value for the OpenAI API key. Leave this empty if you don't wish to use OpenAI. |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `"appflowy"` | Override the name of the resources created by the chart |
| postgresql.enabled | bool | `true` |  |
| postgresql.fullnameOverride | string | `"appflowy-postgres"` |  |
| postgresql.image.repository | string | `"zmegalodon/appflowy-postgres"` |  |
| postgresql.image.tag | string | `"0.1.0"` |  |
| postgresql.auth.username | string | `"appflowy"` |  |
| postgresql.auth.database | string | `"appflowy"` |  |
| postgresql.auth.existingSecret | string | `"appflowy"` |  |
| postgresql.auth.secretKeys.adminPasswordKey | string | `"postgresAdminPassword"` |  |
| postgresql.auth.secretKeys.userPasswordKey | string | `"postgresPassword"` |  |
| postgresql.primary.persistence.enabled | bool | `true` |  |
| postgresql.primary.persistence.size | string | `"1Gi"` |  |
| appflowy-admin.enabled | bool | `true` |  |
| appflowy-admin.fullnameOverride | string | `"appflowy-admin"` |  |
| appflowy-gotrue.enabled | bool | `true` |  |
| appflowy-gotrue.fullnameOverride | string | `"appflowy-gotrue"` |  |
| appflowy-gotrue.mailer.enabled | bool | `true` |  |
| appflowy-gotrue.mailer.autoConfirm | bool | `false` | Set true if you want the users to sign up without confirmation email |
| appflowy-gotrue.mailer.adminEmail | string | `"user@gmail.com"` | Email address for gotrue email links |
| appflowy-gotrue.extraEnv | list | `[]` |  |
| appflowy-cloud.enabled | bool | `true` |  |
| appflowy-cloud.fullnameOverride | string | `"appflowy-cloud"` |  |
| appflowy-cloud.gotrue.baseUrl | string | `"http://appflowy-gotrue"` |  |
| appflowy-cloud.accessControl.enabled | bool | `true` |  |
| appflowy-cloud.ingress.enabled | bool | `true` |  |
| appflowy-web.enabled | bool | `true` |  |
| appflowy-web.fullnameOverride | string | `"appflowy-web"` |  |
| appflowy-web.ingress.enabled | bool | `true` |  |
| appflowy-ai.fullnameOverride | string | `"appflowy-ai"` |  |
| appflowy-ai.ingress.enabled | bool | `true` |  |
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
| setupJob.enabled | bool | `true` | Required for enabling pgvector for database. This is optional if the postgres user for appflowy is already a superadmin, or the extension is already enabled. |
| setupJob.postgresConnectTimeout | int | `60` |  |
| setupJob.backoffLimit | int | `5` |  |
| setupJob.resources | object | `{}` |  |
| setupJob.nodeSelector | object | `{}` |  |
| setupJob.tolerations | list | `[]` |  |
| setupJob.affinity | object | `{}` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
