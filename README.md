<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
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
    <!-- <a href="https://github.com/othneildrew/Best-README-Template"><strong>Explore the docs »</strong></a>
    <br /> -->
    <br />
    <!-- <a href="https://github.com/othneildrew/Best-README-Template">View Demo</a>
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
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

[![Product Name Screen Shot][product-screenshot]](https://example.com)

There are many great README templates available on GitHub; however, I didn't find one that really suited my needs so I created this enhanced one. I want to create a README template so amazing that it'll be the last one you ever need -- I think this is it.

Here's why:

-   Your time should be focused on creating something amazing. A project that solves a problem and helps others
-   You shouldn't be doing the same tasks over and over like creating a README from scratch
-   You should implement DRY principles to the rest of your life :smile:

Of course, no one template will serve all projects since your needs may be different. So I'll be adding more in the near future. You may also suggest changes by forking this repo and creating a pull request or opening an issue. Thanks to all the people have contributed to expanding this template!

Use the `BLANK_README.md` to get started.

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With

-   [![PowerShell][powershell.com]][powershell-url]

<p align="right">(<a href="#top">back to top</a>)</p>

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

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

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

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a :star:! Thanks again!

1. :fork_and_knife: Fork the Project :fork_and_knife:
2. :camera: Create your Feature Branch (`git checkout -b feature/AmazingFeature`) :camera:
3. :white_check_mark: Commit your Changes (`git commit -m 'Add some AmazingFeature'`) :white_check_mark:
4. :ribbon: Push to the Branch (`git push origin feature/AmazingFeature`) :ribbon:
5. :confetti_ball: Open a Pull Request :confetti_ball:

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->

## Contact

Kobe Owens - kobeowens43099@gmail.com

Project Link: [https://github.com/Smooti-PowerShell/SmootiTools](https://github.com/Smooti-PowerShell/SmootiTools)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/robertowens01/
[product-screenshot]: images/screenshot.png
[powershell.com]: https://img.shields.io/badge/PowerShell-0769AD?style=for-the-badge&logo=powershell&logoColor=blue&color=black
[powershell-url]: https://docs.microsoft.com/en-us/powershell/
