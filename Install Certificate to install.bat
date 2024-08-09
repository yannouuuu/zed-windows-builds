@echo off
powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '-File ./cert/InstallCertificate.ps1'"