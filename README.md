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

1) Return to the AWS Management Console

2) Navigate to AWS IoT

3) Click Manage and then click Register a Thing

4) Give your Thing a name and click Create Thing

#### Create a Thing Certificate

1) Click your Thing to view its details

2) Click Security

3) Click Create Certificate

4) Create an IoT Thing Certificate

5) Download the certificate, public key, private key, and the "Root CA for AWS IoT" (four files in total)

6) **Click Activate to activate your certificate** (if you miss this step, it won't work!)

#### Attach a Thing Policy

1) From your Thing's details screen, click Attach a Policy

2) Check the box next to the Policy that was created by Terraform (e.g. "thing")

3) Click Done

#### Create a Rule

1) Return to the AWS Management Console's AWS IoT home screen

2) Click Act

3) Click Create a Rule

4) Name your Rule (e.g. events)

5) Enter `*` for Attribute to match all events

6) Enter `events` as your Topic filter (if you choose another Topic name, be sure to change `gateway/config.js` in your Gateway app

7) Leave Condition blank

8) Click Add Action

9) Choose "Invoke a Lambda function passing the message data"

10) Click Configure Action

11) Choose your AWS IoT Lambda Function from the dropdown (i.e. `events` unless you changed it in Terraform)

12) Click Add Action

13) Review your Rule and click "Create Rule"

#### Configure your Gateway

1) On your computer, rename the certificate files you downloaded from AWS IoT and put them in your local Gateway app's `gateway/cert` folder. Refer to the `gateway/cert/*.example` files for the proper naming convention

2) Open `gateway/config.js` in your favorite text editor

3) Replace the `xxxxxxxx` values with your actual values from the AWS Management Console
  * You can find your AWS IoT host URI on the "Settings" cog on AWS IoT portal main screen

4) Save your changes to `gateway/config.js`

5) At the command line, run `npm start` to start your Gateway

### Create, configure, and start your local web app

1) Open a Terminal window, and navigate to the `app` folder of this repo

2) Run `yarn` to install the Node dependencies for the app

3) Make a copy of `app/.env.example` and name it `.env` (`.env.example` is a dotfile so it might be hidden by default on your computer)

4) Open `app/.env` in a text editor

5) Replace the `xxxxxxxxxxxx` values with your actual values from AWS
  * If you "edit" your Cognito Identity Pool, you can copy its ID from the AWS Management Console

6) Save your changes to `app/.env`

7) At the command line, run `npm run dev` to start the app

8) The local development server for the app should start and automatically launch the app at [http://localhost:9000](http://localhost:9000) in your default web browser

9) Create a new user account and password in your app's web UI (or log in with your existing Cognito credentials if you already have them)
  * By default, the Cognito Pre Sign-Up Trigger Lambda function requires that all users creating a new account use an email address with `@gmail.com` as the domain

10) Open your email, copy the verification code you received from Cognito, and submit it in your app's web UI

11) Finally, log into your app with the username and password you provided

12) The app should show incoming data from your Gateway
  * If the app doesn't work, make sure your `.env` variables are set correctly
  * If you do change your `.env` variables, stop and start the dev server to make sure your changes are applied

### Deploy your local web app to AWS S3


### TODO: Use Cloudflare or something to set up the DNS CNAME for your app hosted on S3
