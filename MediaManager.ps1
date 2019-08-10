param($path, $name, $category)
$tvShowDest = 'D:\TV Shows'
$moviesDest = 'D:\Movies'
# $moviesDest = 'TestMoviesDest'
$compDownloadsDir = 'C:\Users\Media\Downloads\Completed'
# $compDownloadsDir = "TestSource"
Write-Host $path
Write-Host $name
Write-Host $category

$libIndex = 0
$sourceChildren = Get-ChildItem -Path $compDownloadsDir -Include *.mp4, *.mkv -Recurse
foreach ($child in $sourceChildren){
    Write-Host $child.Name

    #determine if a tv show or movie
    if ($child.Name -match "S\d\dE\d\d"){
		
        $libIndex = 2

        $epInfo = $matches[0]
        
        $epInfo -match "((?<=S)\d+)"
        $season = $matches[0]
        $child.Name -match "^.*(?=(\.S\d))"
        $showName = $matches[0]
        $showName = $showName -replace "\.", " "

        $showPaths = $showName, $season #save duplicate code
        $showPath = $tvShowDest
        foreach( $childPath in $showPaths){
            $showPath = Join-Path -Path $showPath -ChildPath $childPath
            if (-Not (Test-Path $showPath)){
                New-Item -ItemType directory -Path $showPath
            }
        }
		Write-Host "Moving: " $child
        Move-Item -LiteralPath $child -Destination $showPath
		if( $child.directory.name -ne 'Completed'){
			Remove-Item -LiteralPath $child.Directory -Recurse -Force
		}			#moves only the video so deletes the folder if in one
		
        #note that if the capitisiation of show names screws up then could create a json with all shows that have been added,
        #then .tolower(), compare key, then get correct capitisiation 
    }else{
        #Movie
		$libIndex = 1
        #Write-Host "Moving Movie"
        $moviePath = Join-Path -Path $moviesDest -ChildPath $child.Directory.name
        #write-host $moviePath
        New-Item -ItemType directory -Path $moviePath
		
        #move only movie and subtitles
        #$movieChildren = Get-ChildItem -LiteralPath $child.Directory -Force -Recurse -Filter  *.mp4, *.mkv, *.srt, *.sub 
		$includeFilesExtensions = '.mp4', '.mkv', '.srt', '.sub' 
		$movieChildren = Get-ChildItem -LiteralPath $child.Directory -Force -Recurse | Where-Object { $includeFilesExtensions -Contains $_.Extension }
		
        foreach( $movchild in $movieChildren){
			$moveChildPath = Join-Path -Path $child.directory -ChildPath $movchild
			Write-Host "moving " $moveChildPath
            Move-Item -LiteralPath $moveChildPath -Destination $moviePath
        }
		
        Remove-Item -LiteralPath $child.Directory -Recurse -Force
        
    }

}
#read-host -prompt "press a key"

&"C:\Program Files (x86)\Plex\Plex Media Server\Plex Media Scanner.exe" --scan --section $libIndex
exit


