@echo off
PowerShell.exe -ExecutionPolicy Bypass -File "%~dp0cert\InstallCertificate.ps1" -CertificatePath "%~dp0cert\signing_cert.cer"
pause