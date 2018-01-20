# aws-terraform-iot

> Use HashiCorp Terraform, AWS, Node, Webpack, and Vue to scaffold an example architecture for "internet of things" usage

## Getting Started

### Create and secure an AWS account

1) [Create an AWS account](https://aws.amazon.com/)
  * Note your AWS account ID (it should be a 12-digit number)

2) Sign into the AWS console using the AWS account you just created
  * This is your root AWS account

3) Secure your root AWS account with Multi-Factor Authentication
  1. Click your name in the header
  1. Click "Security Credentials"
  1. Follow the prompts to enable MFA and add an MFA device

4) Create an AWS Identity and Access Management admin user for yourself on your root AWS account
  1. Go to IAM
  1. Create a new user
  1. Enable "programmatic access" and "AWS Management Console" access for your new user
  1. Set a password for your new user
  1. Create an IAM group for your new user
    1. Name the group (e.g. `admin`)
    1. Add the `AdministratorAccess` IAM policy to the group
    1. Create the group, and add your user to the group
  1. Finish creating your new IAM user

5) Copy your new IAM user's Access Key ID and Secret Access Key

6) Put your AWS Access Key ID and Secret Access Key in a file on your computer at `~/.aws/credentials` using the following format:

```bash
# this file is located at ~/.aws/credentials

[default]
aws_access_key_id = XXXXXXXXXXXXXXXXXXXX
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

For more information, see [Configuring the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)

7) Secure your new IAM user with Multi-Factor Authentication
  1. In IAM, click on the user name
  1. Click the "Security Credentials" tab
  1. Click the edit icon for "Assigned MFA device"
  1. Follow the instructions for adding a new MFA device

8) Sign out of your root AWS account

9) Sign back into the AWS console using your AWS account number, new IAM user, password, and MFA code

### Set up all the things


### Prepare Terraform and run it for the first time


### Secure your API Gateway and run Terraform for the second time


### Deploy your API


### Configure your Cognito account creation trigger


### Create, configure, and start your local Gateway app


#### Create a Thing


#### Create a Thing Certificate


#### Attach a Thing Policy


#### Create a Rule


#### Configure your Gateway


### Create, configure, and start your local web app


### Deploy your local web app to AWS S3


### TODO: Use Cloudflare or something to set up the DNS CNAME for your app hosted on S3
