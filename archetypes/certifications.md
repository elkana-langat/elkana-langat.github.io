+++
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
date = {{ .Date }}
draft = false
summary = "Brief description of this certification and what it validates"
tags = ["certification", "issuer-name", "topic-area"]
categories = ["credential"]

# Certification metadata
issuer = "Issuer Name (e.g., AWS, Microsoft, Google)"
verification_url = "https://verify-url-here"
credential_id = ""  # Optional: leave empty if not applicable
expiry_date = ""    # Optional: YYYY-MM-DD format, or leave empty if doesn't expire
badge_image = ""    # Optional: path to badge thumbnail

# Display settings
showHero = false
showDate = true
showReadingTime = false
showTableOfContents = false
+++

## Certification Details

**Issuer:** {{ .Params.issuer }}  
**Issued:** {{ .Date.Format "January 2, 2006" }}  
**Status:** Active  

## About This Certification

[Brief overview of what this certification covers and why it's valuable.]

## Verification

Verify this credential: [Verify Credential]({{ .Params.verification_url }})

## Skills Covered

- Skill area 1
- Skill area 2
- Skill area 3
- Skill area 4

## What I Learned

[Describe key takeaways, challenges overcome, or how this certification has been applied in practice.]
