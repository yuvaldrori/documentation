---
title: PostgreSQL
layout: page
tags:
  - services
  - databases
  - postgresql
categories:
  - databases
---
* include a table of contents
{:toc}

The default databases created for you are **development** and **test**.

PostgreSQL `9.2` runs on the default port and the credentials are stored in the `PG_USER` and `PG_PASSWORD` environment variables.

We install the Ubuntu postgresql-contrib package. It includes the [extension modules](http://www.postgresql.org/docs/9.2/static/contrib.html) listed in the PostgreSQL Documentation.

You need to activate them with `CREATE EXTENSION` as explained in the [Extension Guide](http://www.postgresql.org/docs/9.1/static/sql-createextension.html).

## Versions

### 9.2

The **default version** of PostgreSQL on Codeship is **9.2**, which runs on the default port of `5432`. To use it you don't need to change your configuration at all.

### 9.3

In addition we also have version **9.3** installed and configured identically. You can use this version by specifying port `5433` in your database configuration.

For Rails based projects you also need to work around our autoconfiguration. Please add the following command to your setup steps.

```shell
sed -i "s|5432|5433|" "config/database.yml"
```

### 9.4

Version **9.4** of the database server is running on port `5434` and configured identical to the others. If you want to use this version make sure to specify the correct port in your database configuration.

Again, for Rails based projects, please add the following command to your setup steps.

```shell
sed -i "s|5432|5434|" "config/database.yml"
```


## Create Databases and run psql commands
You can run any SQL query against the PostgreSQL database. For example to create a new database:

```shell
psql -c 'create database new_db;'
```

## Enable Extensions
You can enable extensions either via the your application framework (if supported) or by running commands directly against the database. E.g, you'd would add the following command to your setup steps to enable the `hstore` extension.

```shell
psql -c 'create extension if not exists hstore;' -d test -p 5432
```

*Note, that you'd need to adapt the port number if you switched to a different version of PostgreSQL previously!*

## PostGIS
PostGIS 2.0.x is installed on the virtual machine.

## Ruby on Rails

We replace the values in your `config/database.yml` automatically.

If you have your Rails application in a subdirectory or want to change
it from our default values you can add the following to a codeship.database.yml
(or any other filename) in your repository:

```yaml
development:
  adapter: postgresql
  host: localhost
  encoding: unicode
  pool: 10
  username: <%= ENV['PG_USER'] %>
  template: template1
  password: <%= ENV['PG_PASSWORD'] %>
  database: development<%= ENV['TEST_ENV_NUMBER'] %>
  port: 5432
  sslmode: disable
test:
  adapter: postgresql
  host: localhost
  encoding: unicode
  pool: 10
  username: <%= ENV['PG_USER'] %>
  template: template1
  password: <%= ENV['PG_PASSWORD'] %>
  database: test<%= ENV['TEST_ENV_NUMBER'] %>
  port: 5432
  sslmode: disable
```

Then in your setup commands run

```shell
cp codeship.database.yml YOUR_DATABASE_YAML_PATH
```

to copy the file wherever you need it.

If you don't use Rails and load the database.yml yourself you might see an error like the following:

```shell
PSQL::Error: Access denied for user '<%= ENV['PG_USER'] %>'@'localhost'
```

The database.yml example has ERB syntax in it so you need to load it by interpreting the ERB first:

```ruby
DATABASE_CONFIG = YAML.load(ERB.new(File.read("config/database.yml")))
```

## Django

```python
DATABASES = {
  'default': {
    'ENGINE': 'django.db.backends.postgresql_psycopg2',
    'NAME': 'test',
    'USER': os.environ.get('PG_USER'),
    'PASSWORD': os.environ.get('PG_PASSWORD'),
    'HOST': '127.0.0.1',
  }
}
```
