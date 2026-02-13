# Social Card Specification

## Current Configuration

**Config file:** `config/_default/params.toml`
```toml
defaultSocialImage = "/img/social-card.jpg"
```

## Image Requirements

**Filename:** `social-card.jpg`  
**Path:** `static/img/social-card.jpg`  
**Dimensions:** 1200×630 pixels (landscape)  
**Format:** JPG or PNG  
**File size:** < 1MB recommended

## Content Suggestions

**Layout:**
- Name: "Elkana Lang'at"
- Headline: "Cloud Security & IAM Professional"
- Optional: Portfolio URL or key focus areas
- Background: Professional gradient or abstract security-themed visual

**Tools:**
- Canva (free templates available)
- Figma
- Adobe Express
- Online OG image generators

## Verification

After adding the image, verify it appears in meta tags:

```bash
hugo server
curl -s http://localhost:1313/ | grep "og:image\|twitter:image"
```

Expected output:
```html
<meta property="og:image" content="http://yoursite.com/img/social-card.jpg">
<meta name="twitter:image" content="http://yoursite.com/img/social-card.jpg">
```

## Production Note

**Blowfish fallback behavior:** If `social-card.jpg` is missing, Blowfish will use the site's default favicon or logo. The site will not 404 or break.

To deploy without a custom social card, simply leave this TODO - the site will function correctly with Blowfish's default behavior.
