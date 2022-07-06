Function Get-OSInfo {
	<#
        .Synopsis
            Retrieves operating system information.
        .PARAMETER ComputerName
            Optional. Name or IP of computer or computers.
			DEFAULT: LocalHost
        .PARAMETER ErrorLog
            Optional. Path to save error log.
			DEFAULT: $($PSScriptRoot)\Get-OSInfo_Error.txt
        .PARAMETER LogErrors
            Optional. If specified errors will be logged.
        .EXAMPLE
            Get-OSInfo -ComputerName Computer1
        .EXAMPLE
            "Computer1","Computer2" | Get-OSInfo
        .EXAMPLE
            Get-OSInfo -ComputerName Computer1,Computer2 -LogErrors
        .EXAMPLE
            Get-OSInfo -ComputerName Computer1 -LogErrors -ErrorLog C:\Users\<user>\Documents\Get-OSInfo_Error.txt
    #>

	param (
		[Parameter (ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True,	HelpMessage = "ComputerName or IP address.")]
		[Alias("Hostname")]
		[ValidateCount(0, 5)]
		[string[]] $ComputerName = $env:COMPUTERNAME,

		[Parameter (HelpMessage = "Default is current directory")]
		[string] $ErrorLog = "$($PSScriptRoot)\Get-OSInfo_Error.txt",

		[Parameter (HelpMessage = "Enable failed computer logging.")]
		[switch] $LogErrors
	)

	Begin {}

	process {
		foreach ($c in $ComputerName) {
			try {
				$OS = Get-WMIObject Win32_OperatingSystem -ComputerName $c -ErrorAction Stop
				$CS = Get-WMIObject Win32_ComputerSystem -ComputerName $c -ErrorAction Stop
				$BIOS = Get-WMIObject Win32_BIOS -ComputerName $c -ErrorAction Stop
				$displayVersion = Get-ItemPropertyValue "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name DisplayVersion
				$props = @{
					"Computername"   = $c;
					"DisplayVersion" = $displayVersion;
					"OSVersion"      = $OS.Version;
					"SPVersion"      = $OS.ServicePackMajorVersion;
					"OSBuild"        = $OS.BuildNumber;
					"OSArchitecture" = $OS.OSArchitecture;
					"Manufacturer"   = $CS.Manufacturer;
					"Model"          = $CS.Model;
					"SerialNumber"   = $BIOS.SerialNumber
				}
				$obj = New-Object -TypeName PSObject -Property $props
				$obj.psobject.typenames.insert(0, "SmootiTools.OSInfo")
				Write-Output $obj
			}
			Catch {
				if ($LogErrors) {
					$c | Out-File $ErrorLog -Append
				}

				Write-Warning "$($c) has encountered an error."
			}
		}
	}

	End {}
}

function Get-DiskInfo {
	<#
        .SYNOPSIS
            Retrieves hard disk information.
        .NOTES
            Numeric value that corresponds to the type of disk drive this logical disk represents.
            Unknown (0)
            No Root Directory (1)
            Removable Disk (2)
            Local Disk (3)
            Network Drive (4)
            Compact Disc (5)
            RAM Disk (6)
        .PARAMETER ComputerName
            Optional. Name or IP of computer or computers.
			DEFAULT: LocalHost
        .PARAMETER DriveType
            Optional. Specifies which drivetype to look for.
			DEFAULT: 3
        .PARAMETER FreeSpace
            Optional. Specifies the maximum amount of free disk space to look for.
			DEFAULT: 99
        .PARAMETER ErrorLog
            Optional. Path to save error log.
			DEFAULT: $($PSScriptRoot)\Get-OSInfo_Error.txt
        .PARAMETER LogErrors
            Optional. If specified errors will be logged.
        .EXAMPLE
            Get-DiskInfo -ComputerName Computer1
        .EXAMPLE
            "Computer1","Computer2" | Get-DiskInfo
        .EXAMPLE
            Get-DiskInfo -ComputerName Computer1 -LogErrors -FreeSpace 75
        .EXAMPLE
            Get-DiskInfo -ComputerName Computer1,Computer2 -LogErrors -DriveType 4 -FreeSpace 75
        .EXAMPLE
            Get-DiskInfo -ComputerName Computer1 -LogErrors -ErrorLog C:\Users\<user>\Documents\Get-OSInfo_Error.txt
    #>

	param (
		[Parameter (ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True,	HelpMessage = "ComputerName or IP address.")]
		[Alias("Hostname")]
		[ValidateCount(0, 5)]
		[string[]] $ComputerName = $env:ComputerName,

		[Parameter (HelpMessage = "Numeric Hard Drive Type.")]
		[int] $DriveType = 3,

		[Parameter (HelpMessage = "Percent free space threshold.")]
		[int] $FreeSpace = 99,

		[Parameter (HelpMessage = "Default is current directory")]
		[string] $ErrorLog = "$($PSScriptRoot)\Get-DiskInfo_Error.txt",

		[Parameter (HelpMessage = "Enable Failed computer logging.")]
		[Switch] $LogErrors
	)

	Begin {}

	Process {
		foreach ($c in $ComputerName) {
			Try {
				$disks = (Get-WMIObject -Class win32_LogicalDisk -Filter "DriveType=$($DriveType)" -Computer $c -ErrorAction Stop |
					Where-Object { $_.FreeSpace / $_.Size * 100 -lt $FreeSpace })
				foreach ($disk in $disks) {
					$props = @{
						"ComputerName" = $c;
						"Drive"        = $disk.DeviceID;
						"FreeSpace"    = "$($disk.FreeSpace / 1GB -as [int]) GB";
						"Size"         = "$($disk.Size / 1GB -as [int]) GB";
						"FreePercent"  = "$($disk.FreeSpace / $disk.Size * 100 -as [int])%"
					}

					$obj = New-Object -TypeName PSObject -Propert $props
					$obj.psobject.typenames.insert(0, "SmootiTools.DiskInfo")
					Write-Output $obj
				}
			}
			Catch {
				if ($LogErrors) {
					$c | Out-File $ErrorLog -Append
				}

				Write-Warning "$($c) has encountered an error."
			}
		}
	}

	End {}
}

function Invoke-OSSHutdown {
	<#
    .SYNOPSIS
        Offers a variety of ways to shut down one or more computers.
    .NOTES
        0 - Log Off (4 for forced log off)
        1 - Shutdown (5 for forced shutdown)
        2 - Restart (6 for forced restart)
        8 - Power Off (12 for forced power off)
    .PARAMETER ComputerName
        Mandatory. The name or IP address of one or more computers.
    .PARAMETER Action
        Mandatory. The action to take, as defined by Win32_OperatingSystem class Win32Shutdown() method.
    .PARAMETER LogErrors
        Optional. Log failed computer names to a text file.
    .PARAMETER ErrorLog
        Optional. The file name to log computer names to - defaults to c:\errors.txt.
    #>

	[CmdletBinding (SupportsShouldProcess = $True, ConfirmImpact = "High")]
	param (
		[Parameter(ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True, Mandatory = $True, HelpMessage = "Computer name or IP address.")]
		[ValidateCount(0, 5)]
		[string[]] $ComputerName,

		[Parameter (Mandatory = $True, HelpMessage = "Action to take.")]
		[ValidateSet("LogOff", "ShutDown", "Restart", "PowerOff")]
		[string] $Action,

		[Parameter (HelpMessage = "Forces action.")]
		[switch] $Force,

		[Parameter (HelpMessage = "Default is current directory")]
		[string] $ErrorLog = "$($PSScriptRoot)\Invoke_OSShutdown_Error.txt",

		[Parameter (HelpMessage = "Log failed computers.")]
		[Switch] $LogErrors
	)

	Begin {
		switch ($Action) {
			"LogOff" { $RealAction = 0 }
			"Shutdown" { $RealAction = 1 }
			"Restart" { $RealAction = 2 }
			"PowerOff" { $RealAction = 8 }
		}
		if ($Force) {
			$RealAction += 4
		}
	}

	Process {
		foreach ($c in $ComputerName) {
			Try {
				Get-WmiObject -Class Win32_OperatingSystem -ComputerName $c -ErrorAction Stop |
				Invoke-WmiMethod -Name Win32Shutdown -Arg $RealAction |
				Out-Null
			}
			Catch {
				if ($LogErrors) {
					$c | Out-File $ErrorLog -Append
				}

				Write-Warning "$($c) has encountered an error."
			}
		}
	}

	End {}
}

function Get-ComputerVolumeInfo {
	<#
        .SYNOPSIS
            Retrieves extended computer system information.
        .PARAMETER ComputerName
            Optional. The name or IP address of one or more computers.
        .PARAMETER LogErrors
            Optional. Log failed computer names to a text file.
        .PARAMETER ErrorLog
            Optional. The file name to log computer names to - defaults to c:\errors.txt.
    #>

	param (
		[Parameter(ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
		[string[]] $ComputerName = $env:ComputerName,

		[string] $ErrorLog = "C:\\Scripts\Get-ComputerInfo_Error.txt",

		[switch] $LogErrors
	)

	Begin {}

	Process {
		foreach ($c in $computerName) {
			Try {
				$OS = Get-WMIObject Win32_OperatingSystem -ComputerName $c -ErrorAction Stop
				$disks = Get-WMIObject Win32_LogicalDisk -ComputerName $c -ErrorAction Stop
				$svcs = Get-WMIObject Win32_Service -ComputerName $c -ErrorAction Stop
				$procs = Get-WMIObject Win32_Process -ComputerName $c -ErrorAction Stop
				$props = @{
					"ComputerName" = $c;
					"OSVerion"     = $OS.Version;
					"SPVersion"    = $OS.ServicePackMajorVersion;
					"LocalDisks"   = $disks;
					"Services"     = $svcs;
					"Processes"    = $procs
				}

				$obj = New-Object -TypeName PSObject -Property $Props
				Write-Output $obj
			}
			Catch {
				if ($LogErrors) {
					$c | Out-File $ErrorLog -Append
				}

				Write-Warning "$($c) has encountered an error."
			}
		}
	}

	End {}
}

function Get-ProcessorInfo {
	<#
        .Synopsis
            Retrieves processor information.
        .PARAMETER ComputerName
            Optional. Name or IP of computer or computers.
			DEFAULT: LocalHost
        .PARAMETER ErrorLog
            Optional. Path to save error log.
			DEFAULT: $($PSScriptRoot)\Get-ProcessorInfo_Error.txt
        .PARAMETER LogErrors
            Optional. If specified errors will be logged.
        .EXAMPLE
            Get-ProcessorInfo -ComputerName Computer1
        .EXAMPLE
            "Computer1","Computer2" | Get-ProcessorInfo
        .EXAMPLE
            Get-ProcessorInfo -ComputerName Computer1,Computer2 -LogErrors
        .EXAMPLE
            Get-ProcessorInfo -ComputerName Computer1 -LogErrors -ErrorLog C:\Users\<user>\Documents\Get-ProcessorInfo_Error.txt
    #>

	param (
		[Parameter (ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True, HelpMessage = "ComputerName or IP address.")]
		[Alias("Hostname")]
		[ValidateCount(0, 5)]
		[string[]] $ComputerName = $env:COMPUTERNAME,

		[Parameter (HelpMessage = "Default is current directory")]
		[string] $ErrorLog = "$($PSScriptRoot)\Get-ProcessorInfo_Error.txt",

		[Parameter (HelpMessage = "Enable failed computer logging.")]
		[switch] $LogErrors
	)

	Begin {}

	process {
		foreach ($c in $ComputerName) {
			try {
				$processors = (Get-WmiObject -Class Win32_Processor -ComputerName $c -ErrorAction Stop)
				foreach ($processor in $processors) {
					$props = @{
						"ComputerName"      = $c;
						"Manufacturer"      = $processor.Manufacturer;
						"Name"              = $processor.Name;
						"Cores"             = $processor.NumberOfCores;
						# "Threads"      = $processor.ThreadCount;
						# "ThreadsPerProcessor"   = $processor.ThreadCount / $processor.NumberOfCores;
						"LogicalProcessors" = $processor.NumberOfLogicalProcessors
					}

					$obj = New-Object -TypeName PSObject -Property $props
					$obj.psobject.typenames.insert(0, "SmootiTools.ProcessorInfo")
					Write-Output $obj
				}
			}
			Catch {
				if ($LogErrors) {
					$c | Out-File $ErrorLog -Append
				}
				Write-Warning "$($c) has encountered an error."
			}
		}
	}

	End {}
}

function Get-GraphicsCardInfo {
	<#
        .Synopsis
            Retrieves graphics card information.
        .PARAMETER ComputerName
            Optional. Name or IP of computer or computers.
			DEFAULT: LocalHost
        .PARAMETER ErrorLog
            Optional. Path to save error log.
			DEFAULT: $($PSScriptRoot)\Get-GraphicsCardInfo_Error.txt
        .PARAMETER LogErrors
            Optional. If specified errors will be logged.
        .EXAMPLE
            Get-GraphicsCardInfo -ComputerName Computer1
        .EXAMPLE
            "Computer1","Computer2" | Get-GraphicsCardInfo
        .EXAMPLE
            Get-GraphicsCardInfo -ComputerName Computer1,Computer2 -LogErrors
        .EXAMPLE
            Get-GraphicsCardInfo -ComputerName Computer1 -LogErrors -ErrorLog C:\Users\<user>\Documents\Get-GraphicsCardInfo.txt
    #>

	param (
		[Parameter (ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True, HelpMessage = "ComputerName or IP address.")]
		[Alias("Hostname")]
		[ValidateCount(0, 5)]
		[string[]] $ComputerName = $env:COMPUTERNAME,

		[Parameter (HelpMessage = "Default is current directory")]
		[string] $ErrorLog = "$($PSScriptRoot)\Get-GraphicsCardInfo_Error.txt",

		[Parameter (HelpMessage = "Enable failed computer logging.")]
		[switch] $LogErrors
	)

	Begin {}

	process {
		foreach ($c in $ComputerName) {
			try {
				$graphicsCards = (Get-WmiObject -Class win32_VideoController -ComputerName $c -ErrorAction Stop)
				foreach ($graphicsCard in $graphicsCards) {
					$props = @{
						"ComputerName"  = $c;
						"Manufacturer"  = $graphicsCard.AdapterCompatibility;
						"Name"          = $graphicsCard.Name;
						"VRAM"          = "$($graphicsCard.AdapterRAM / 1GB -as [int])GB";	# ! This WMI query returns an inaccurate value
						"DriverVersion" = $graphicsCard.DriverVersion
					}
					$obj = New-Object -TypeName PSObject -Property $props
					$obj.psobject.typenames.insert(0, "SmootiTools.GraphicsCardInfo")
					Write-Output $obj
				}
			}
			Catch {
				if ($LogErrors) {
					$c | Out-File $ErrorLog -Append
				}
				Write-Warning "$($c) has encountered an error."
			}
		}
	}

	End {}
}

function Get-PhysicalMemoryInfo {
	<#
        .Synopsis
            Retrieves physical memory information.
        .PARAMETER ComputerName
            Optional. Name or IP of computer or computers.
			DEFAULT: LocalHost
        .PARAMETER ErrorLog
            Optional. Path to save error log.
			DEFAULT: $($PSScriptRoot)\Get-PhysicalMemoryInfo_Error.txt
        .PARAMETER LogErrors
            Optional. If specified errors will be logged.
        .EXAMPLE
            Get-PhysicalMemoryInfo -ComputerName Computer1
        .EXAMPLE
            "Computer1","Computer2" | Get-PhysicalMemoryInfo
        .EXAMPLE
            Get-PhysicalMemoryInfo -ComputerName Computer1,Computer2 -LogErrors
        .EXAMPLE
            Get-PhysicalMemoryInfo -ComputerName Computer1 -LogErrors -ErrorLog C:\Users\<user>\Documents\Get-PhysicalMemoryInfo_Error.txt
    #>

	param (
		[Parameter (ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True, HelpMessage = "ComputerName or IP address.")]
		[Alias("Hostname")]
		[ValidateCount(0, 5)]
		[string[]] $ComputerName = $env:COMPUTERNAME,

		[Parameter (HelpMessage = "Default is current directory")]
		[string] $ErrorLog = "$($PSScriptRoot)\Get-PhysicalMemoryInfo_Error.txt",

		[Parameter (HelpMessage = "Enable failed computer logging.")]
		[switch] $LogErrors
	)

	Begin {}

	process {
		foreach ($c in $ComputerName) {
			try {
				$i = 0
				$physicalMemorys = (Get-WmiObject win32_physicalmemory -ComputerName $c -ErrorAction Stop)
				$totalPhysicalMemory = 0
				foreach ($physicalMemory in $physicalMemorys) {
					$props = @{
						"ComputerName" = $c;
						"Manufacturer" = $physicalMemory.Manufacturer;
						"Capacity"     = "$($physicalMemory.Capacity / 1GB -as [int])GB"
						"Speed"        = "$($physicalMemory.ConfiguredClockSpeed)MHz";
						"Location"     = $physicalMemory.DeviceLocator;
						"SerialNumber" = $physicalMemory.Serialnumber
					}
					$totalPhysicalMemory = $totalPhysicalMemory + ($physicalMemory.Capacity / 1GB -as [int])
					$obj = New-Object -TypeName PSObject -Property $props
					$obj.psobject.typenames.insert(0, "SmootiTools.PhysicalMemoryInfo")
					Write-Output $obj
				}
			}
			Catch {
				if ($LogErrors) {
					$c | Out-File $ErrorLog -Append
				}
				Write-Warning "$($c) has encountered an error."
			}
		}
	}

	End {}
}

Function Get-InstalledSoftware {
	<#
        .Synopsis
            Gets installed software on system.
        .EXAMPLE
            Get-InstalledSoftware
    #>

	$SoftwareList = New-Object System.Collections.Generic.List[System.Object]
	$OSArch = (Get-CimInstance Win32_OperatingSystem).OSArchitecture
	Switch ($OSArch) {
		"64-Bit" {
			$RegPath = @("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall")
		}
		Default {
			$RegPath = @("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")
		}
	}
	ForEach ($Path in $RegPath) {
		$RegKeys += (Get-ChildItem -Path $Path -ErrorAction SilentlyContinue).Name.Replace("HKEY_LOCAL_MACHINE", "HKLM:")
	}

	ForEach ($Key in $RegKeys) {
		Try {
			$Properties = Get-ItemProperty -Path $Key -ErrorAction SilentlyContinue # A corrupt registry value will cause this to fail.  If so then we do this a different, though slower way, below.

			If ($Properties.DisplayName) {
				$DisplayName = ($Properties.DisplayName).Trim()
			}
			Else {
				$DisplayName = ""
			}

			If ($Properties.DisplayVersion) {
				$DisplayVersion = ($Properties.DisplayVersion -replace "[^a-zA-Z0-9.-_()]").Trim()
			}
			Else {
				$DisplayVersion = ""
			}

			If ($Properties.Publisher) {
				$Publisher = ($Properties.Publisher).Trim()
			}
			Else {
				$Publisher = ""
			}

			if ($Properties.UninstallString) {
				$Uninstall_String = ($Properties.UninstallString.Trim())
			}
			Else {
				$Uninstall_String = ""
			}

			If ($Properties.InstallLocation) {
				$InstallLocation = ($Properties.InstallLocation).Trim()
			}
			Else {
				$InstallLocation = ""
			}

			If ($Properties.SystemComponent) {
				$SystemComponent = $Properties.SystemComponent
			}
			Else {
				$SystemComponent = ""
			}

			If ($Properties.ParentKeyName) {
				$ParentKeyName = $Properties.ParentKeyName
			}
			Else {
				$ParentKeyName = ""
			}
		}
		Catch {
			# If above method fails, then do this
			Try {
				$DisplayName = (Get-ItemPropertyValue $Key -Name DisplayName).Trim()
			}
			Catch {
				$DisplayName = ""
			}

			Try {
				$DisplayVersion = (Get-ItemPropertyValue $Key -Name DisplayVersion).Replace("[^a-zA-Z0-9.-_()]", "").Trim()
			}
			Catch {
				$DisplayVersion = ""
			}

			Try {
				$Publisher = (Get-ItemPropertyValue $Key -Name Publisher).Trim()
			}
			Catch {
				$Publisher = ""
			}

			Try {
				$Uninstall_String = (Get-ItemPropertyValue $key -Name UninstallString).Trim()
			}
			Catch {
				$Uninstall_String = ""
			}

			Try {
				$InstallLocation = (Get-ItemPropertyValue $Key -Name InstallLocation).Trim()
			}
			Catch {
				$InstallLocation = ""
			}

			Try {
				$SystemComponent = (Get-ItemPropertyValue $Key -Name SystemComponent).Trim()
			}
			Catch {
				$SystemComponent = ""
			}

			Try {
				$ParentKeyName = (Get-ItemPropertyValue $Key -Name ParentKeyName).Trim()
			}
			Catch {
				$ParentKeyName = ""
			}

		}

		If ($DisplayName -and $SystemComponent -ne 1 -and (-Not($ParentKeyName))) {
			$NewObj = [PSCustomObject]@{
				DisplayName     = $DisplayName
				DisplayVersion  = $DisplayVersion
				Publisher       = $Publisher
				InstallLocation = $InstallLocation
				UninstallString = $Uninstall_String
			}

			$SoftwareList.Add($NewObj)
		}
	}

	Return $SoftwareList | Select-Object * -Unique | Sort-Object DisplayName
}

function Get-UserSession {
	<#
			.Synopsis
				Gets user sessions from remote computer.
			.PARAMETER ComputerName
				Mandatory. Name or IP of computer.
			.EXAMPLE
				Get-UserSession -ComputerName Computer1
		#>

	param (
		[Parameter (Mandatory = $true)]
		[string] $ComputerName
	)

	$ErrorActionPreference = "Stop"
	Try {
		$Users = query user /server:$ComputerName
		$Users = $Users | ForEach-Object {
				(($_.trim() -replace ">" -replace "(?m)^([A-Za-z0-9]{3,})\s+(\d{1,2}\s+\w+)", '$1  none  $2' -replace "\s{2,}", "," -replace "none", $null))
		} | ConvertFrom-Csv
	}
	Catch [System.Management.Automation.RemoteException] {
		Write-Warning "Machine is either not online or unreachable."
	}

	return $Users
}

function Enter-RDPSession {
	<#
			.Synopsis
				Initiates an rdp session.
			.PARAMETER ComputerName
				Mandatory. Name or IP of computer.
			.PARAMETER ID
				Optional. Session ID of user you wish to shadow.
			.PARAMETER Control
				Optional. If specified session will be able to be controlled.
			.EXAMPLE
				Start-RDPSession -ComputerName Computer1
			.EXAMPLE
				Start-RDPSession -ComputerName Computer2 -ID 1
			.EXAMPLE
				Start-RDPSession -ComputerName Computer2 -ID 1 -Control
		#>

	Param (
		[Parameter (Mandatory = $true)]
		[string] $ComputerName,

		[Parameter (Mandatory = $false)]
		[int] $ID = $null,

		[switch] $Control
	)

	Try {
		if ($Control) {
			mstsc.exe /v:$ComputerName /Shadow:$ID /Control
		}
		elseif ($ID) {
			mstsc.exe /v:$ComputerName /Shadow:$ID
		}
		else {
			mstsc.exe /v:$ComputerName
		}
	}
	Catch [System.Management.Automation.RemoteException] {
		Write-Warning "Machine is either not online or unreachable."
	}
}
