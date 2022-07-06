#requires -module SmootiTools

do {
	Write-Host "     SERVICE MENU      "
	Write-Host "======================"
	Write-Host "1. System Information"
	Write-Host "2. Disk Information"
	Write-Host "3. Restart a Computer"
	Write-Host "`nCtrl+C or Q to exit`n"
	$choice = Read-Host "Selection"
	switch ($choice) {
		1 {
			$computers = @()
			do {
				$x = Read-Host "`nEnter one computer name to target"
				if ($x -ne "") {
					$computers += $x
				}
				Get-OSInfo -ComputerName $computers
			}
			until ($x -eq "")
		}

		2 {
			$computers = @()
			do {
				$x = Read-Host "`nEnter one computer name to target"
				if ($x -ne "") {
					$computers += $x
				}
				Get-DiskInfo -ComputerName $computers
			}
			until ($x -eq "")
		}

		3 {
			$computers = @()
			do {
				$x = Read-Host "`nEnter one computer name to target"
				if ($x -ne "") {
					$computers += $x
				}
				Invoke-OSSHutdown -ComputerName $computers -Action Restart
			}
			until ($x -eq "")
		}
	}
}
While ($choice -ne "q" -or $choice -ne "Q")