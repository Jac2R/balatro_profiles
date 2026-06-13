# ==========================================
# CONFIG
# ==========================================

$RepoRoot = "D:\Game Files\Balatro\BalatroProfiles"
$SteamBalatro = "P:\SteamLibrary\steamapps\common\Balatro"
$ProfileName = "Pokermon v3.8.0"

$CurrentProfileFile = Join-Path $RepoRoot ".current_profile"

# ==========================================
# UPDATE REPOSITORY
# ==========================================

Write-Host "Updating Git repository..."

git -C $RepoRoot pull

# ==========================================
# SAVE CURRENT SAVE
# ==========================================

Write-Host "Saving slot 3..."

Copy-Item `
"$env:APPDATA\Balatro\3\*" `
"$RepoRoot\Pokermon v3.8.0\Saves\3\" `
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

    git -C $RepoRoot commit `
    -m "Auto save update $Timestamp"

    git -C $RepoRoot push
}

# ==========================================
# LOAD SAVE BACK
# ==========================================

Write-Host "Loading save back..."

Copy-Item `
"$RepoRoot\Pokermon v3.8.0\Saves\3\*" `
"$env:APPDATA\Balatro\3\" `
-Recurse `
-Force

# ==========================================
# CHECK IF version.dll IS EXIST
# ==========================================

if (Test-Path "$RepoRoot\Pokermon v3.8.0\GameFiles\version.dll")
{
    Copy-Item `
    "$RepoRoot\Pokermon v3.8.0\GameFiles\version.dll" `
    "$SteamBalatro\version.dll" `
    -Force
}

# ==========================================
# CHANGE version.dll
# ==========================================

Write-Host "Changing version.dll..."

Remove-Item `
"$SteamBalatro\version.dll" `
-ErrorAction SilentlyContinue

Copy-Item `
"$RepoRoot\Pokermon v3.8.0\GameFiles\version.dll" `
"$SteamBalatro\version.dll" `
-Force

# ==========================================
# CHANGE Mods
# ==========================================

Write-Host "Switching Mods..."

Remove-Item `
"$env:APPDATA\Balatro\Mods" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue

Copy-Item `
"$RepoRoot\Pokermon v3.8.0\Mods" `
"$env:APPDATA\Balatro\Mods" `
-Recurse

# ==========================================
# START GAME
# ==========================================

Write-Host "Launching game..."

Start-Process "steam://rungameid/2379780"