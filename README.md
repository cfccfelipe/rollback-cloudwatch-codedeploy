# Rollback with CloudWatch and CodeDeploy

Flask application deployed through AWS CodePipeline to an EC2 Auto Scaling
group via CodeDeploy. Application health is monitored by the `ALBUnhealthy`
CloudWatch alarm, and the CodeDeploy deployment group automatically rolls back
to the last known good revision when the alarm fires.

## Pipeline stages

1. **Source** – GitHub repository (`main` branch)
2. **Build** – CodeBuild validates the Flask app and produces the deployment bundle
3. **Deploy** – CodeDeploy blue/green deployment to `cmtr-0oqfemca-asg`

## Application endpoints

- `/` – main page (`Hello from 0oqfemca!`)
- `/health` – ALB target group health check
- `/version` – running application version
