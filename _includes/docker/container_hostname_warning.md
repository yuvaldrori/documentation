When accessing other containers please be aware that those services do not run on
localhost, but on a different hostname, e.g. "postgres" or "mysql". If you reference
localhost in any of your configuration files you have to change that to point to the
hostname of the service you want to access. Setting them through environment variables
and using those inside of your configuration files is the cleanest approach to setting
up your build environment.
