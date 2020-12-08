$InputData = Get-Content "input_test.txt" -Delimiter "`n`n"

function Measure-Answares {
    param (
        [array]$Answares,
        [switch]$PartTwo=$false
    )

    if (-not $PartTwo) {
        ($Answares | % {$_.Replace("`n", "").ToCharArray() | Sort-Object | Get-Unique}).Count    
    } Else {
        foreach ($Set in $Answares) {
            $People = ($Set | Measure-Object -Word).Words
            $UniqueAnswares = Measure-Answares $Set

            Write-Host "$People : $UniqueAnswares"
            if ($People -ge $UniqueAnswares) {
                # $UniqueAnswares
            }
        }
    }
    

}

Measure-Answares -Answares $InputData
Measure-Answares -Answares $InputData -PartTwo