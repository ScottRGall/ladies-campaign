param(
  [string]$Message = ""
)

Set-Location -Path $PSScriptRoot

# Safety: make sure docs exists
if (-not (Test-Path ".\docs")) {
  Write-Error "docs folder not found. Are you in the repo root?"
  exit 1
}

# Show status first
Write-Host "=== Git status (before) ==="
git status

# Stage only docs
git add docs

# If nothing changed, exit cleanly
$changes = git status --porcelain
if (-not $changes) {
  Write-Host "No changes to publish."
  exit 0
}

# Commit message
if ([string]::IsNullOrWhiteSpace($Message)) {
  $dt = Get-Date -Format "yyyy-MM-dd HH:mm"
  $Message = "Publish player site ($dt)"
}

git commit -m $Message
git push

Write-Host "Publish complete."
