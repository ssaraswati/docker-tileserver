### Build
docker build -t docker-tileserver:latest .

### Ci
AWS Cloudformation template for CodePipeline template provided that creates an ECR repository and CodeBuild project to build the docker image on commit from a github repository and store built image in ECR