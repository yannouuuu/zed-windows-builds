$certPath = "./cert/ZedCertificate.cer"
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$cert.Import($certPath)
$store = New-Object System.Security.Cryptography.X509Certificates.X509Store "Root", "LocalMachine"
$store.Open("ReadWrite")
$store.Add($cert)
$store.Close()
Write-Host "Certificate installed successfully."