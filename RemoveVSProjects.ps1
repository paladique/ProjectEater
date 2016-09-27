#
# RemoveVSProjects.ps1
#

	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$False,Position=1)]
		[string]$path
	   )


	$items = Get-ChildItem -Path $path

	[System.Collections.ArrayList]$OldProjects = New-Object System.Collections.ArrayList


	foreach ($item in $items)
	{
		  if ($item.Attributes -eq "Directory")
		  {
				$end = Get-Date
				$span = NEW-TIMESPAN –Start $item.LastAccessTime –End $end

				if($span.Days -ge 14 -and $item.GetFiles("*.sln").count -gt 0)
				{
					[void]$OldProjects.add($item)	
				}
		  }
	}

	if($OldProjects.Count -gt 0) {
		"These are over 14 days old, which would you like to delete?"
	}
	else {
		"You don't have any projects to remove, congrats!"
		return 
	}

	foreach ($item in $OldProjects)
	{
		Write-Host  $OldProjects.IndexOf($item):  $item.Name  
	}

	"Separate mutliple projects with commas."

	$toDelete = Read-Host

	if($toDelete.Length -gt 0)
	{
		foreach ($item in $toDelete.Split(","))
		{
		   Remove-Item (Join-Path $path $OldProjects.Item($item)) -Recurse -Force
		}
	}