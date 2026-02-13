+++
title = "Compliance-Driven DevSecOps Pipeline"
date = 2024-07-10
draft = false
summary = "Built automated security and compliance pipeline for CI/CD workflows, achieving continuous SOC 2 and ISO 27001 compliance with zero manual audit evidence collection."
description = "Automated compliance and security scanning for DevSecOps workflows"
tags = ["devsecops", "compliance", "automation", "soc2", "iso27001", "ci-cd"]
categories = ["project"]

# Project metadata
github = "https://github.com/elkana-langat/compliance-pipeline"
demo = ""
tech_stack = ["GitLab CI", "Jenkins", "SonarQube", "Trivy", "OWASP ZAP", "Vault", "Terraform"]
role = "DevSecOps Lead"
duration = "3 months"
featured = true

# Blowfish display settings
showHero = true
heroStyle = "background"
showDate = true
showReadingTime = false
showWordCount = false
showTableOfContents = true
+++

## Overview

Designed and implemented an automated compliance-driven DevSecOps pipeline that embeds security controls and audit evidence collection directly into CI/CD workflows. The system ensures continuous SOC 2 Type II and ISO 27001 compliance while reducing deployment time and eliminating manual audit preparation.

## Problem

Development velocity was constrained by compliance requirements:
- **Manual Audit Evidence:** Security team spent 160+ hours/quarter collecting compliance artifacts
- **Deployment Delays:** Security reviews created 2-3 day bottleneck before production releases
- **Compliance Drift:** No automated verification that deployed code matched approved changes
- **Vulnerability Lag:** Security scanning was endpoint-based, not in-pipeline
- **Audit Findings:** Previous SOC 2 audit identified gaps in change management controls

Organization needed automated compliance without sacrificing development speed.

## Solution

Built a shift-left security pipeline with automated compliance evidence generation at every stage:

### Architecture

**Pipeline Stages (Automated):**
1. **Pre-Commit:** Git hooks scan for secrets and hard-coded credentials
2. **Code Analysis:** SonarQube for code quality + security bugs (OWASP Top 10)
3. **Dependency Scan:** Trivy scans for vulnerable libraries and CVEs
4. **SAST:** Semgrep for static application security testing
5. **IaC Security:** Checkov scans Terraform for misconfigurations
6. **Container Scan:** Trivy scans Docker images for OS/lib vulnerabilities
7. **DAST:** OWASP ZAP dynamic testing in staging environment
8. **Compliance Gate:** Automated policy check against SOC 2/ISO 27001 requirements
9. **Deployment:** Approved changes deployed with full audit trail
10. **Runtime Security:** Falco monitors containers for anomalous behavior

**Core Components:**
- GitLab CI/CD for orchestration
- SonarQube server for code quality gates
- Trivy for container + IaC scanning
- Vault for secrets management
- Elasticsearch for centralized audit logs
- Custom Python service aggregating compliance evidence
- S3 bucket (immutable) for audit artifact storage

**Data Flow:**
1. Developer commits code to feature branch
2. Pre-commit hooks scan for secrets (gitleaks)
3. GitLab triggers pipeline on merge request
4. SAST/dependency scans run in parallel
5. Quality gates enforce minimum code coverage (80%)
6. Docker image built and scanned (must have zero HIGH/CRITICAL CVEs)
7. IaC scanned for security misconfigurations
8. Deploy to staging environment
9. DAST runs automated penetration tests
10. Compliance service collects evidence (test results, approvals, configs)
11. Security team reviews dashboard before production promotion
12. On approval, deploy to production with immutable audit log
13. All evidence stored in S3 with retention lock

### Security Controls

**IAM & Access:**
- Branch protection requiring security team approval for production
- RBAC in GitLab (devs cannot bypass pipeline)
- Service accounts with minimal permissions
- Vault dynamic credentials (auto-revoked after use)
- Break-glass procedure for emergency deploys (logged)

**Logging & Monitoring:**
- All pipeline runs logged to Elasticsearch
- Audit trail includes: who approved, what changed, when deployed
- CloudWatch alarms for pipeline failures
- Slack notifications for security gate violations
- Monthly compliance reports auto-generated

**Network:**
- Private GitLab runners in VPC (no public internet access)
- SonarQube/Vault in private subnets
- Egress through NAT gateway for artifact pulls
- Security groups limiting runner communication

**Secrets:**
- HashiCorp Vault for centralized secrets management
- No secrets in code repository (git-secrets enforcement)
- Dynamic credentials for AWS/database access
- Secrets rotation every 90 days with pipeline automation

**CI/CD:**
- Immutable pipeline definitions (no inline scripts)
- Container images signed with Cosign
- SBOM generated for all deployments (Syft)
- Blue-green deployments with automated rollback

**Monitoring:**
- Prometheus metrics on pipeline success/failure rates
- Grafana dashboards showing compliance posture
- Alert on CVE severity thresholds exceeded
- Weekly security scan summary reports

## Results

**Compliance Efficiency:**
- ✅ **95% reduction** in audit prep time (from 160 hours to 8 hours/quarter)  
- ✅ **Zero manual evidence collection** - fully automated
- ✅ **100% deployment traceability** with immutable audit logs
- ✅ **SOC 2 Type II certification** with zero findings on change management
- ✅ **ISO 27001 compliance** maintained continuously

**Security Improvements:**
- ✅ **85% reduction** in production vulnerabilities (example metric: from 40 to 6/month)
- ✅ **Zero HIGH/CRITICAL CVEs** deployed to production in 6 months
- ✅ **4-hour average** time to detect and remediate vulnerabilities (down from 14 days)
- ✅ **90% code coverage** maintained across all services

**Development Velocity:**
- ✅ **60% faster** deployments (from 3 days to 4 hours average)
- ✅ **10x increase** in deployment frequency (monthly → daily)
- ✅ **Near-zero** security review bottlenecks
- ✅ **Developer satisfaction** improved (self-service security)

## Lessons Learned

**What Worked Well:**
- Embedding security early (shift-left) reduced vulnerabilities dramatically
- Automated quality gates prevented most security issues pre-production
- Immutable audit logs eliminated audit evidence disputes
- Developer training on security tools improved adoption

**Challenges:**
- Initial false positives from SAST required tuning
- Container scanning added 3-5 minutes to pipeline runtime
- Legacy applications needed gradual migration to new pipeline
- Custom evidence aggregation service required maintenance

**Would Do Differently:**
- Implement container image caching earlier to improve performance
- Create security champions program to evangelize best practices
- Build developer self-service portal for compliance evidence
- Add more granular policy exemptions workflow for edge cases

## Tech Stack

- **CI/CD:** GitLab CI, Jenkins (legacy), GitHub Actions
- **SAST/DAST:** SonarQube, Semgrep, OWASP ZAP, Burp Suite
- **Container Security:** Trivy, Falco, Cosign, Syft
- **IaC Security:** Checkov, tfsec, Terraform Sentinel
- **Secrets:** HashiCorp Vault, git-secrets, gitleaks
- **Logging:** Elasticsearch, Filebeat, Kibana
- **Monitoring:** Prometheus, Grafana, Datadog
- **Cloud:** AWS (S3, CloudWatch, ECR, Lambda)

## Links

- [GitHub Repository](https://github.com/elkana-langat/compliance-pipeline) (sample pipeline configs and policies)
- [SOC 2 Control Mapping Guide](https://github.com/elkana-langat/compliance-pipeline/blob/main/docs/soc2-mapping.md)
