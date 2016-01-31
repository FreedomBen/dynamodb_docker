# Yet Another Dockerized Version Of Dynamo DB (YADVODDB)

Link to Docker Hub:  https://hub.docker.com/r/freedomben/dynamodb/

## Why this?

These are my reasons.  YMMV

1.  It's built on the official java docker version
1.  It downloads the latest Dynamo DB release straight from Amazon
1.  The tags are by date, which I find useful
1.  I control it so I know it will be just what Amazon provides and nothing else (except the java docker image of course)
1.  It's easy to run

## How to use this

### Installing/Running it locally using docker

#### If you just want the docker image (which is useful for composing into a larger project):

```
docker pull freedomben/dynamodb
```

You can pull a specific date if you want too (format is YYYYMMDD):

```
docker pull freedomben/dynamodb:20160126
```

#### As part of a docker-compose project

Add a line:

TODO

#### Easy stand-alone server to hit on localhost

Clone this repo:

```
git clone https://github.com/FreedomBen/dynamodb_docker.git
```

Fire it up:

```
docker-compose up
```

### Point your client at it

TODO

## Can I run it in production

No.  Performance on this is utterly, disastrously, terrible.  Use this for local development, but know that your database is dependent on AWS.
