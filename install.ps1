# Array to store switches
$switches = @() 

# Get installers in C:\Installers folder
$installers = Get-ChildItem C:\Users\kareem\Downloads*.exe, C:\Users\kareem\Downloads*.msi

foreach ($installer in $installers) {

  # Extract switches
  $arguments = Get-CommandLine $installer.FullName

  # Get silent install switch
  $silentSwitch = $arguments | Where-Object {$_ -like "-s" -or $_ -like "/s" -or $_ -like "/q"}

  if($silentSwitch) {
    
    # Build object with switch and file name
    $obj = [PSCustomObject]@{
      File = $installer.Name
      Switch = $silentSwitch
    }

    # Add to array
    $switches += $obj

  }

}

# Export array to CSV
$switches | Export-Csv -Path C:\switches.csv -NoTypeInformation