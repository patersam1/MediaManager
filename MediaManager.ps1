param($path, $name, $category)
$source = 'TestSource'
$tvShowDest = 'D:\Temp'
$moviesDest = 'D:\Movies'
$compDownloadsDir = "C:\Users\Media\Downloads\Completed\*"
Write-Host $path
Write-Host $name
Write-Host $category

$libIndex = 0
if($category -eq "Movie"){
    Write-Host "moving Movie"
	Move-Item -Path $compDownloadsDir -Destination $moviesDest -Force
    $libIndex = 1
}else{
    Write-Host "A TV show"
    $libIndex = 2
    # $sourceChildren = Get-ChildItem -Path $source -Include *.mp4, *.mkv -Recurse
    # foreach ($child in $sourceChildren){
    # Write-Host $child.Name

    # # $child.Name -match "S\d\dE\d\d"
    # $newName
    # #determine if a tv show or movie
    #     if ($child.Name -match "S\d\dE\d\d"){
            
    #         $epInfo = $matches[0]
            
    #         $epInfo -match "((?<=S)\d+)"
    #         $season = $matches[0]
    #         $epInfo -match "((?<=E)\d+)"
    #         $ep = $matches[0]
    #         #add file to this season dir if not already one
    #         Write-Host $child.Name $season $ep
    #     }
    # }

}
"C:\Program Files (x86)\Plex\Plex Media Server\Plex Media Scanner.exe" --scan --section $libIndex
Read-Host -Prompt "Press any key to continue"


