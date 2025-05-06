
#Script Powershell permettant de supprimer plusieurs machines d'un même groupe AD

# Vérifie la disponibilité du module ActiveDirectory
if (-not (Get-Module -ListAvailable -Name ActiveDirectory)) {
    Write-Error "Le module ActiveDirectory n'est pas installé."
    exit 1
}
Import-Module ActiveDirectory

$Computers=@("TestComputer","TestComputer2")
$GroupName="Test"

foreach ($computer in $Computers) {
    try {
        $SelectedComputer = Get-ADComputer -Identity $computer -ErrorAction Stop

        Remove-ADGroupMember -Identity $GroupName -Members $SelectedComputer -Confirm:$false
        Write-Host "[$computer] supprimé du groupe [$GroupName]" -ForegroundColor Green
    }
    catch {
        Write-Host "Erreur avec [$computer] : $_" -ForegroundColor Red
    }
}
