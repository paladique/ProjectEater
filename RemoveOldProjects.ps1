#
# GatherProjects.ps1
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

"These are over 14 days old, which would you like to delete?"


foreach ($item in $OldProjects)
{
	Write-Host  $OldProjects.IndexOf($item):  $item.Name  
}

"Press any key to continue, separate mutliple projects with commas."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

$toDelete = Read-Host

if($toDelete.Length -gt 0)
{
	foreach ($item in $toDelete.Split(","))
	{
	   Remove-Item $OldProjects.Item($item) -Recurse -Force 
	}
}
