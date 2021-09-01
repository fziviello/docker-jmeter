# Run Jmeter Collections Using Docker

In this example I have created a jmeter collection based on spotify.
To get a positive report you need to generate a new [Token](https://developer.spotify.com/console)
Write Spotify Token into CSV data.csv

[![docker-compose-actions-workflow](https://github.com/fziviello/docker-jmeter/actions/workflows/main.yml/badge.svg)](https://github.com/fziviello/docker-jmeter/actions/workflows/main.yml)

# Build Docker Image

```
docker build .
```

# Run and Generate report

```
docker-compose up
```
# Remove container after run

```
docker-compose rm -f
```
