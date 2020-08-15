# Architect Docker Image - (Ark)

This image is used to deploy architect projects in CI systems like Jenkins and Gitlab.

* NodeJS v12.18.3
* AWS CLI - v2.0.38
* @architect/architect version 6.5.4

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
stage('deploy') {
  environment {
    AWS_ACCESS_KEY_ID = credentials('aws-arc-key')
    AWS_SECRET_ACCESS_KEY = credentials('aws-arc-secret')
    AWS_DEFAULT_REGION = 'us-west-1'
    AWS_DEFAULT_OUTPUT = 'json'
  }
  steps {
    sh 'arc deploy'
  }
}
```

