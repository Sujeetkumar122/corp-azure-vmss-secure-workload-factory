# Corporate Azure VMSS Secure Workload Factory

## Overview
This repository provides an enterprise **Secure Autoscaling Workload Architecture** using Terraform. It provisions multi-instance Linux Virtual Machine Scale Sets (VMSS) placed behind Standard Internal Load Balancers with dedicated health probes, isolated inside secure VNet subnets, with Key Vault credentials retrieved dynamically via Terraform `data` blocks.

## Repository Architecture
```text
corp-azure-vmss-secure-workload-factory/
├── .gitignore
├── .tflint.hcl                     # Enterprise TFLint Azure ruleset
├── README.md                       # Architecture & operational runbook
├── environments/                   # Multi-Environment Parent Orchestrations
│   ├── dev/
│   │   ├── checks.tf               # Terraform 1.5+ assert & check blocks
│   │   ├── data.tf                 # Data blocks for Key Vault secret ingestion
│   │   ├── main.tf                 # Parent module orchestration with for_each
│   │   ├── outputs.tf              # Structured outputs
│   │   ├── provider.tf             # AzureRM provider configuration
│   │   ├── terraform.tfvars        # Dev configuration values
│   │   └── variables.tf            # Typed map(object({...})) variable contracts
│   └── prod/
│       ├── checks.tf               # Production HA & compliance validations
│       ├── data.tf
│       ├── main.tf
│       ├── outputs.tf
│       ├── provider.tf
│       ├── terraform.tfvars        # Production HA values (4x VMSS, D4s_v5, Premium KV)
│       └── variables.tf
└── modules/                        # Reusable Child Modules
    ├── azurerm_key_vault/
    ├── azurerm_lb/
    ├── azurerm_linux_virtual_machine_scale_set/
    ├── azurerm_resource_group/
    └── azurerm_virtual_network/
```

## Features
- **Data Block Pattern**: Key Vault secrets and client configurations ingested dynamically using `data "azurerm_key_vault"` and `data "azurerm_key_vault_secret"`.
- **High-Availability Compute**: VMSS instances are automatically registered with Load Balancer backend address pools for seamless scaling.
- **Pure HCL Guardrails**: Guardrails implemented via native `check` / `assert` blocks and `.tflint.hcl` without external scripts.
- **Enterprise Standards**: Strictly typed `map(object({...}))`, dynamic iterations using `for_each`, and multi-environment configuration.


## Architecture Review & Operational Checklist
- Workload security posture audited.
- Load balancer health probe verified with HTTP 200 status.
