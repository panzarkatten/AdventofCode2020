$InputData = Get-Content "input.txt"

function Get-SeatID {
    param (
        [String]$Seat
    )

    $Row = [convert]::ToInt32($Seat.Substring(0,7).Replace("F",0).Replace("B",1),2)
    $Colum = [convert]::ToInt32($Seat.Substring(7,3).Replace("L",0).Replace("R",1),2)

    return $Row * 8 + $Colum;
}

$Seats = $InputData | % {Get-SeatID $_}
$Max = ($Seats | Measure-Object -Maximum).Maximum

$AllSeats = $Seats[0]..$Max

$MySeat = $AllSeats | ? {-not ($Seats -contains $_)}

Write-Host "Highest Seat ID: $Max"
Write-Host "My Seat ID: $MySeat"