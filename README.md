# Architect Docker Image - (Ark)

This image is used to deploy architect projects in CI systems like Jenkins and Gitlab.

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

When working with Jenkins 2 using `Jenkinsfile` you can specify a docker container as an agent to 
your code.

```
pipeline {
  agent { docker { image 'hyper63/ark/v1' }}
}
```

The agent line will pull the ark image down and run it with your source code.

If you are using nodeJS you will want to setup npm to install global packages

```
pipeline {
  agent { docker { image 'hyper63/ark/v1' }}
  environment {
    HOME = '.'
    NPM_CONFIG_PREFIX="${pwd()}/.npm-global"
    PATH="$PATH:${pwd()}/.npm-global/bin:${pwd tmp: true}/.npm-global/bin"
  }
}

```

When using this image you need to create a folder `.aws` and create two files: `credentials, config` the credentials file will contain your `aws_access_key_id` and `aws_secret_access_key`, and the config file will contain `region` and `output`.  Here is a script that sets up these files using some environment variables.

```
steps {
  sh 'rm -rf ~/.aws && mkdir ~/.aws'
  sh 'echo "[default]" >> ~/.aws/credentials'
  sh 'echo "aws_access_key_id = ${AWS_ACCESS_KEY}" >> ~/.aws/credentials'
  sh 'echo "aws_secret_access_key = ${AWS_ACCESS_SECRET}" >> ~/.aws/credentials'
  sh 'echo "[default]" >> ~/.aws/config'
  sh 'echo "region = us-east-1" >> ~/.aws/config'
  sh 'echo "output = json" >> ~/.aws/config'

  sh 'arc deploy'
}

```

