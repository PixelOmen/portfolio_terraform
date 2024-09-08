
# Portfolio Infrastructure

The **Terraform** IaC configurations used to provision and manage the infrastructure for my Portfolio Project. The infrastructure is built on AWS, managing services like ECS, RDS, S3, CloudFront, and more. Reproducible and version-controlled, these configurations allow for reliable and manageble deployments to multiple environments used by the [front-end](https://github.com/PixelOmen/portfolio_site) and [back-end](https://github.com/PixelOmen/portfolio_api) of my Portfolio Project.

## Service Stack
- **AWS IAM**: Role-based access control for secure service-to-service interactions.
- **AWS VPC**: Configured with public and private subnets to securely isolate resources.
- **AWS ECR**: Secure, scalable container registry for storing and managing Docker images used by ECS.
- **AWS ECS**: Container orchestration service used to run the Django backend and Celery workers.
- **AWS RDS**: Relational database used for data storage and managed backups.
- **AWS S3**: Stores static files and user-uploaded content, integrated with CloudFront for CDN.
- **AWS CloudFront**: CDN used to serve the frontend and backend assets with low latency.
- **AWS Application Load Balancer**: Routes traffic to backend services, only exposed to CloudFront via custom headers.
- **AWS CloudWatch**: Used for monitoring logs, metrics, and setting alerts for performance and error tracking across the application.

## Infrastructure Overview
The following resources are provisioned by this Terraform setup, organized into reusable Terraform modules for scalability and modularity:

- **Terraform Modules**: Broken into reusable modules for multiple environments.
- **S3 Buckets**: Buckets for static files, user media, logs, configuration files, and Terraform states.
- **VPC**: Public/Private subnets, route tables, Internet Gateway, and NAT Gateway.
- **RDS**: Provides PostgreSQL database with security groups and managed snapshot backups.
- **ECS Services**: Dynamically scalable ECS tasks configured with Service Connect for communication within the cluster.
- **ECS Task Definitions**: Defines ECS tasks to communicate securely across services using dynamic port mappings.
- **Load Balancer**: Distributes traffic between services, only accept traffic from CloudFront using custom headers.
- **CloudFront Origins**: Configured to route to multiple origins, such as S3 for static assets and an ALB for backend API and WebSocket traffic.
- **CloudFront Behaviors**: Configured to manage different caching and routing rules based on path patterns.
- **CloudWatch Log Groups**: Dynamically created log groups for each ECS task.
- **SSL Certificates**: Dynamically parsed and attached to the CloudFront distribution and ALB.
- **Security Groups**: Dynamically created and attached to the ECS services, RDS, and ALB.
- **IAM Roles**: Dynamically created roles for ECS tasks, S3 access, and other AWS services.
- **IAM Policies**: Custom policies generated and assigned to AWS roles including Github deployment roles.

## License
[MIT](https://choosealicense.com/licenses/mit/)
