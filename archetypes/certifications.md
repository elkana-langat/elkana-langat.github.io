+++
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
date = {{ .Date }}
draft = true
summary = ""
tags = ["certification"]
categories = ["credential"]

# Certification-specific
issuer = ""
credential_id = ""
verification_url = ""
expiry_date = ""
badge_image = ""

# Blowfish-specific
showHero = false
showDate = true
showReadingTime = false
+++

## Certification Details

**Issuer:** {{ .Params.issuer }}  
**Credential ID:** {{ .Params.credential_id }}  
**Issued:** {{ .Date.Format "January 2006" }}  
**Expires:** {{ .Params.expiry_date }}

## Verification

[Verify Credential]({{ .Params.verification_url }})

## Skills Covered

- Skill 1
- Skill 2
- Skill 3
