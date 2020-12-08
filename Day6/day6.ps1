$InputData = Get-Content "$PSScriptRoot\input.txt" -Delimiter "`r`n`r`n"

function Measure-Answares {
    param (
        [array]$Answares,
        [switch]$PartTwo=$false
    )

    if (-not $PartTwo) {
        ($Answares | % {$_.Replace("`r`n", "").ToCharArray() | Sort-Object | Get-Unique}).Count  
    } Else {
        foreach ($Set in $Answares) {
            $Rows = ($Set | Measure-Object -Word).Words
            $SetAns = $Set | % {$_.Replace("`r`n", "").ToCharArray() | Group-Object}

            $AllYes += (($SetAns | % {$_.Count -eq $Rows}) -eq $true).Count
        }

        $AllYes
    }
}   

Write-Host "Part #1: " -NoNewline
Measure-Answares -Answares $InputData
Write-Host "Part #2: " -NoNewline
Measure-Answares -Answares $InputData -PartTwo
