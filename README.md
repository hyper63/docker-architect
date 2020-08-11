# ark

ark is a docker image that contains node v12, aws-cli, and @architect/architect 

## How to build the image

``` sh
docker image build .
docker tag [IMAGE ID] hyper63/ark:[version]
```

## Deploy to docker registry

``` sh
docker push hyper63/ark:[version]
```

## How to use the image in jenkins v2


