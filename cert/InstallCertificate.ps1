param (
    [Parameter(Mandatory=$true)]
    [string]$CertificatePath
)

Write-Host "Tentative d'installation du certificat depuis : $CertificatePath"

# Certificate file exists ?
if (-not (Test-Path $CertificatePath)) {
    Write-Error "Certificate file '$CertificatePath' not found."
    exit 1
}

try {
    Import-Certificate -FilePath $CertificatePath -CertStoreLocation Cert:\LocalMachine\Root -ErrorAction Stop
    Write-Host "Certificate installed successfully in the Root Certification Authorities."
    Write-Host "You may need to restart the applications (or the computer) for the change to take effect."
}
catch {
    Write-Error "Certificate installation failed. Error: $($_.Exception.Message)"
    Write-Warning "Make sure to run this script as administrator."
    exit 1
}