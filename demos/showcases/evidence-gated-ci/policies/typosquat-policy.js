const fs = require("fs");

const POPULAR = ["express", "react", "lodash", "axios", "chalk", "commander", "debug", "uuid"];

function levenshtein(a, b) {
  const m = a.length, n = b.length;
  const dp = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));
  for (let i = 0; i <= m; i++) dp[i][0] = i;
  for (let j = 0; j <= n; j++) dp[0][j] = j;

  for (let i = 1; i <= m; i++) {
    for (let j = 1; j <= n; j++) {
      const cost = a[i - 1] === b[j - 1] ? 0 : 1;
      dp[i][j] = Math.min(
        dp[i - 1][j] + 1,
        dp[i][j - 1] + 1,
        dp[i - 1][j - 1] + cost
      );
    }
  }
  return dp[m][n];
}

function depsFromPackageLock(lockPath) {
  const lock = JSON.parse(fs.readFileSync(lockPath, "utf8"));

  if (lock.packages) {
    return Object.keys(lock.packages)
      .filter((k) => k.startsWith("node_modules/"))
      .map((k) => k.replace("node_modules/", ""))
      .filter(Boolean);
  }
  if (lock.dependencies) return Object.keys(lock.dependencies);
  return [];
}

function main() {
  const lockPath = "app/package-lock.json";
  if (!fs.existsSync(lockPath)) {
    console.error(`Missing ${lockPath}. Run npm install/npm ci first.`);
    process.exit(2);
  }

  const deps = depsFromPackageLock(lockPath);
  const findings = [];

  for (const dep of deps) {
    for (const popular of POPULAR) {
      if (dep === popular) continue;
      const dist = levenshtein(dep, popular);
      if (dist === 1 || dist === 2) {
        findings.push({
          dependency: dep,
          looksLike: popular,
          distance: dist,
          reason: `Name is very similar to popular package "${popular}".`
        });
      }
    }
  }

  const report = {
    policy: "typosquat-detection",
    dependencyCount: deps.length,
    findings,
    allowed: findings.length === 0
  };

  fs.mkdirSync("evidence", { recursive: true });
  fs.writeFileSync("evidence/policy-report.json", JSON.stringify(report, null, 2));

  if (!report.allowed) {
    console.error("[!] Policy failed: suspicious dependency names detected.");
    console.error(JSON.stringify(findings.slice(0, 5), null, 2));
    process.exit(1);
  }

  console.log("[+] Policy passed: no suspicious dependency names detected.");
  process.exit(0);
}

main();
