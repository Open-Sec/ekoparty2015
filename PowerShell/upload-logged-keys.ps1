$sourceFilePath = "c:\Users\Test\log.txt"
$targetAddress = "http://192.168.56.1/acme/reportes/"
$webClient = New-Object System.Net.WebClient
$webClient.UploadFile($targetAddress, "PUT", $sourceFilePath)
