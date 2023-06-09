#The below PowerShell script helps to get all the blobs of a particular container for a given timerange.

#Disclaimer
#The sample scripts are not supported under any Microsoft standard support program or service. 
#The sample scripts are provided AS IS without warranty of any kind. Microsoft further disclaims all implied warranties including, 
#without limitation, any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you. In no event shall Microsoft, its authors, owners of this repository or anyone else involved in the creation, production, or delivery of the scripts be liable for any damages whatsoever (including, 
#without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages

## Input Parameters  

$resourceGroupName="<rgname>"  
$storageAccName="<storageaccountname>"  
$containerName="<containername>"  
 
## Connect to Azure Account  
Connect-AzAccount   
 
## Function to get all the blobs  
Function GetAllBlobs  
{  
    Write-Host -ForegroundColor Green "Retrieving blobs from storage container.."   
 
    ## Get the storage account   
    $storageAcc=Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccName    
 
    ## Get the storage account context  
    $ctx=$storageAcc.Context  

    ## Get all the containers  
    $containers=Get-AzStorageContainer  -Context $ctx
         
    ## Get all the blobs for a given timerange 
    $blobs=Get-AzStorageBlob -Container $containerName  -Context $ctx `
    | Where-Object{$_.LastModified.DateTime -gt "12/01/2020 00:00:00 AM" -And $_.LastModified.DateTime -lt "01/01/2021 00:00:00 AM"}
   
    ## Loop through all the blobs  
    foreach($blob in $blobs)  
    {  
        write-host -Foregroundcolor Yellow $blob.Name $blob.LastModified.DateTime

    }  
}  
  
GetAllBlobs   
 
## Disconnect from Azure Account  
Disconnect-AzAccount  

