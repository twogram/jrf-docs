# Script de Sécurisation - Retrait des Révélations Rust
# Ce script supprime tous les fichiers révélateurs et nettoie l'historique Git

Write-Host "🔒 SÉCURISATION DE LA DOCUMENTATION JRF" -ForegroundColor Yellow
Write-Host "=" * 60

# Étape 1: Supprimer les fichiers révélateurs
Write-Host "`n📝 Étape 1: Suppression des fichiers révélateurs..." -ForegroundColor Cyan

$filesToDelete = @(
    "docs\api\rust-api.md",
    "docs\guides\rust-integration.md",
    "docs\guides\custom-strategies.md"
)

foreach ($file in $filesToDelete) {
    if (Test-Path $file) {
        Remove-Item $file -Force
        Write-Host "  ✅ Supprimé: $file" -ForegroundColor Green
    } else {
        Write-Host "  ⚠️  Fichier non trouvé: $file" -ForegroundColor Yellow
    }
}

# Étape 2: Nettoyer contributing.md (retirer exemples Rust)
Write-Host "`n📝 Étape 2: Nettoyage de contributing.md..." -ForegroundColor Cyan

$contributingFile = "docs\about\contributing.md"
if (Test-Path $contributingFile) {
    $content = Get-Content $contributingFile -Raw
    
    # Retirer la section "Rust Development"
    $content = $content -replace '(?s)### Rust Development.*?### Python Development', '### Python Development'
    
    # Retirer les exemples Rust dans "Code Style"
    $content = $content -replace '(?s)### Rust.*?### Python', '### Python'
    
    # Retirer les exemples Rust dans "Testing Guidelines"
    $content = $content -replace '(?s)### Unit Tests.*?Test individual functions:.*?```rust.*?```\n\n', ''
    
    Set-Content $contributingFile -Value $content -NoNewline
    Write-Host "  ✅ Nettoyé: contributing.md" -ForegroundColor Green
}

# Étape 3: Mettre à jour mkdocs.yml (retirer navigation Rust)
Write-Host "`n📝 Étape 3: Mise à jour de mkdocs.yml..." -ForegroundColor Cyan

$mkdocsFile = "mkdocs.yml"
if (Test-Path $mkdocsFile) {
    $content = Get-Content $mkdocsFile -Raw
    
    # Retirer rust-api.md de la navigation
    $content = $content -replace '\s*- Rust API: api/rust-api\.md', ''
    
    # Retirer rust-integration.md de la navigation
    $content = $content -replace '\s*- Rust Integration: guides/rust-integration\.md', ''
    
    # Retirer custom-strategies.md de la navigation
    $content = $content -replace '\s*- Custom Strategies: guides/custom-strategies\.md', ''
    
    Set-Content $mkdocsFile -Value $content -NoNewline
    Write-Host "  ✅ Mis à jour: mkdocs.yml" -ForegroundColor Green
}

# Étape 4: Mettre à jour PLACEHOLDERS.md
Write-Host "`n📝 Étape 4: Mise à jour de PLACEHOLDERS.md..." -ForegroundColor Cyan

$placeholdersFile = "PLACEHOLDERS.md"
if (Test-Path $placeholdersFile) {
    $content = Get-Content $placeholdersFile -Raw
    
    # Retirer les références aux fichiers Rust
    $content = $content -replace '.*rust-api\.md.*\n', ''
    $content = $content -replace '.*rust-integration\.md.*\n', ''
    $content = $content -replace '.*custom-strategies\.md.*\n', ''
    
    Set-Content $placeholdersFile -Value $content -NoNewline
    Write-Host "  ✅ Mis à jour: PLACEHOLDERS.md" -ForegroundColor Green
}

# Étape 5: Git - Supprimer les fichiers de l'index
Write-Host "`n📝 Étape 5: Suppression des fichiers de Git..." -ForegroundColor Cyan

git rm --cached docs/api/rust-api.md 2>$null
git rm --cached docs/guides/rust-integration.md 2>$null
git rm --cached docs/guides/custom-strategies.md 2>$null

Write-Host "  ✅ Fichiers retirés de l'index Git" -ForegroundColor Green

# Étape 6: Nettoyer l'historique Git (CRITIQUE)
Write-Host "`n🔥 Étape 6: NETTOYAGE DE L'HISTORIQUE GIT..." -ForegroundColor Red
Write-Host "  ⚠️  ATTENTION: Cette opération va réécrire l'historique!" -ForegroundColor Yellow
Write-Host "  ⚠️  Tous les commits précédents seront écrasés!" -ForegroundColor Yellow

$confirm = Read-Host "`n  Voulez-vous continuer? (oui/non)"

if ($confirm -eq "oui") {
    Write-Host "`n  🔄 Suppression de l'historique Git..." -ForegroundColor Cyan
    
    # Supprimer le dossier .git
    if (Test-Path ".git") {
        Remove-Item -Recurse -Force ".git"
        Write-Host "  ✅ Historique Git supprimé" -ForegroundColor Green
    }
    
    # Réinitialiser le repo
    git init
    Write-Host "  ✅ Nouveau repo Git initialisé" -ForegroundColor Green
    
    # Ajouter tous les fichiers (sauf ceux supprimés)
    git add .
    Write-Host "  ✅ Fichiers ajoutés" -ForegroundColor Green
    
    # Commit initial
    git commit -m "Initial commit - Documentation website (Python-only)"
    Write-Host "  ✅ Commit initial créé" -ForegroundColor Green
    
    Write-Host "`n  ✅ HISTORIQUE NETTOYÉ - Aucune trace des fichiers Rust!" -ForegroundColor Green
} else {
    Write-Host "`n  ⚠️  Nettoyage de l'historique annulé" -ForegroundColor Yellow
    Write-Host "  ℹ️  Les fichiers ont été supprimés mais restent dans l'historique Git" -ForegroundColor Cyan
}

# Résumé
Write-Host "`n" + ("=" * 60)
Write-Host "✅ SÉCURISATION TERMINÉE!" -ForegroundColor Green
Write-Host "`nFichiers supprimés:" -ForegroundColor Cyan
foreach ($file in $filesToDelete) {
    Write-Host "  - $file" -ForegroundColor Gray
}

Write-Host "`nProchaines étapes:" -ForegroundColor Cyan
Write-Host "  1. Vérifier les changements: git status" -ForegroundColor White
Write-Host "  2. Ajouter le remote: git remote add origin https://github.com/twogram/jrf-docs.git" -ForegroundColor White
Write-Host "  3. Push forcé: git push -u origin main --force" -ForegroundColor White
Write-Host "`n⚠️  IMPORTANT: Le push --force écrasera l'historique distant!" -ForegroundColor Yellow
