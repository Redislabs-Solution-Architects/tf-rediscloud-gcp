terraform {
  required_providers {
    rediscloud = {
     source = "RedisLabs/rediscloud"
     version = "1.5"
     }
    google = {
      source = "hashicorp/google"
    }
  }
}

#### UPDATE THESE VALUES
provider "google" {
  project = "my-project-id" # project ID
  region  = "us-central1"  # Change to your desired region
  credentials = file("/path/to/your/keyfile.json")
}

#### UPDATE THESE VALUES
#### Configure the rediscloud provider:
#### go to your Redis Cloud Account >  Access Managment > API Keys > 
#### create new API Key (this gives you the secret key, the API_key is the API account key)
provider "rediscloud" {
    api_key = "my-api-key-creds"
    secret_key = "my-secret-key"
}

################

######## Redis Cloud Account Information
####### Used in the terraform modules
data "rediscloud_cloud_account" "account" {
  exclude_internal_account = true
}

output "rc_cloud_account_id" {
  value = data.rediscloud_cloud_account.account.id
}

output "rc_cloud_account_provider_type" {
  value = data.rediscloud_cloud_account.account.provider_type
}

output "cloud_account_access_key_id" {
  value = data.rediscloud_cloud_account.account.access_key_id
}

#### UPDATE THIS IF IT IS NOT VISA
data "rediscloud_payment_method" "card" {
  card_type = "Visa"
}

############ Create Redis Cloud Subscription

resource "rediscloud_subscription" "subscription-resource" {

  name = "tf-subscription-name"
  payment_method = "credit-card"
  payment_method_id = data.rediscloud_payment_method.card.id
  memory_storage = "ram"

  cloud_provider {
    provider = "GCP"
    region {
      region = "us-central1"
      multiple_availability_zones = true
      networking_deployment_cidr = "192.168.88.0/24"
    }
  }

  // This block needs to be defined for provisioning a new subscription.
  // This allows creation of a well-optimized hardware specification for databases in the cluster
  creation_plan {
    memory_limit_in_gb = 15
    quantity = 1
    replication= true
    throughput_measurement_by = "operations-per-second"
    throughput_measurement_value = 20000
    modules = ["RedisJSON"]
  }
}


############ Subscription DB

// The primary database to provision
resource "rediscloud_subscription_database" "database-resource" {
    subscription_id = rediscloud_subscription.subscription-resource.id
    name = "database-name"
    memory_limit_in_gb = 15
    data_persistence = "aof-every-write"
    throughput_measurement_by = "operations-per-second"
    throughput_measurement_value = 20000
    replication = true

    modules = [
        {
          name = "RedisJSON"
        }
    ]

    alert {
      name = "dataset-size"
      value = 40
    }
    depends_on = [rediscloud_subscription.subscription-resource]

}