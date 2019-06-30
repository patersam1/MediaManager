param($path, $name, $category, $tag)
$source = 'TestSource'
$tvShowDest = 'TestTVShowDest'
$moviesDest = 'TestMoviesDest'

Write-Host $path
Write-Host $name
Write-Host $category
Write-Host $tag

$libIndex = 0
if($category -eq "Movie"){
    Write-Host "moving Movie"
    Move-Item -path $path -Destination "D:\Temp"
    $libIndex = 29
}else{
    Write-Host "A TV show"
    $libIndex = 30
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
#& "/path/to/Plex Media Scanner --scan --refresh --section $libIndex"
Read-Host -Prompt "Press any key to continue"


