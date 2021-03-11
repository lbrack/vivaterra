# vivaterra
Some mocking around with Terraform. Right now this is a playground for 
Terraform and Terraform cloud and a place where I capture my experiments. 

Feel free to add your own or follow along. 

I also want to use the [GitHib Discussions](https://github.com/periscopai/vivaterra/discussions)
as much as possible.

## Setup

```shell
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

---

**Note** If you are using Pycharm, the Terraform plugin from Jetbrain is a must. 
Also make sure that you have you credentials install in ./aws/credentials.
If the profile is not **default**, ``export AWS_PROFILE=mario``
When using the plugin, simply type ``Ctrl-SpaceBar`` to bring up the 
auto completion. 

---

The Terraform [init](https://www.terraform.io/docs/cli/commands/init.html) initializes 
a working directory. This means that say, in a single respository, you could have 
multiple folders, each with independent HCL configuration files (HCL stands for HashiCorp 
Configuration Language - ``.tf`` extension). This is known as the ``Root Module``. This 
module normally contains an ``.terraform.lock.hcl`` which contains information about the 
(cloud) provider.

A [Terraform Module](https://www.terraform.io/docs/language/modules/index.html) is a collection
of tf file in a single directory.

Again, before you get started, make sure you AWS client is configured. 

```shell
    s3|main⚡ ⇒  aws configure                  
    AWS Access Key ID [****************VOMJ]: 
    AWS Secret Access Key [****************JMLd]: 
    Default region name [us-west-2]: 
    Default output format [yaml-stream]: 
```

You also want to set the profile environment variable (e.g. ``export AWS_PROFILE=laurent``)

Each of the sub-directories are Terraform (root) modules. Just follow along

* [s3](s3) - see [README](s3/README.md) is a super simple module that create a S3 bucket.
* [module_example](module_example) - [README](module_example/README.md) illustrates how 
  terraform modules are created and used by other modules, but creating a simple VPC.
  In addition to this, the module is linked to 
  [Terraform Cloud](https://app.terraform.io/app/periscopai/workspaces/vivaterra-module-examples/runs).
* [data-storage](tf-walkthru/data-storage) - The [README](tf-walkthru/data-storage/README.md) explain
  how data persistence is done via S3 bucket or Dynamo DB
* [vpc-networking](tf-walkthru/vpc-networking) - The [README](tf-walkthru/vpc-networking/README.md) 
  illustrates how a VPC is created.

# Userful Link

* [Info on Providers](https://www.terraform.io/docs/providers/index.html)
* [Full List Of Providers](https://registry.terraform.io/browse/providers)
* [AWS specific](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [HCL Specific Doc](https://www.terraform.io/docs/language/index.html)
* [HCL Variables](https://www.terraform.io/docs/language/values/variables.html)



