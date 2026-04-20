param(
    [string]$SchemaPath = "C:\PBL3\db-init\schema_full.sql",
    [string]$OutputDirectory = "C:\PBL3\db-init\product-image-batches",
    [int]$BatchSize = 10
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $SchemaPath)) {
    throw "Schema file not found: $SchemaPath"
}

$lines = Get-Content -LiteralPath $SchemaPath
$products = foreach ($line in $lines) {
    if ($line -match "^\s*\('product-[^']+',\s*'(?<name>[^']+)',\s*'(?<sku>[^']+)'\s*,") {
        [pscustomobject]@{
            sku            = $matches["sku"]
            ten_san_pham   = $matches["name"]
            local_image_path = ""
            hinh_anh_url   = ""
            source_page_url = ""
            status         = "pending"
            notes          = ""
        }
    }
}

if (-not $products) {
    throw "No products were parsed from $SchemaPath"
}

New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null

Get-ChildItem -LiteralPath $OutputDirectory -Filter "batch-*.csv" -ErrorAction SilentlyContinue |
    Remove-Item -Force

$batchIndex = 0
for ($i = 0; $i -lt $products.Count; $i += $BatchSize) {
    $batchIndex++
    $batchRows = $products[$i..([Math]::Min($i + $BatchSize - 1, $products.Count - 1))]
    $number = "{0:d2}" -f $batchIndex
    $path = Join-Path $OutputDirectory "batch-$number.csv"
    $batchRows | Export-Csv -LiteralPath $path -NoTypeInformation -Encoding UTF8
}

Write-Host ("Exported {0} products into {1} batch files at {2}" -f $products.Count, $batchIndex, $OutputDirectory)
