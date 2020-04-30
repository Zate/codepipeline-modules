# Splunk Pipeline

Pipelines to deploy and manage Splunk [ infra, app, conf ]

## Requirements

- terraform >= 0.12
- terragrunt >= 0.23
- aws provider >= 2.50

## Architecture

- 3 code Commit Repos
  - infra (terraform)
    - VPC
      - sh_alb
      - hec_alb
      - s3 endpoint
      - splunk.infra domain
      - wombat.indeed.tech external domain
    - Services
      - sh
      - idx
      - ds
      - cm / bastion
      - hec
      - hf
  - app (ansible)
  - conf (splunk conf objects)
- 3 code Build pipelines
- 3 code pipelines

## Todo

- [ ] Build out Code Commit repos for each
- [ ] add Code Build Stage with checks
- [ ] Add to Code Pipeline for each
- [ ] Connect code commit repo to internal gitlab repos
- [ ] Profit.
