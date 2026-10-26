## SmartData Database REST-API

SmartData is a REST API for accessing databases over Java Application Servers. It implements the [TreeQL](https://www.treeql.org) spec.

Any help improving this API is welcome. See CONTRIBUTING.md for more information.

Further informations you can find in the wiki.

This software is developed for everyone. Please use it wise for freedom, peace and equality. For all beeings.

## Build

The project is built with Maven and no longer requires NetBeans or Ant. The
NetBeans directory layout (`src/java`, `web`) is kept and wired into the POM.

Requirements:

- JDK 17 or newer
- Maven 3.9 or newer

```bash
mvn clean package
```

The resulting artifact is `target/SmartData.war`. It is deployed as
`/SmartData` and serves its REST API below `/SmartData/smartdata`.

The Jakarta EE API and the JAXB implementation are `provided` by the
application server and are not packaged into the WAR. The Smart* helper
libraries (`NGI_Logger`, `NGI_RestUtils`, `NGI_AdvancedReflection`,
`SmartUserAuth`) come from the project-local Maven repository in
`libs/maven-repo`.

## Deployment

SmartData needs a JNDI data source:

```text
jdbc/SmartData   PostgreSQL
```

The JNDI name can be changed with the property `postgres.jndi` in
`SmartData_config.properties`, which is read from the process working
directory. Setting `mongo.url` switches the storage layer to MongoDB instead.

Storages are PostgreSQL schemas. The default storage is `public`; a new storage
(e.g. `smartmonitoring`) is created with:

```bash
curl -X POST "http://localhost:8080/SmartData/smartdata/storage/create?name=smartmonitoring"
```

For the Docker/Payara stack, `Dockerfile` builds a minimal artifact image
containing only `/opt/wars/SmartData.war`. The master Payara image of the
`SmartDataDeployment` repository copies that WAR into `/opt/payara/deployments`
and configures `jdbc/SmartData`:

```bash
docker build -t smartdata-war:local .
```
