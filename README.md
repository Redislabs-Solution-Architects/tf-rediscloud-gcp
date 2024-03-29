# tf-rediscloud-gcp
Terraform provision a Redis Cloud subscription with GCP


Please follow the instructions with the Terrafrom Provider for Redis Cloud:
https://registry.terraform.io/providers/RedisLabs/rediscloud/latest/docs


Here are some prereqs to get you going:

# Prerequisites (detailed instructions)
1.  Download the `terraform` binary for your operating system ([link](https://www.terraform.io/downloads.html)), and make sure the binary is in your `PATH` environment variable.
    - MacOSX users:
        - (if you see an error saying something about security settings follow these instructions), ([link](https://github.com/hashicorp/terraform/issues/23033))
        - Just control click the terraform unix executable and click open. 
    - *you can also follow these instructions to install terraform* ([link](https://learn.hashicorp.com/tutorials/terraform/install-cli))

## Get your GCP account creds key:
To obtain Google Cloud service account credentials (often referred to as JSON key file) for your GCP project, follow these steps:

Navigate to the IAM & Admin page:
Sign in to your Google Cloud Console: https://console.cloud.google.com/
Then, click on the menu icon ☰ in the upper left corner and navigate to IAM & Admin > Service accounts.

Select your project:
Ensure that the correct project is selected from the project selector drop-down menu at the top of the page.

Either Create a new service account, or use an exisitng one:

Create a service account:

Click on the "+ CREATE SERVICE ACCOUNT" button.
Enter a name and description for the service account.
Click on the "CREATE" button.

Or use exisitng account:
Find exisitng, click the three dots in the actions column, manage keys, add key (export to json)

Now you have your keyfile.json
Go put that somewhere you will be able to get access to it.
"/path/to/your/keyfile.json"

## Get Redis Cloud API Keys
Follow these instructions
https://docs.redis.com/latest/rc/api/get-started/manage-api-keys/


# How To Use:
The terraform is very simple, not variables in this example, go fill in it in and spin it up!
This assumes you already have a Redis Cloud account.
The gcp_direct.tf has notes telling you to update values.