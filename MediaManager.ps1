param($path, $name, $category, $tag)
$source = 'TestSource'
$tvShowDest = 'TestTVShowDest'
$moviesDest = 'TestMoviesDest'

Write-Host $path
Write-Host $name
Write-Host $category
Write-Host $tag

if($category -eq "Movie"){
    Write-Host "moving Movie"
    Move-Item -path $path -Destination "D:\Temp"
    Remove-Item -path $path -Recurse 
}else{
    Write-Host "A TV show"
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
Read-Host -Prompt "Press any key to continue"


