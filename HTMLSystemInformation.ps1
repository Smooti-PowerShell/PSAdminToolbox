#requires -module SmootiTools

[CmdletBinding()]
Param (
	[ValidateCount(0, 5)]
	[string[]] $ComputerName,
	[string] $Path = "C:\Scripts"
)

$css = @"
<style>
body {
 font-family:Tahoma;
 font-size:12px;
}
th {
 font-weight:bold;
}
</style>
"@

foreach ($c in $ComputerName) {

	$FilePath = Join-Path -Path $Path -ChildPath "$($c).html"

	$sys = Get-OSInfo -ComputerName $c |
	ConvertTo-HTML -PreContent "<h2>System Info</h2>" -Fragment |
	Out-String

	$dsk = Get-DiskInfo -ComputerName $c |
	ConvertTo-HTML -PreContent "<h2>Disk Info</h2>" -Fragment |
	Out-String

	$prc = Get-Process -ComputerName $c |
	ConvertTo-HTML -PreContent "<h2>Processes</h2>" -Fragment |
	Out-String

	$svc = Get-Service -ComputerName $c |
	ConvertTo-HTML -PreContent "<h2>Services</h2>" -Fragment |
	Out-String

	$params = @{
		"Head"        = "<title>Report for $c</title>$css";
		"PreContent"  = "<h1>Information for $($c)</h1>";
		"PostContent" = $sys, $dsk, $prc, $svc
	}
	ConvertTo-HTML @params | Out-File -FilePath $FilePath
}
