#The below PowerShell script helps to Sets the CacheControl property for all the Blobs within the Container.



#Disclaimer

#The sample scripts are not supported under any Microsoft standard support program or service.
#The sample scripts are provided AS IS without warranty of any kind. Microsoft further disclaims all implied warranties including,
#without limitation, any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you. In no event shall Microsoft, its authors, owners of this repository or anyone else involved in the creation, production, or delivery of the scripts be liable for any damages whatsoever (including,
#without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages

# Note: This can have a performance impact/can fail if you have huge amount of blobs in a single container

################# Script BEGIN ####################   

# Create a storage context
$context = New-AzStorageContext -StorageAccountName "StorageAccountName" -StorageAccountKey "StorageAccountKeyvalue"

$MaxReturn = 5000 
$Token = $Null  

# Get a reference to the blob
$blobs = Get-AzStorageBlob -Context $context -Container "ContainerName" -MaxCount $MaxReturn -ContinuationToken $Token
do
{
foreach($blob in $blobs)
{

# Set the CacheControl property
# Set the CacheControl property to expire in 1 hour (3600 seconds ->max-age=3600)
#If we use no-store : it indicates that any caches of any kind will not be storing the response. We get the response from Server
#If we use no-cache : the response may get stored in browser cache, but it gets validated every time with the server before reuse using ETag value. Hence, there are chances that browser sends the cache content next time

$blob.ICloudBlob.Properties.CacheControl = "CacheControlValue"

# Send the update to the cloud
$blob.ICloudBlob.SetProperties()
$Token = $Blobs[$Blobs.Count -1].ContinuationToken;
}
}
while($Token -ne $Null)

################# Script END ####################  

