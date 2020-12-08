$pswds = Get-Content 'input.txt';
$valid = 0;

foreach ($pswd in $pswds) {
    $parts = $pswd.Split(" ");
    $limits = $parts[0].Split("-");

    $group = $parts[2].ToCharArray() | Group-Object -AsHashTable -AsString

    $charCount = $group[$parts[1].TrimEnd(":")].Count;

    if ($charCount -ge $limits[0] -and $charCount -le $limits[1] ) {$valid++;}

}

Write-Host "Day2-1 valid passwords: $valid";
$valid = 0;

foreach ($pswd in $pswds) {
    $parts = $pswd.Split(" ");
    $positions = $parts[0].Split("-");
    $pos1 = $positions[0];
    $pos2 = $positions[1];
    $key = $parts[1].TrimEnd(":");
    $password = $parts[2].ToCharArray()

    if ($password[$pos1 - 1] -eq $key -XOR $password[$pos2 - 1] -eq $key) {
        $valid++;
    }


}

Write-Host "Day2-2 valid passwords: $valid";