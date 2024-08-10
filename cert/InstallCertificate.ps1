$certPath = "./cert/ZedCertificate.cer"
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($certPath)

$store = [System.Security.Cryptography.X509Certificates.X509Store]::new("Root", "LocalMachine")
try {
    $store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
    $store.Add($cert)
    Write-Host "Certificate installed successfully."
}
catch {
    Write-Host "An error occurred: $_"
}
finally {
    $store.Close()
}