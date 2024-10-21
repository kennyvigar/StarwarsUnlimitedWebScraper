#Super quick script to play with Invoke-WebRequest... 
#Starwars Unlimited is a trading card game that's been hard to find in store when it first released.   This script helped identify the products in stock. 

#this is for ER Games, and can be expanded for any web store / retailer. 

$content = Invoke-WebRequest -Uri
"https://ergames.ca/search?q=**Star*wars*unlimited*spark*"

Write-Host "start"
$content.AllElements | Where-Object { $_.Class -eq "product Norm" } |
ForEach-Object {
    #trim that return dude
    $text = $_.InnerText.Trim()
    #match product and availability
    $lines = $text -split "`n" | Where-Object { $_.Trim() -ne "" }
    $productName = ($lines | Where-Object { $_ -match "Star Wars
Unlimited*" }).Trim()

    if ($lines -like "*sold out")
    {
        $availability = ($lines | Where-Object { $_ -match "Still sold out... lame dude" }).Trim()
    }
    else
    {
        $availability = "....in stock boieeeeee"

    }

    Write-Host $productName
    Write-Host $availability

}
