#requires -module SmootiTools

[CmdletBinding()]
Param (
	[ValidateCount(0, 5)]
	[string[]] $ComputerName = $Env:ComputerName,
	[string] $Path = "C:\Scripts"
)

$css = @"
<style>
    body
  {
      background-color: Gainsboro;
  }

    table, th, td{
      border: 1px solid;
    }

    h1{
        background-color:Tomato;
        color:white;
        text-align: center;
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
