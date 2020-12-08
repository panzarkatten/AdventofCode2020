$pswds = Get-Content 'input.txt';
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

$valid;