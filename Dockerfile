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

EXPOSE 8000

CMD ["dumb-init", "java", "-Djava.library.path=/app/DynamoDBLocal_lib/", "-jar", "DynamoDBLocal.jar", "-dbPath", "/app/dynamo_data"]
