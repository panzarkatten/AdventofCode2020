$InputData = Get-Content "input.txt" -Raw
$Fields = @('byr','iyr','eyr','hgt','hcl','ecl','pid')
Remove-Variable "ValidatedPasswords" -ErrorAction SilentlyContinue

function Test-Passports {
    param (
        [string]$Data,
        [Array]$RequiredFields
    )

    $Result = @()

    $Passports = $Data -Split "`n`n"

    Write-Host "Number of Passports:" $Passports.Count

    # Validate passwords
    for ($i = 0; $i -lt $Passports.Count; $i++) {
        Write-host "`nPassport #"$i
        # Write-Host "Passport:" $Passports[$i]
        $Entries = $Passports[$i].Split("`n").Split(" ")
<#         foreach ($Entry in $Entries) {
            Write-Host "-" $Entry
        } #>

        # $Result += -not (($RequiredFields | % {$Entries.Split(":") -contains $_}) -contains $false)
        # $Result += -not (($RequiredFields | % { if ($Entries.Split(":") -contains $_) {Test-PassportField $Entries} Else {$false}}) -contains $false)
        $PassportResults = @();

        $HasFields = -not (($RequiredFields | % {$Entries.Split(":") -contains $_}) -contains $false)

        if ($HasFields) {
            foreach ($Entry in $Entries) {
                $TestResult = Test-PassportField $Entry.Trim()
                Write-Host "$Entry => $TestResult"
                $PassportResults += $TestResult
            } 
        } Else {
            $PassportResults += $false
        }


        Write-Host "`nPassportResults:" $PassportResults
        $PassportValid = -not ($PassportResults -contains $false)
            Write-Host "Passport is" $PassportValid
            Write-Host " "
        $Result += $PassportValid
        
    }

    return $Result

}

function Test-PassportField {
    param (
        [string]$PassportField
    )
    
    $Field, $Data = $PassportField.Split(":")

    switch ($Field) {
        # byr (Birth Year) - four digits; at least 1920 and at most 2002.
        "byr" { $Data -match "^(19[2-9][0-9]|200[0-2])$" }
        # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
        "iyr" { $Data -match "^20(1[0-9]|20)$" }
        # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
        "eyr" { $Data -match "^20(2[0-9]|30)$" }
        # hgt (Height) - a number followed by either cm or in:
        # If cm, the number must be at least 150 and at most 193.
        # If in, the number must be at least 59 and at most 76.
        "hgt" { 
            
            $hgt = $Data.Substring(0,$Data.Length-2)
            $unit = $Data.Substring($Data.Length-2,2)
            switch ($unit) {
                "cm" { $hgt -ge 150 -AND $hgt -le 193 }
                "in" { $hgt -ge 59 -AND $hgt -le 76 }
                Default {$false}
            }
        }
        # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
        "hcl" { $Data -match "^#[0-9a-f]{6}$" }
        # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
        "ecl" { $Data -match "^(amb|blu|brn|gry|grn|hzl|oth)$" }
        # pid (Passport ID) - a nine-digit number, including leading zeroes.
        "pid" { $Data -match "^\d{9}$" }
        # cid (Country ID) - ignored, missing or not.
        "cid" { $true }
        Default {$false}
    }
}

$ValidatedPassports = Test-Passports -Data $InputData -RequiredFields $Fields

Write-Host "Valid Passports: " -NoNewline
($ValidatedPassports -eq $true).Count