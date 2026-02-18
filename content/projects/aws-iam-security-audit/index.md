+++
title = "Automating AWS IAM Security Audits"
date = 2026-02-18
draft = false
summary = "A Python-based IAM audit tool that programmatically reviews AWS IAM users to surface stale console access and active programmatic keys—using least-privilege, profile-based authentication."
description = "Automated AWS IAM security auditing with Python + boto3 (no hardcoded credentials), producing a clear terminal report to support hygiene and compliance checks."
tags = ["aws", "iam", "security-audit", "python", "boto3", "cloud-security", "least-privilege"]
categories = ["project"]

# Project metadata

github = "https://github.com/elkana-langat/cloud-iam-audit"
demo = ""
tech_stack = ["Python", "boto3", "AWS IAM", "AWS CLI", "botocore"]
role = "Cloud Security Engineer"
duration = "2 days"
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

This project is a lightweight IAM security audit tool built with Python and boto3. It connects to AWS using an AWS CLI **named profile** (no credentials in code) and evaluates IAM users for common hygiene risks such as:

* **Stale console access** (users who have never logged in or haven’t logged in recently)
* **Active access keys** (programmatic keys that may require review/rotation)

The output is a clear, scan-friendly terminal report designed to reduce manual IAM review time and support recurring security checks aligned with cloud security best practices.

## Problem

Manual IAM reviews do not scale well and are easy to miss under pressure—especially when the user base grows or multiple accounts are involved. Common gaps include:

* Users who retain console access long after they stop using it
* Service or human users accumulating programmatic keys with no rotation discipline
* Ad-hoc console checks that leave no consistent audit evidence
* Compliance expectations (e.g., periodic credential review) that are hard to meet manually

## Goals and scope

**In scope (current version):**

* Enumerate IAM users reliably using paginated APIs
* Identify stale console usage using `PasswordLastUsed` where available
* List and count **active** access keys per user
* Produce a terminal report suitable for quick review

**Out of scope (planned improvements):**

* Access key age / last-used checks
* MFA enrollment checks
* Policy analysis (over-permissioned users)
* Export to CSV/JSON for compliance evidence and integrations

## Architecture and security design

### Least-privilege identity

Instead of using root credentials, the audit runs under a dedicated IAM identity (e.g., `audit-script-bot`) with strictly scoped permissions.

* Principle applied: **Least Privilege**
* Operational safety: audit tooling cannot mutate resources

![AWS Console showing access key creation for the audit user](images/screenshot_1.png)
*Figure 1: Creating programmatic access for a dedicated audit identity.*

### Profile-based authentication (no hardcoded secrets)

The tool uses an AWS CLI **named profile** (example: `auditor`) so credentials remain in `~/.aws/credentials` and are not embedded in source code.

A quick verification step confirms the terminal session is authenticated as the intended audit user:

![Terminal output for sts get-caller-identity using the auditor profile](images/screenshot_2.png)
*Figure 2: Verifying the active AWS identity with STS.*

## Implementation details

### Core audit logic

Key engineering choices that make the tool safer and more reliable:

* **Pagination:** Uses boto3 paginators for `list_users` so results are never truncated in larger environments
* **Defensive access:** Uses `.get()` for optional fields like `PasswordLastUsed` to avoid runtime failures
* **Per-user access key listing:** Calls `list_access_keys` for each user to detect active keys

Example (representative snippet):

```python
session = boto3.Session(profile_name="auditor")
iam = session.client("iam")

paginator = iam.get_paginator("list_users")

for page in paginator.paginate():
    for user in page["Users"]:
        username = user["UserName"]
        password_last_used = user.get("PasswordLastUsed", "Never (or no password)")

        keys = iam.list_access_keys(UserName=username)
        active_keys = [
            k["AccessKeyId"]
            for k in keys["AccessKeyMetadata"]
            if k["Status"] == "Active"
        ]
```

## How to run

1. Create and activate a virtual environment:

   * `python3 -m venv venv`
   * `source venv/bin/activate`

2. Install dependencies:

   * `pip install -r requirements.txt`

3. Configure AWS CLI profile (example `auditor`):

   * `aws configure --profile auditor`
   * Verify:

     * `aws sts get-caller-identity --profile auditor`

4. Run the audit:

   * `python src/audit.py`

## Evidence and output

The tool produces a per-user summary including console login status and whether active access keys are present:

![Terminal output of the IAM audit report](images/screenshot_4.png)
*Figure 3: Example terminal output showing users and active key findings.*

## Results and impact

**What the tool delivers today:**

* Full IAM user enumeration using paginated APIs
* Stale console usage visibility where `PasswordLastUsed` exists
* Detection of users with active access keys (for rotation and review workflows)
* A repeatable, low-risk audit process that avoids hardcoded secrets

**Why it matters:**

* Reduces manual audit time significantly compared to console-only checks
* Improves credential hygiene by surfacing accounts that need review
* Creates a consistent baseline process that can be run repeatedly

## Limitations

This version focuses on the safest, simplest checks first. Current limitations include:

* No access key age or last-used analysis (so rotation recommendations are limited)
* No MFA enforcement checks
* No export format (CSV/JSON) for audit trails or integrations
* No policy analysis to detect over-permissioned users

## Next improvements (roadmap)

If you want to evolve this into a stronger “v2” security audit tool, prioritize:

1. **Access key last-used + age checks** (flag keys older than X days or unused)
2. **MFA status checks** for human users
3. **CSV/JSON export** for compliance evidence and automation pipelines
4. **Policy inspection** (attached/inline) to detect risky permissions
5. **Multi-account scanning** via AWS Organizations (read-only across accounts)

## Security notes

* Never store access keys in source code or commit them to git
* Ensure `.gitignore` excludes `venv/`, any `.env`, and local reports containing sensitive identifiers
* Rotate and revoke unused access keys regularly
* Keep audit and remediation roles separate (audit should be read-only)

## Links

* [GitHub Repository](https://github.com/elkana-langat/AWS-IAM-Security-Audit.git)
* [Least-Privilege IAM Patterns](/blog/least-privilege-iam-patterns/) (related blog post)
