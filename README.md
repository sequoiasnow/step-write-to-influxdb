# Write to InfluxDB

This is a simple step that allows easy writing of data to influx db
through the REST api.

## Example

To publish and updated coverage report

```yml
- write-to-influxdb:
    user: malcomreynolds
    password: flowerbonnet
    database: serenity
    port: 8086 # optional defaults to 8086
    timestamp: 1434055562000000000 #optional, defaults to now
    measurement: systems_working
    value: 0.4
    tags: 'series=firefly,ship=serentiy' # A simple string at the moment
```

Or use the data_binary to write manually

```yml
- write-to-influxdb:
    user: malcomreynolds
    password: flowerbonnet
    database: serenity
    port: 8086 # optional defaults to 8086
    data_binary: 'systems_working,series=firefly,ship=serenity value=0.4 1434055562000000000'
```
