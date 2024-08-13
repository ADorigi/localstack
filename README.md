# localstack
localstack configuration

1. [Install localstack](https://docs.localstack.cloud/getting-started/installation/) - we will use localstack cli with brew as follows

2. start localstack 

    > localstack start

3. clone this repo and use `pipenv shell` to open the python virtual environment.

4. `AWS_PROFILE=<localstack-profile> tflocal apply` to add the vpc to localstack
