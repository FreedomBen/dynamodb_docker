FROM java:8

RUN mkdir -p /app/dynamo_data
WORKDIR /app

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.0.0/dumb-init_1.0.0_amd64.deb  
RUN dpkg -i dumb-init_*.deb  
RUN rm *.deb  

RUN useradd docker \
 && chown -R docker:docker /app

USER docker

RUN wget http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz
RUN tar -xzf dynamodb_local_latest.tar.gz
RUN rm dynamodb_local_latest.tar.gz

# Enable debug logging output
# See: http://stackoverflow.com/a/29525470/2062384
USER root
RUN apt-get update && \
  apt-get install zip

RUN zip -d DynamoDBLocal.jar log4j.properties
# there might be two of the existing properties files
# RUN zip -d DynamoDBLocal.jar log4j.properties

COPY log4j.properties /app
RUN zip -u DynamoDBLocal.jar log4j.properties

# cleanup!  https://www.dajobe.org/blog/2015/04/18/making-debian-docker-images-smaller/
RUN apt-get remove --purge -y zip && apt-get autoremove && \
  rm -rf /var/lib/apt/lists/*

USER docker

EXPOSE 8000

CMD ["dumb-init", "java", "-Djava.library.path=/app/DynamoDBLocal_lib/", "-jar", "DynamoDBLocal.jar", "-dbPath", "/app/dynamo_data"]
