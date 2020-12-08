$exps = Get-Content 'input.txt';
$size = $exps.Count;
# write-host [int]$exps[0].GetType();
# write-host $exps;

for ($i = 0; $i -lt $size; $i++) {
    for ($j = $i; $j -lt $size; $j++) {
        if ([int]$exps[$i] + [int]$exps[$j] -eq 2020) {
            $ans = [int]$exps[$i] * [int]$exps[$j];
        }
    }
}

Write-Host "Day1-1: $ans";
$ans = 0;

for ($i = 0; $i -lt $size; $i++) {
    if ($ans -ne 0) {break;}
    for ($j = $i; $j -lt $size; $j++) {
        for ($k = $j; $k -lt $size; $k++) {
            if ([int]$exps[$i] + [int]$exps[$j] + [int]$exps[$k] -eq 2020) {
                $ans = [int]$exps[$i] * [int]$exps[$j] * [int]$exps[$k];
                break;
            }
        }
    }
}

Write-Host "Day1-2: $ans";