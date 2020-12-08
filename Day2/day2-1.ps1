$pswds = Get-Content 'input.txt';
$valid = 0;

foreach ($pswd in $pswds) {
    $parts = $pswd.Split(" ");
    $limits = $parts[0].Split("-");

    $group = $parts[2].ToCharArray() | Group-Object -AsHashTable -AsString

    $charCount = $group[$parts[1].TrimEnd(":")].Count;

    if ($charCount -ge $limits[0] -and $charCount -le $limits[1] ) {$valid++;}

}

$valid;