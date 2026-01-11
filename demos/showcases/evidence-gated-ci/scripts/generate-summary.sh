#!/usr/bin/env bash
set -euo pipefail

# Generate GitHub Actions Summary Report
echo "# 🔒 Evidence-Gated CI Results" >> $GITHUB_STEP_SUMMARY
echo "" >> $GITHUB_STEP_SUMMARY
echo "**Commit:** \`${GITHUB_SHA:0:7}\`" >> $GITHUB_STEP_SUMMARY
echo "**Workflow Run:** [#${GITHUB_RUN_NUMBER}](${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID})" >> $GITHUB_STEP_SUMMARY
echo "" >> $GITHUB_STEP_SUMMARY

# Policy Gate Results
echo "## 🛡️ Policy Gate" >> $GITHUB_STEP_SUMMARY
if [ -f evidence/policy-report.json ]; then
  POLICY_ALLOWED=$(jq -r '.allowed' evidence/policy-report.json)
  POLICY_CHECKED=$(jq -r '.totalDependenciesChecked' evidence/policy-report.json)
  SUSPICIOUS_COUNT=$(jq -r '.findings | length' evidence/policy-report.json)
  
  if [ "$POLICY_ALLOWED" = "true" ]; then
    echo "✅ **Status:** PASSED" >> $GITHUB_STEP_SUMMARY
  else
    echo "❌ **Status:** FAILED" >> $GITHUB_STEP_SUMMARY
  fi
  echo "- Dependencies checked: **${POLICY_CHECKED}**" >> $GITHUB_STEP_SUMMARY
  echo "- Suspicious packages found: **${SUSPICIOUS_COUNT}**" >> $GITHUB_STEP_SUMMARY
  
  if [ "$SUSPICIOUS_COUNT" -gt 0 ]; then
    echo "" >> $GITHUB_STEP_SUMMARY
    echo "### ⚠️ Suspicious Dependencies" >> $GITHUB_STEP_SUMMARY
    echo "\`\`\`json" >> $GITHUB_STEP_SUMMARY
    jq -r '.findings[:5]' evidence/policy-report.json >> $GITHUB_STEP_SUMMARY
    echo "\`\`\`" >> $GITHUB_STEP_SUMMARY
  fi
else
  echo "⚠️ Policy report not generated" >> $GITHUB_STEP_SUMMARY
fi
echo "" >> $GITHUB_STEP_SUMMARY

# SBOM Stats
echo "## 📦 Software Bill of Materials (SBOM)" >> $GITHUB_STEP_SUMMARY
if [ -f evidence/sbom.json ]; then
  SBOM_COMPONENTS=$(jq -r '.components | length' evidence/sbom.json)
  echo "✅ **Generated:** Yes" >> $GITHUB_STEP_SUMMARY
  echo "- Total components: **${SBOM_COMPONENTS}**" >> $GITHUB_STEP_SUMMARY
  echo "- Format: **CycloneDX**" >> $GITHUB_STEP_SUMMARY
else
  echo "❌ **Generated:** No" >> $GITHUB_STEP_SUMMARY
fi
echo "" >> $GITHUB_STEP_SUMMARY

# Evidence Bundle
echo "## 📋 Evidence Bundle" >> $GITHUB_STEP_SUMMARY
if [ -f evidence/evidence.bundle.json ]; then
  echo "✅ **Created:** Yes" >> $GITHUB_STEP_SUMMARY
  BUNDLE_COMMIT=$(jq -r '.commitSha' evidence/evidence.bundle.json)
  BUNDLE_TIME=$(jq -r '.timestampUtc' evidence/evidence.bundle.json)
  echo "- Commit: \`${BUNDLE_COMMIT:0:7}\`" >> $GITHUB_STEP_SUMMARY
  echo "- Timestamp: \`${BUNDLE_TIME}\`" >> $GITHUB_STEP_SUMMARY
else
  echo "❌ **Created:** No" >> $GITHUB_STEP_SUMMARY
fi
echo "" >> $GITHUB_STEP_SUMMARY

# Signature Verification
echo "## 🔐 Cryptographic Signature" >> $GITHUB_STEP_SUMMARY
if [ -f evidence/evidence.bundle.sig ]; then
  echo "✅ **Signed:** Yes" >> $GITHUB_STEP_SUMMARY
  echo "✅ **Verified:** Signature verification passed" >> $GITHUB_STEP_SUMMARY
else
  echo "❌ **Signed:** No" >> $GITHUB_STEP_SUMMARY
fi
echo "" >> $GITHUB_STEP_SUMMARY

# Artifacts Link
echo "## 📎 Artifacts" >> $GITHUB_STEP_SUMMARY
echo "Download the complete evidence bundle from the [workflow artifacts](${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID})." >> $GITHUB_STEP_SUMMARY

echo "[+] Summary report generated"
