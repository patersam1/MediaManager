param($path, $name, $category)
$tvShowDest = 'D:\TV Shows'
$moviesDest = 'D:\Movies'
# $moviesDest = 'TestMoviesDest'
$compDownloadsDir = "C:\Users\Media\Downloads\Completed"
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
		continue
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

        Move-Item $child -Destination $showPath
        #note that if the capitisiation of show names screws up then could create a json with all shows that have been added,
        #then .tolower(), compare key, then get correct capitisiation 
    }else{
        #Movie
        Write-Host "Moving Movie"
        $moviePath = Join-Path -Path $moviesDest -ChildPath $child.Directory.name
        write-host $moviePath
        New-Item -ItemType directory -Path $moviePath

        #move only movie and subtitles
        $movieChildren = Get-ChildItem -LiteralPath $child.Directory -Include *.mp4, *.mkv, *.srt, *.sub
        foreach( $movchild in $movieChildren){
            Move-Item -LiteralPath $movchild -Destination $moviePath
        }

        Remove-Item -LiteralPath $child.Directory -Recurse
        $libIndex = 1
    }

}
#read-host -prompt "press a key"

&"C:\Program Files (x86)\Plex\Plex Media Server\Plex Media Scanner.exe" --scan --section $libIndex


