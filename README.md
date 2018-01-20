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

1) [Install Terraform](https://www.terraform.io/downloads.html)

2) [Install Node](https://nodejs.org/) (version 8 or greater)

3) [Install Yarn](https://yarnpkg.com/)

4) [Install Git](https://git-scm.com/) or [GitHub Desktop](https://desktop.github.com/) (which installs Git by default)

5) Create a [GitHub](https://github.com/) account (if you don't have one already)

6) Install the [AWS Command Line Interface](https://aws.amazon.com/documentation/cli/)
  * The easiest way to do this on macOS is with [Homebrew](https://brew.sh/)
    1. First, install Homebrew on your Mac by running this command in Terminal: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
    1. Then, install the AWS CLI by running this command: `brew install awscli`

### Prepare Terraform and run it for the first time

1) Clone this repo by running this command in Terminal:

```bash
git clone git@github.com:thegreatsunra/aws-terraform-iot.git
```

2) Make a copy of `terraform/config.tf.example` and name it `config.tf`

3) Edit the values in the first section of `terraform/config.tf` to match your own AWS Account ID, target AWS region, and your "company name"
  * "Company name" is used in Cognito email templates for user account confirmations and messages
  * If your computer has multiple AWS profiles configured in `~/.aws/credentials`, change the `default` value for `aws_profile` to the name of the profile you want to use
  * Change the value for `s3_web_app` to the domain (and subdomain, if applicable) you want to use for hosting your web app
    * Note that this value must be unique, and cannot be the same as any other S3 bucket in the whole world
    * Change the value for `s3_cloudtrail` to a random (but recognizable by you) value that is unique, and will not be the same as any other S3 bucket in the whole world
  * Don't touch the values for `authorizer_id`, `authorization`, or `cognito_app_client_id` yet; we'll change those after we finish our first run of the `terraform apply` script

4) Save your changes to `terraform/config.tf`

5) Open a Terminal window and navigate to your project's `terraform` folder

6) At the command line, run this command to initialize your Terraform scripts and install all dependencies:

```bash
terraform init
```

7) Run this command to "plan" the execution of your Terraform scripts, and calculate how they will affect your AWS environment when applied:

```bash
terraform plan
```

8) Run this command to "apply" your Terraform scripts to your AWS environment, and reply `yes` when prompted:

```bash
terraform apply
```

Your architecture should now be deployed on your AWS account!

Now we have some manual work to do.

### Secure your API Gateway and run Terraform for the second time

1) Copy the Authorizer ID value that is outputted by `terraform apply` and replace the placeholder `authorizer_id` value in `terraform/config.tf` with it

2) In `terraform/config.tf` change the `authorization` value from `NONE` to `COGNITO_USER_POOLS`

3) Log in to the AWS Management Console using your IAM admin user, and make sure you are in the AWS region (e.g. `us-east-1`) where Terraform deployed your architecture

4) In the AWS Management Console, navigate to Cognito

5) Click to manage your User Pools

6) Click the User Pool created by Terraform

7) Under General Settings, click App Clients

8) Add a new App Client

9) Name your App Client

10) **Uncheck App Client Secret** (if App Client Secret is checked, your web app hosted on S3 will not work)

11) Create your new App Client, and copy its App Client ID

12) In `terraform/config.tf` change the placeholder value for `cognito_app_client_id` to your new App Client ID from Cognito

13) At the command line, navigate to your project's `terraform` folder and run `terraform plan`

14) Run `terraform apply` and reply `yes` when prompted

### Deploy your API

1) In the AWS Management Console, navigate to API Gateway

2) Choose the API Gateway created by Terraform (if you didn't rename it, it's probably called "Api")

3) Click Actions and click "Deploy to Stage"

4) Choose "Prod" as your stage

5) Deploy your API

6) Copy the Deploy URL for your API (you'll add it to your web app later)

7) Access to your API should now be secured with Cognito

### Configure your Cognito Pre Sign-Up Trigger

This step is necessary because there's a bug between Terraform and the AWS Management Console, where even though a Lambda function _appears_ selected in the Triggers UI, it isn't.

1) In the AWS Management Console, navigate to Cognito

2) Open your User Pool

3) Go to Triggers, and change the Pre Sign-Up Lambda function to "None" (even if it's already set to "Cognito")

4) Scroll down and click "Save Changes"

5) Go _back_ to Triggers, and change the Pre Sign-Up Lambda function _back_ to Cognito

6) Scroll down and click "Save Changes"

7) When a user creates a new account, they will now "trigger" the "Cognito" Lambda function

### Create, configure, and start your local Gateway app

1) Open a Terminal window, and navigate to the `gateway` folder of this repo

3) Run `yarn` to install the Node dependencies for the Gateway

2) Make a copy of `gateway/config.example.js` and name it `config.js`

#### Create a Thing


#### Create a Thing Certificate


#### Attach a Thing Policy


#### Create a Rule


#### Configure your Gateway

1) On your computer, rename the certificate files you downloaded from AWS IoT and put them in your local Gateway app's `gateway/cert` folder. Refer to the `gateway/cert/*.example` files for the proper naming convention

2) Open `gateway/config.js` in your favorite text editor

3) Replace the `xxxxxxxx` values with your actual values from the AWS Management Console
  * You can find your AWS IoT host URI on the "Settings" cog on AWS IoT portal main screen

4) Save your changes to `gateway/config.js`

5) At the command line, run `npm start` to start your Gateway

### Create, configure, and start your local web app


### Deploy your local web app to AWS S3


### TODO: Use Cloudflare or something to set up the DNS CNAME for your app hosted on S3
