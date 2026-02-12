+++
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
date = {{ .Date }}
draft = true
summary = ""
description = ""
tags = ["cloud-security", "iam"]
categories = ["project"]

# Project-specific metadata
github = ""
demo = ""
tech_stack = ["AWS", "Terraform", "Python"]
role = "Lead Cloud Security Engineer"
duration = ""
featured = false

# Blowfish display settings
showHero = true
heroStyle = "background"
showDate = true
showReadingTime = false
showWordCount = false
showTableOfContents = true
+++

## Overview

Brief description of the project and its objectives.

## Challenge

What security problem or compliance requirement drove this project?

## Solution

Technical approach, architecture decisions, and implementation details.

## Tech Stack

- Tool 1
- Tool 2
- Tool 3

## Results

Impact metrics, outcomes, and lessons learned.

## Links

{{< if .Params.github >}}
- [GitHub Repository]({{ .Params.github }})
{{< end >}}

{{< if .Params.demo >}}
- [Live Demo]({{ .Params.demo }})
{{< end >}}
