#
# Script1.ps1
#

$items = Get-ChildItem -Path "C:\users\Jasmine Greenaway\Documents\Visual Studio 2015\Projects"

[System.Collections.ArrayList]$OldProjects 

foreach ($item in $items)
{
      if ($item.Attributes -eq "Directory")
      {
            Write-Host $item.Name
			Write-Host $item.LastAccessTime
			$end = Get-Date
			$span = NEW-TIMESPAN –Start $item.LastAccessTime –End $end

			$span.Days

			if($span.Days -ge 14 )
			{
			   "this shit's old"	
			}
      }
}