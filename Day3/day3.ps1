$geo = Get-Content "input.txt";
$width = $geo[0].ToCharArray().Count;
$height = $geo.Count;


# Day 3-1

$ystep = 1;
$xstep = 3;
$trees = 0;
$ypos = 0;
$xpos = 0;

while ($ypos -lt $height) {
    $lineArray = $geo[$ypos];
    if ($lineArray[$xpos] -eq "#") {
        $trees++;
    }

    $ypos += $ystep;
    $xpos += $xstep;

    if ($xpos -ge $width) {
        $xpos -= $width;
    }
}

Write-Host "Day3-1: $trees trees";

# Day 3-2

$ysteps = @(1,1,1,1,2);
$xsteps = @(1,3,5,7,1);
$trees = ,0 * $ysteps.Count;

for ($i = 0; $i -lt $ysteps.Count; $i++) {
    $ypos = 0;
    $xpos = 0;

    while ($ypos -lt $height) {
        $lineArray = $geo[$ypos].ToCharArray()
        if ($lineArray[$xpos] -eq "#") {
            $trees[$i]++;
        }
    
        $ypos += $ysteps[$i];
        $xpos += $xsteps[$i];

        if ($xpos -ge $width) {
            $xpos -= $width;
        }
    }
}

$trees | % {$ans = 1} {$ans *= $_}

Write-Host "Day3-2: $ans";