#!/usr/bin/env bash
# Profile Setup Verification Script
# Run before commits to ensure profile configuration integrity

set -e  # Exit on error

ERRORS=0
WARNINGS=0

echo "🔍 Verifying Blowfish profile setup..."
echo

# Check 1: Avatar exists in assets/
echo "✓ Checking avatar image..."
if [ ! -f "assets/img/avatar.jpg" ]; then
    echo "  ❌ ERROR: assets/img/avatar.jpg not found"
    ERRORS=$((ERRORS + 1))
else
    SIZE=$(du -h assets/img/avatar.jpg | cut -f1)
    echo "  ✅ Avatar found ($SIZE)"
fi

# Check 2: Config has [params.author] block
echo "✓ Checking author configuration..."
if ! grep -q '\[params\.author\]' config/_default/languages.en.toml; then
    echo "  ❌ ERROR: [params.author] not found in languages.en.toml"
    ERRORS=$((ERRORS + 1))
else
    echo "  ✅ [params.author] block found"
    
    # Check for bio field
    if ! grep -q 'bio\s*=' config/_default/languages.en.toml; then
        echo "  ❌ ERROR: bio field not found in author config"
        ERRORS=$((ERRORS + 1))
    else
        echo "  ✅ bio field configured"
    fi
    
    # Check for image field
    if ! grep -q 'image\s*=' config/_default/languages.en.toml; then
        echo "  ❌ ERROR: image field not found in author config"
        ERRORS=$((ERRORS + 1))
    else
        echo "  ✅ image field configured"
    fi
fi

# Check 3: Profile template override exists
echo "✓ Checking profile template override..."
if [ ! -f "layouts/partials/home/profile.html" ]; then
    echo "  ❌ ERROR: layouts/partials/home/profile.html not found"
    ERRORS=$((ERRORS + 1))
else
    echo "  ✅ Template override found"
    
    # Check for bio rendering block
    if ! grep -q 'Site\.Params\.Author\.bio' layouts/partials/home/profile.html; then
        echo "  ⚠️  WARNING: Bio block not found in profile template"
        WARNINGS=$((WARNINGS + 1))
    else
        echo "  ✅ Bio rendering block present"
    fi
fi

# Check 4: Warn if static/ has duplicate avatar
if [ -f "static/img/avatar.jpg" ]; then
    echo "  ⚠️  WARNING: Duplicate avatar in static/img/ (should use assets/ only)"
    WARNINGS=$((WARNINGS + 1))
fi

echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo "✅ All checks passed!"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo "⚠️  Passed with $WARNINGS warning(s)"
    exit 0
else
    echo "❌ Failed with $ERRORS error(s) and $WARNINGS warning(s)"
    exit 1
fi
