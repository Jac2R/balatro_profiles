# ==========================================
# CONFIG
# ==========================================

$RepoRoot = "D:\Game Files\Balatro\BalatroProfiles"
$SteamBalatro = "P:\SteamLibrary\steamapps\common\Balatro"
$ProfileName = "Multiplayer"

$CurrentProfileFile = Join-Path $RepoRoot ".current_profile"

# ==========================================
# UPDATE REPOSITORY
# ==========================================

Write-Host "Updating Git repository..."

git -C $RepoRoot pull

# ==========================================
# SAVE CURRENT SAVE
# ==========================================

Write-Host "Saving slot 2..."

Copy-Item `
"$env:APPDATA\Balatro\2\*" `
"$RepoRoot\Multiplayer\Saves\2\" `
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

Copy-Item `
"$RepoRoot\Multiplayer\Saves\2\*" `
"$env:APPDATA\Balatro\2\" `
-Recurse `
-Force

# ==========================================
# CHANGE version.dll
# ==========================================

Write-Host "Changing version.dll..."

Remove-Item `
"$SteamBalatro\version.dll" `
-ErrorAction SilentlyContinue

if (Test-Path "$RepoRoot\Multiplayer\GameFiles\version.dll")
{
    Copy-Item `
    "$RepoRoot\Multiplayer\GameFiles\version.dll" `
    "$SteamBalatro\version.dll" `
    -Force
}

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
"$RepoRoot\Multiplayer\Mods" `
"$env:APPDATA\Balatro\Mods" `
-Recurse

# ==========================================
# START GAME
# ==========================================

Write-Host "Launching game..."

Start-Process "steam://rungameid/2379780"