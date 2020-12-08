$InputData = (Get-Content "input_test.txt" -Raw) -Split "`r`n`r`n"

function Measure-Answares {
    param (
        [array]$Answares,
        [switch]$PartTwo=$false
    )

    if (-not $PartTwo) {
        return $Answares | % {$_.Replace("`r`n", "").ToCharArray() | Sort-Object | Get-Unique}   
    } Else {
        foreach ($Set in $Answares) {
            $Rows = ($Set | Measure-Object -Word).Words
            $UniqueAnswares = Measure-Answares $Set

            Write-Host "$People : $UniqueAnswares"
            if ($People -ge $UniqueAnswares) {
                # $UniqueAnswares
            }
        }
    }
    

}

Write-Host "Part #1: " -NoNewline
(Measure-Answares -Answares $InputData).Count
Measure-Answares -Answares $InputData -PartTwo

for ($i = 0; $i -lt $InputData.Count; $i++) {
    Write-Host $i ":" $InputData[$i]
    Write-Host ""
}

Write-Host "Count:" $InputData.Count