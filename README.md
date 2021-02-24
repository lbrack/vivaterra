# vivaterra
Some mocking around with Terraform

## Setup

```console
vivaterra|main⚡ ⇒  brew install tfenv
vivaterra|main⚡ ⇒  tfenv install
vivaterra|main⚡ ⇒  tfenv use 0.14.7 # Or whatever version was installed
vivaterra|main⚡ ⇒  terraform init  

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v3.29.1...
- Installed hashicorp/aws v3.29.1 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

```

----
Note
    If you are using Pycharm, the Terraform plugin from Jetbrain is a must. 
    Also make sure that you have you credentials install in ./aws/credentials.
    If the profile is not **default**, ``export AWS_PROFILE=mario``
----

## Creating an S3 bucket

* [s3.tf](s3.tf)

```console
vivaterra|main⚡ ⇒  terraform apply
...
aws_s3_bucket.bucket_list: Creating...
aws_s3_bucket.bucket_list: Creation complete after 4s [id=fakayu-bucket-list]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

```






