# Terraform Commands — Complete Reference Guide

---

## 1. Initialization Commands

Initialize Terraform and download all required providers/plugins.

```hcl
terraform init
```

Upgrade providers and modules to the latest version.

```hcl
terraform init -upgrade
```

Reconfigure backend (used when backend settings change).

```hcl
terraform init -reconfigure
```

Load backend config from an external file.

```hcl
terraform init -backend-config="backend.hcl"
```

Migrate local state to a remote backend.

```hcl
terraform init -migrate-state
```

Copy existing state even if backend differs.

```hcl
terraform init -force-copy
```

Initialize only local modules, ignores backend.

```hcl
terraform init -backend=false
```

Forces backend recheck after S3/DynamoDB issues.

```hcl
terraform init -backend=true
```

Skips plugin verification (rarely used).

```hcl
terraform init -verify-plugins=false
```

Uses existing lockfile only; avoids modifying provider lock file.

```hcl
terraform init -upgrade -lockfile=readonly
```

---

## 2. Code Validation & Formatting

Format Terraform code into standard style.

```hcl
terraform fmt
```

Format code inside all subfolders.

```hcl
terraform fmt -recursive
```

Check if files are properly formatted.

```hcl
terraform fmt -check
```

Show formatting differences before applying them.

```hcl
terraform fmt -diff
```

Check syntax and identify configuration errors.

```hcl
terraform validate
```

Validate configuration without colored output (for CI/CD pipelines).

```hcl
terraform validate -no-color
```

---

## 3. Plan Commands

Show what Terraform will create/update/destroy (dry run).

```hcl
terraform plan
```

Save the plan to a file for later use.

```hcl
terraform plan -out=plan.tf
```

Use variables from a specific file.

```hcl
terraform plan -var-file="dev.tfvars"
```

Plan actions only for a specific resource.

```hcl
terraform plan -target=aws_instance.web
```

Show only drift (changes outside Terraform).

```hcl
terraform plan -refresh-only
```

Stop Terraform from asking for variable input.

```hcl
terraform plan -input=false
```

Show what will be destroyed without destroying.

```hcl
terraform plan -destroy
```

Export the full plan output in JSON format (used in automation & policy checks).

```hcl
terraform plan -json > plan.json
```

Prevent prompting for variables during automation (accurate CI runs).

```hcl
terraform plan -input=false -lock=true
```

Run plan with only 1 parallel operation (useful for debugging race issues).

```hcl
terraform plan -parallelism=1
```

---

## 4. Apply Commands

Apply the changes to infrastructure.

```hcl
terraform apply
```

Apply changes without asking for confirmation.

```hcl
terraform apply -auto-approve
```

Apply a saved plan file.

```hcl
terraform apply plan.tf
```

Apply changes without checking real cloud state.

```hcl
terraform apply -refresh=false
```

Controls number of parallel resource operations.

```hcl
terraform apply -parallelism=20
```

Slow down apply to debug dependency issues.

```hcl
terraform apply -parallelism=1
```

---

## 5. Destroy Commands

Destroy all created resources.

```hcl
terraform destroy
```

Destroy resources without confirmation.

```hcl
terraform destroy -auto-approve
```

Destroy only a specific resource.

```hcl
terraform destroy -target=aws_s3_bucket.bucket
```

Destroy only the selected module.

```hcl
terraform destroy -target=module.vpc
```

---

## 6. State File Commands

List all resources in the state file.

```hcl
terraform state list
```

List resources in sorted order.

```hcl
terraform state list | sort
```

Show full details of a resource stored in the state.

```hcl
terraform state show <resource>
```

Remove a resource from the state file (Terraform stops managing it).

```hcl
terraform state rm <resource>
```

Move or rename a resource inside the state file.

```hcl
terraform state mv <old> <new>
```

Move a resource between modules.

```hcl
terraform state mv module.old.aws_instance.web module.new.aws_instance.web
```

Replace a provider in the state file.

```hcl
terraform state replace-provider <old> <new>
```

Used when the provider namespace changes (e.g., from legacy to official).

```hcl
terraform state replace-provider
```

Download the latest state file.

```hcl
terraform state pull
```

Upload a state file manually.

```hcl
terraform state push
```

Export state to JSON file.

```hcl
terraform state pull > state.json
```

Import state into new backend.

```hcl
terraform state push state.json
```

---

## 7. Import Commands

Add an existing AWS resource into Terraform state.

```hcl
terraform import <resource> <id>
```

**Example:**

```hcl
terraform import aws_instance.myec2 i-0123456
```

---

## 8. Output Commands

Show Terraform output values.

```hcl
terraform output
```

Display a specific output.

```hcl
terraform output public_ip
```

Print sensitive output without quotes.

```hcl
terraform output -raw password
```

Print output without formatting.

```hcl
terraform output -raw vpc_id
```

Read output values from a specific state file.

```hcl
terraform output -state=state.tfstate
```

---

## 9. Variable Commands

Pass a variable directly through CLI.

```hcl
terraform apply -var="env=dev"
```

Use a full variable file during apply.

```hcl
terraform apply -var-file="prod.tfvars"
```

---

## 10. Workspace Commands

Show all workspaces.

```hcl
terraform workspace list
```

Create a new workspace.

```hcl
terraform workspace new dev
```

Switch to a workspace.

```hcl
terraform workspace select dev
```

Delete a workspace.

```hcl
terraform workspace delete dev
```

Create workspace and allow variable overrides.

```hcl
terraform workspace new prod --
```

---

## 11. Providers & Modules

Download Terraform modules.

```hcl
terraform get
```

Refresh modules to the latest version.

```hcl
terraform get -update
```

List all providers in use.

```hcl
terraform providers
```

Display provider schema and arguments.

```hcl
terraform providers schema
```

Output provider documentation schema in JSON.

```hcl
terraform providers schema -json > schema.json
```

Parse provider schema (advanced automation use).

```hcl
terraform providers schema -json | jq
```

---

## 12. Dependency Graph

Generate a visual dependency graph (used for debugging infra relationships).

```hcl
terraform graph
```

Create a visual dependency map (great for documentation).

```hcl
terraform graph | dot -Tsvg > graph.svg
```

---

## 13. Debugging & Logging

Enable detailed Terraform logs.

```bash
export TF_LOG=DEBUG
```

Enable detailed provider-level debug logs.

```bash
export TF_LOG_PROVIDER=TRACE
```

Show detailed refresh logic.

```bash
TF_LOG=TRACE terraform refresh
```

Turn off logging.

```bash
unset TF_LOG
```

---

## 14. Locking & Force Unlock

Unlock the state file if Terraform gets stuck (only when safe).

```hcl
terraform force-unlock <lock-id>
```

Release a locked state manually (when previous apply is stuck).

```hcl
terraform force-unlock <LOCK_ID>
```

Identify active state locks.

```hcl
terraform show | grep "lock"
```

Run apply without taking a state lock (not recommended in teams).

```hcl
terraform apply -lock=false
```

---

## 15. Refresh Commands

Update the state file with real-world resource values.

```hcl
terraform refresh
```

Show only drift (changes outside Terraform).

```hcl
terraform plan -refresh-only
```

---

## 16. Replace Resource Commands

Destroy and recreate a specific resource.

```hcl
terraform apply -replace="aws_instance.web"
```

Force recreation of the entire resource.

```hcl
terraform apply -replace="aws_security_group.sg"
```

---

## 17. Taint Commands *(Deprecated but asked in interviews)*

Mark a resource to be destroyed and recreated in the next apply.

```hcl
terraform taint aws_instance.web
```

Remove taint from a resource.

```hcl
terraform untaint aws_instance.web
```

---

## 18. Show Commands

Display the current state or plan.

```hcl
terraform show
```

Show state/plan output in JSON.

```hcl
terraform show -json
```

Convert the Terraform state into JSON format.

```hcl
terraform show -json > state.json
```

Convert saved plan to JSON.

```hcl
terraform show -json plan.tfplan > plan.json
```

Convert configuration to JSON (useful for automation and compliance scanners).

```hcl
terraform show -json > config.json
```

---

## 19. Graph Commands

Generate a dependency graph in DOT format.

```hcl
terraform graph
```

---

## 20. Format Check

Check if files are properly formatted.

```hcl
terraform fmt -check
```

---

## 21. Login Commands (Terraform Cloud)

Log into Terraform Cloud.

```hcl
terraform login
```

Log out from Terraform Cloud.

```hcl
terraform logout
```

---

## 22. Environment Variables

Pass a Terraform variable through environment.

```bash
export TF_VAR_region=us-east-1
```

Remove an environment variable.

```bash
unset TF_VAR_region
```

Pass backend values from CLI.

```bash
terraform init -backend-config="bucket=mybucket"
```

Load env variables as Terraform vars.

```bash
set -a; source dev.env; set +a
```

---

## 23. Provider Lock File

Create a dependency lock file to ensure consistent provider versions.

```hcl
terraform providers lock
```

Lock providers for specific platforms (CI/CD).

```hcl
terraform providers lock -platform=linux_amd64
```

---

## 24. Provider Mirror

Download provider binaries locally for offline use or air-gapped environments.

```hcl
terraform providers mirror ./providers
```

Create a local mirror of all providers (for restricted networks).

```hcl
terraform providers mirror .
```

---

## 25. Terraform Version

Show Terraform version and installed provider versions.

```hcl
terraform version
```

---

## 26. Install Specific Terraform Version (tfenv)

> `tfenv` must be installed first.

Install a specific Terraform version.

```bash
tfenv install 1.6.0
```

Switch to that version.

```bash
tfenv use 1.6.0
```

---

## 27. Sync Remote State

Push your local state to remote backend.

```hcl
terraform state push
```

Download the latest remote state.

```hcl
terraform state pull
```

---

## 28. Clean Local Cache

Delete local Terraform directory and plugin cache.

```bash
rm -rf .terraform/
```

Delete cached plugins to force a clean provider download.

```bash
rm -rf .terraform/plugins
```

Fully wipe local Terraform environment.

```bash
rm -rf .terraform/ .terraform.lock.hcl
```

Reset directory to fresh Terraform environment.

```bash
rm -rf .terraform*
```

---

## 29. Backup State File

Create a local backup before risky operations.

```bash
cp terraform.tfstate terraform.tfstate.backup
```

---

## 30. Plan Filtering (Grep Shortcuts)

Show only resources Terraform will **create**.

```bash
terraform plan | grep "+"
```

Show only resources Terraform will **destroy**.

```bash
terraform plan | grep "-"
```

Show only resources Terraform will **modify**.

```bash
terraform plan | grep "~"
```

---

## 31. Compare Two State Files

Compare two states side-by-side (Linux only).

```bash
diff <(terraform show -json state1.tfstate) <(terraform show -json state2.tfstate)
```

---

## 32. Apply Specific Modules

Apply only the EKS module.

```hcl
terraform apply -target=module.eks
```

---

## 33. CI/CD Workflow

Common CI validation before apply.

```bash
terraform validate && terraform plan
```

---

## 34. Module Management

Clean unused modules and update module references.

```hcl
terraform mod tidy
```

---

## 35. Policy Checks (Sentinel & OPA)

Generate plan JSON for Sentinel & OPA policy checks.

```hcl
terraform plan -json > plan.json
```

---

## Quick Reference Summary Table

| #  | Command | Purpose |
|----|---------|---------|
| 1  | `terraform init` | Initialize and download providers |
| 2  | `terraform init -upgrade` | Upgrade providers to latest |
| 3  | `terraform init -reconfigure` | Reconfigure backend |
| 4  | `terraform fmt` | Format code to standard style |
| 5  | `terraform fmt -recursive` | Format all subfolders |
| 6  | `terraform fmt -check` | Check formatting without changing |
| 7  | `terraform validate` | Check syntax errors |
| 8  | `terraform plan` | Dry run — preview changes |
| 9  | `terraform plan -out=plan.tf` | Save plan to file |
| 10 | `terraform plan -refresh-only` | Show drift only |
| 11 | `terraform plan -destroy` | Preview destroy |
| 12 | `terraform plan -json > plan.json` | Export plan as JSON |
| 13 | `terraform apply` | Apply changes to infra |
| 14 | `terraform apply -auto-approve` | Apply without confirmation |
| 15 | `terraform apply -replace="<res>"` | Force recreate resource |
| 16 | `terraform apply -parallelism=20` | Control parallel operations |
| 17 | `terraform destroy` | Destroy all resources |
| 18 | `terraform destroy -target=<res>` | Destroy specific resource |
| 19 | `terraform state list` | List all tracked resources |
| 20 | `terraform state show <res>` | Show resource details |
| 21 | `terraform state rm <res>` | Remove resource from state |
| 22 | `terraform state mv <old> <new>` | Move/rename resource in state |
| 23 | `terraform state pull` | Download remote state |
| 24 | `terraform state push` | Upload local state |
| 25 | `terraform import <res> <id>` | Import existing resource |
| 26 | `terraform output` | Show output values |
| 27 | `terraform output -raw <name>` | Print raw output value |
| 28 | `terraform workspace list` | List all workspaces |
| 29 | `terraform workspace new <name>` | Create new workspace |
| 30 | `terraform workspace select <name>` | Switch workspace |
| 31 | `terraform workspace delete <name>` | Delete workspace |
| 32 | `terraform get` | Download modules |
| 33 | `terraform providers` | List providers in use |
| 34 | `terraform providers lock` | Create dependency lock file |
| 35 | `terraform providers mirror ./dir` | Mirror providers locally |
| 36 | `terraform graph` | Generate dependency graph |
| 37 | `terraform refresh` | Sync state with real infra |
| 38 | `terraform show` | Display current state/plan |
| 39 | `terraform show -json` | Show state/plan in JSON |
| 40 | `terraform taint <res>` | Mark resource for recreation |
| 41 | `terraform untaint <res>` | Remove taint from resource |
| 42 | `terraform force-unlock <id>` | Unlock stuck state |
| 43 | `terraform login` | Log in to Terraform Cloud |
| 44 | `terraform logout` | Log out from Terraform Cloud |
| 45 | `terraform version` | Show Terraform version |
| 46 | `export TF_LOG=DEBUG` | Enable debug logging |
| 47 | `export TF_VAR_<name>=<value>` | Set variable via environment |
| 48 | `tfenv install <ver>` | Install specific TF version |
| 49 | `tfenv use <ver>` | Switch Terraform version |
| 50 | `terraform validate && terraform plan` | CI validation workflow |
