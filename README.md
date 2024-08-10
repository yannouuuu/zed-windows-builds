# Zed Windows Build

## Project Overview

This repository houses an automated CI/CD pipeline for compiling and distributing Zed, a cutting-edge text editor, for the Windows platform. Leveraging GitHub Actions, it orchestrates the build process for Windows, generating both a standalone executable (.exe) and a Windows app package (.msix) for seamless deployment.

> **Disclaimer: This project is not affiliated with Zed Industries. It is an independent, community-driven endeavor.**

## Core Functionalities

- Automated cross-compilation of Zed for Windows (x86_64 architecture)
- MSIX package generation for streamlined Windows 10/11 installation
- Automated pruning of obsolete build artifacts
- Version management based on Zed's official release tags
- Artifact uploading to GitHub releases

## Build Integrity

The builds produced by this pipeline maintain a high level of integrity and can be considered safe for use. Here's a technical breakdown of the security measures:

1. Source integrity: The codebase is pulled directly from Zed Industries' official repository, ensuring no unauthorized modifications.
2. Build transparency: The entire build process is codified in the `build.yml` workflow file, allowing for thorough auditing.
3. Immutable source: No alterations are made to the source code during the build pipeline execution.
4. Direct artifact publishing: Generated artifacts are uploaded to GitHub releases programmatically, minimizing the risk of tampering.

While these measures ensure a high degree of safety, it's advisable to employ up-to-date antivirus software and exercise standard precautions as with any third-party software.

## Usage Instructions

1. Navigate to the "Releases" section of this GitHub repository.
2. Locate and download the latest Zed build for Windows (either .exe or .msix).
3. For .exe: Execute the file directly.
4. For .msix: Initiate installation by double-clicking, leveraging the Windows app installer.

## Technical Deep Dive

Some segments of the build process involve intricate operations. Here's an in-depth look at key components:

### MSIX Package Creation

```powershell
& "C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64\MakeAppx.exe" pack /d . /p Zed-windows-amd64-${{ env.LATEST_TAG }}.msix /f AppxManifest.xml
```

This command invokes `MakeAppx.exe` from the Windows SDK to generate the MSIX package:
- `/d .`: Specifies the current directory as the source for package contents.
- `/p`: Designates the output package name, incorporating the latest version tag.
- `/f AppxManifest.xml`: Points to the manifest file defining the package structure and metadata.

## Artifact Versioning

The pipeline employs a sophisticated versioning mechanism:

```yaml
- name: Get latest release tag from GitHub API
  id: get_latest_tag
  run: |
    $latestRelease = (Invoke-RestMethod -Uri https://api.github.com/repos/zed-industries/zed/releases/)
    $latestTag = $latestRelease.tag_name
    $isPrerelease = $latestRelease.prerelease.ToString().ToLower()
    if (-not $latestTag) {
      $latestTag = "v0.0.0"
      $isPrerelease = "false"
    }
    echo "LATEST_TAG=$latestTag" >> $env:GITHUB_ENV
    echo "IS_PRERELEASE=$isPrerelease" >> $env:GITHUB_ENV
```

This PowerShell script queries the GitHub API to fetch the latest release tag from Zed's official repository. It handles edge cases, such as the absence of releases, by defaulting to "v0.0.0". The retrieved version information is then propagated to subsequent steps via GitHub Actions environment variables.

## Contributing

Contributions to enhance this build pipeline are welcome. Please adhere to the following protocol:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License
See the [LICENSE](LICENSE) file for comprehensive terms and conditions.

## Disclaimer

To reiterate, this project operates independently of Zed Industries. It is a community-driven initiative aimed at facilitating Zed accessibility on Windows platforms. Utilize these builds at your own discretion.
