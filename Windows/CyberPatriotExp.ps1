function Show-Menu
{
    param (
        [string]$Title = 'CyberPatriot'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    Write-Host ""
    Write-Host "A) Press '1' for this option."
    Write-Host "B) Press '2' for this option."
    Write-Host "C) Press '3' for this option."
    Write-Host ""
    
}

Show-Menu -Title "CyberPatriot"
$selection = Read-Host "Please make a selection"
switch ($selection)
{
    '1' {
        'You chose option #1'
    } '2' {
        'You chose option #2'
    } '3' {
        'You chose option #3'
    } 'q' {
        return
    }
}