#
# GatherProjects.ps1
#

$items = Get-ChildItem -Path "C:\users\Jasmine Greenaway\Documents\Visual Studio 2015\Projects"

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
"Separate mutliple projects with commas"


foreach ($item in $OldProjects)
{
	Write-Host  $OldProjects.IndexOf($item):  $item.Name  
}

$toDelete = Read-Host

foreach ($item in $toDelete.Split(","))
{
  $item
}
