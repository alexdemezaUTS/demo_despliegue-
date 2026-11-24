param(
    [string]$RutaPHP = 'php'
)

$archivoOrigen = Join-Path $PSScriptRoot '.\origen\index.php'
$archivoDestino = Join-Path $PSScriptRoot '.\pruebas\index.php'

& $RutaPHP -l $archivoOrigen

if ($LASTEXITCODE -ne 0) {
    Write-Host "hay un error de sintaxis. No se publico el cambio."
    exit 1
}
Copy-Item $archivoOrigen $archivoDestino -Force -ErrorAction Stop
Write-Host "Version publicada en el ambiente de pruebas."
if (-not $env:CI) {
    & $RutaPHP -S localhost:8000 -t .\pruebas
}