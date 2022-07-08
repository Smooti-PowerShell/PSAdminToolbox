<!--
*** Thanks for checking out the SmootiTools. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
-->

<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

<!-- PROJECT LOGO -->
<p align="center" style="text-align: center">
	<a href="https://github.com/Smooti-PowerShell/SmootiTools">
		<img src="https://avatars.githubusercontent.com/u/66232763?v=4" width="20%">
	</a><br />
</p>

<!-- SHIELDS -->
<p align="center">
	SmootiTools is a collection of modules developed by
	<a href="https://github.com/smooti/">smooti</a>
	for ease of administration.<br /><br />
	<!-- License shield -->
	<a href="https://github.com/smooti-powershell/SmootiTools/blob/master/LICENSE">
		<img src="https://img.shields.io/github/license/smooti-powershell/SmootiTools.svg?style=badge">
	</a>
	<!-- Contributors shield -->
	<a href="https://github.com/smooti-powershell/SmootiTools/graphs/contributors">
		<img src="https://img.shields.io/github/contributors/smooti-powershell/SmootiTools.svg?style=badge" />
	</a>
	<!-- Forks shield -->
	<a href="https://github.com/smooti-powershell/SmootiTools/network/members">
		<img src="https://img.shields.io/github/forks/smooti-powershell/SmootiTools.svg?style=badge" />
	</a>
	<!-- Stars shield -->
	<a href="https://github.com/smooti-powershell/SmootiTools/stargazers">
		<img src="https://img.shields.io/github/stars/smooti-powershell/SmootiTools.svg?style=badge" />
	</a>
	<!-- Contributions shield -->
	<a href="https://github.com/smooti-powershell/SmootiTools/issues">
		<img src="https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat" />
	</a>
	<!-- Issues Shield -->
	<a href="https://github.com/smooti-powershell/SmootiTools/issues">
		<img src="https://img.shields.io/github/issues/smooti-powershell/SmootiTools.svg?style=badge" />
	</a>
	<!-- Linkedin shield -->
	<a href="https://www.linkedin.com/in/robertowens01/">
		<img src="https://img.shields.io/badge/-LinkedIn-black.svg?style=badge&logo=linkedin&colorB=555" />
	</a>
</p>

<span id="nav-1"></span>

<p align="center">
	<a href="https://github.com/Smooti-PowerShell/SmootiTools/issues">Report Bug</a>
	·
	<a href="https://github.com/Smooti-PowerShell/SmootiTools/issues">Request Feature</a>
</p>

<!-- TABLE OF CONTENTS -->
<details>
	<summary>Table of Contents</summary>
	<ol>
		<li>
			<a href="#introduction">Introduction</a>
			<ul>
				<li><a href="#built-with">Built With</a></li>
			</ul>
		</li>
			<li><a href="#installation">Installation</a></li>
			<ul>
				<li><a href="#prerequisites">Prerequisites</a></li>
				<li><a href="#installation-steps">Installation Steps</a></li>
			</ul>
		</li>
		<li><a href="#usage">Usage</a></li>
		<li><a href="#roadmap">Roadmap</a></li>
		<li><a href="#contributing">Contributing</a></li>
		<li><a href="#license">License</a></li>
	</ol>
</details>

<!-- ABOUT THE PROJECT -->

## Introduction

### Built With

[![PowerShell][powershell.com]][powershell-url]

<!-- Installation -->

## Installation

### Prerequisites

-   Minimum PowerShell version 3.0

### Installation Steps

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

-   Retrieves operating system information.

![Get-OSInfo-Short](https://user-images.githubusercontent.com/66232763/177979306-a6cd8b0d-ec45-4ccc-9327-573575d3352f.gif)

`Get-DiskInfo`

-   Retrieves hard disk information.

![Get-DiskInfo-Short](https://user-images.githubusercontent.com/66232763/177979346-fad26636-e6c5-4dd0-961a-536000ee03e3.gif)

`Invoke-OSSHutdown`

-   Offers a variety of ways to shut down one or more computers.
-   <InsertDemoClip>
    `Get-ComputerVolumeInfo`
-   Retrieves extended computer system information.

![Get-ComputerVolumeInfo-Short](https://user-images.githubusercontent.com/66232763/177979398-bed68eac-f104-470c-af49-f318f8df92d1.gif)

`Get-ProcessorInfo`

-   Retrieves processor information.

![Get-ProcessorInfo-Short](https://user-images.githubusercontent.com/66232763/177979453-bcaac4f4-21d6-4a9c-a0e5-bf33211eba9f.gif)

`Get-GraphicsCardInfo`

-   Retrieves graphics card information.

![Get-GraphicsCardInfo-Short](https://user-images.githubusercontent.com/66232763/177979477-21c76b8c-1ebe-4a93-b5e0-4a837c008ed5.gif)

`Get-PhysicalMemoryInfo`

-   Retrieves physical memory information.

![Get-PhysicalMemoryInfo-Short](https://user-images.githubusercontent.com/66232763/177979500-df336741-858d-4349-8a7e-d8cc0f8fd028.gif)

`Get-InstalledSoftware`

-   Gets installed software on system.

![Get-InstalledSoftware-Short](https://user-images.githubusercontent.com/66232763/177979527-1a888597-ea3b-44be-beb5-2b52ca7196c3.gif)

`Get-UserSession`

-   Gets user sessions from remote computer.
-   <InsertDemoClip>
    `Enter-RDPSession`
-   Initiates an rdp session.
-   <InsertDemoClip>

_For more examples and a list of options, please precede the cmdlet with `Get-Help`_

Example.

```powershell
Get-Help Get-OSInfo
```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ROADMAP -->

## Roadmap

-   [x] Contemplate Life
-   [ ] Get Out of Depression
-   [ ] Add Additional CMDLets (Whatever is useful)

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

Distributed under the GNU GPL-3.0 license. See [LICENSE](https://github.com/smooti-powershell/SmootiTools/blob/master/LICENSE) for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[powershell.com]: https://img.shields.io/badge/PowerShell-0769AD?style=badge&logo=powershell&logoColor=blue&color=black
[powershell-url]: https://docs.microsoft.com/en-us/powershell/