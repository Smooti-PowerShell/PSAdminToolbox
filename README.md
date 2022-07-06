<!--
*** Thanks for checking out the SmootiTools. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
-->

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Smooti-PowerShell/SmootiTools">
    <img src="https://avatars.githubusercontent.com/u/66232763?v=4" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">SmootiTools</h3>

  <p align="center">
    SmootiTools is a collection of modules developed by 
<a href="https://github.com/smooti/">smooti</a>
  for ease of administration.
    <br />
    <!-- <a href="https://github.com/smooti-powershell/SmootiTools"><strong>Explore the docs »</strong></a>
    <br /> -->
    <br />
    <!-- <a href="https://github.com/smooti-powershell/SmootiTools">View Demo</a>
    · -->
    <a href="https://github.com/Smooti-PowerShell/SmootiTools/issues">Report Bug</a>
    ·
    <a href="https://github.com/Smooti-PowerShell/SmootiTools/issues">Request Feature</a>
  </p>
</p>
<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

### Built With

[![PowerShell][powershell.com]][powershell-url]

<!-- GETTING STARTED -->

## Getting Started

### Prerequisites

-   Minimum PowerShell version 3.0

### Installation

1. Clone the repo
    ```sh
    git clone https://github.com/Smooti-PowerShell/SmootiTools.git
    ```
2. Move `SmootiTools` into your PowerShell Module path

    ```powershell
    # If you want the module to be available per user
    Get-ChildItem SmootiTools -Recurse | Copy-Item -Destination "$($Env:UserProfile)\Documents\powershell"

    # If you want the module to be available for all users
    Get-ChildItem SmootiTools -Recurse | Copy-Item -Destination "$($env:ProgramFiles)\PowerShell\Modules"
    ```

    <Note>

3. Edit your personal `Microsoft.PowerShell_profile.ps1` located at `"$($Env:UserProfile)\Documents\powershell"`, add the following lines, and save.
    ```powershell
    # Import custom modules
    Import-Module -Name SmootiTools -Force
    ```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->

## Usage

`Get-OSInfo`
- Retrieves operating system information.
- <InsertDemoClip>
`Get-DiskInfo`
- Retrieves hard disk information.
- <InsertDemoClip>
`Invoke-OSSHutdown`
- Offers a variety of ways to shut down one or more computers.
- <InsertDemoClip>
`Get-ComputerVolumeInfo`
- Retrieves extended computer system information.
- <InsertDemoClip>
`Get-ProcessorInfo`
- Retrieves processor information.
- <InsertDemoClip>
`Get-GraphicsCardInfo`
- Retrieves graphics card information.
- <InsertDemoClip>
`Get-PhysicalMemoryInfo`
- Retrieves physical memory information.
- <InsertDemoClip>
`Get-InstalledSoftware`
- Gets installed software on system.
- <InsertDemoClip>
`Get-UserSession`
- Gets user sessions from remote computer.
- <InsertDemoClip>
`Enter-RDPSession`
- Initiates an rdp session.
- <InsertDemoClip>

_For more examples and a list of options, please precede `Get-Help` before calling the cmdlet_

Example.

```powershell
Get-Help Get-OSInfo
```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ROADMAP -->

## Roadmap

-   [x] Add Changelog
-   [x] Add back to top links
-   [ ] Add Additional Templates w/ Examples
-   [ ] Add "components" document to easily copy & paste sections of the readme
-   [ ] Multi-language Support
    -   [ ] Chinese
    -   [ ] Spanish

See the [open issues](https://github.com/Smooti-PowerShell/SmootiTools/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## Contributing

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a :star:!

1. :fork_and_knife: Fork the Project :fork_and_knife:
2. :camera: Create your Feature Branch (`git checkout -b feature/AmazingFeature`) :camera:
3. :white_check_mark: Commit your Changes (`git commit -m 'Add some AmazingFeature'`) :white_check_mark:
4. :ribbon: Push to the Branch (`git push origin feature/AmazingFeature`) :ribbon:
5. :confetti_ball: Open a Pull Request :confetti_ball:

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- LICENSE -->

## License

Distributed under the GNU GPL-3.0 license. See `LICENSE` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->

## Contact

Robert Owens - smootiDev@gmail.com

Project Link: [https://github.com/Smooti-PowerShell/SmootiTools](https://github.com/Smooti-PowerShell/SmootiTools)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/smooti-powershell/SmootiTools.svg?style=for-the-badge
[contributors-url]: https://github.com/smooti-powershell/SmootiTools/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/smooti-powershell/SmootiTools.svg?style=for-the-badge
[forks-url]: https://github.com/smooti-powershell/SmootiTools/network/members
[stars-shield]: https://img.shields.io/github/stars/smooti-powershell/SmootiTools.svg?style=for-the-badge
[stars-url]: https://github.com/smooti-powershell/SmootiTools/stargazers
[issues-shield]: https://img.shields.io/github/issues/smooti-powershell/SmootiTools.svg?style=for-the-badge
[issues-url]: https://github.com/smooti-powershell/SmootiTools/issues
[license-shield]: https://img.shields.io/github/license/smooti-powershell/SmootiTools.svg?style=for-the-badge
[license-url]: https://github.com/smooti-powershell/SmootiTools/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/robertowens01/
[product-screenshot]: images/screenshot.png
[powershell.com]: https://img.shields.io/badge/PowerShell-0769AD?style=for-the-badge&logo=powershell&logoColor=blue&color=black
[powershell-url]: https://docs.microsoft.com/en-us/powershell/
