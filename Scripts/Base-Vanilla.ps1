# ==========================================
# CONFIG
# ==========================================

$RepoRoot = "D:\Game Files\Balatro\BalatroProfiles"
$SteamBalatro = "P:\SteamLibrary\steamapps\common\Balatro"
$ProfileName = "Vanilla"

$CurrentProfileFile = Join-Path $RepoRoot ".current_profile"

Write-Host "Activating Vanilla profile..."

# ==========================================
# UPDATE REPOSITORY
# ==========================================

Write-Host "Updating Git repository..."

git -C $RepoRoot pull

# ==========================================
# SAVE CURRENT SAVE
# ==========================================

Write-Host "Saving slot 1..."

Copy-Item `
"$env:APPDATA\Balatro\1\*" `
"$RepoRoot\Vanilla\Saves\1\" `
-Recurse `
-Force

# ==========================================
# SAVE CHANGES TO GIT
# ==========================================

Write-Host "Committing changes..."

$HasChanges = git -C $RepoRoot status --porcelain

if ($HasChanges)
{
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    git -C $RepoRoot add .

    git -C $RepoRoot commit -m "Auto save update $Timestamp"

    $PushResult = git -C $RepoRoot push 2>&1

    Write-Host $PushResult
}

# ==========================================
# LOAD SAVE BACK
# ==========================================

Write-Host "Loading save back..."

if (Test-Path "$RepoRoot\Vanilla\Saves\1")
{
    Copy-Item `
    "$RepoRoot\Vanilla\Saves\1\*" `
    "$env:APPDATA\Balatro\1\" `
    -Recurse `
    -Force
}

# ==========================================
# DELETE version.dll
# ==========================================

Write-Host "Deleting version.dll..."

Remove-Item `
"$SteamBalatro\version.dll" `
-ErrorAction SilentlyContinue

# ==========================================
# CHANGE Mods
# ==========================================

Write-Host "Removing Mods..."

Remove-Item `
"$env:APPDATA\Balatro\Mods" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue

# ==========================================
# START GAME
# ==========================================

Write-Host "Launching game..."

Start-Process "steam://rungameid/2379780"