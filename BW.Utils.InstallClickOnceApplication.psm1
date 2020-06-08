using namespace System.Deployment.Application

function Install-ClickOnceApplication {
    # .ExternalHelp BW.Utils.InstallClickOnceApplication-help.xml

    [CmdletBinding()]
    param(

        [Parameter( Mandatory, Position=1 )]
        [Alias('Uri')]
        [uri]
        $ManifestUri,

        [switch]
        $Elevate,

        [int]
        $ManifestTimeout = 15,

        [int]
        $DownloadTimeout = 60

    )

    begin {

        Add-Type -AssemblyName System.Deployment

        Write-Verbose 'Starting installation of ClickOnce application manifest'
        Write-Verbose ( 'Manifest URI: ' + $ManifestUri.AbsoluteUri )

        $HostingManager = New-Object InPlaceHostingManager -ArgumentList $ManifestUri, $false

        # register event for manifest download completion
        Register-ObjectEvent -InputObject $HostingManager -EventName GetManifestCompleted -Action {
            
            Write-Information ( 'Processing manifest for {0}' -f $Event.SourceEventArgs.ProductName ) -InformationAction Continue

            New-Event -SourceIdentifier 'ManifestDownloadComplete'
        
        } > $null

        # register event for application download completion
        Register-ObjectEvent -InputObject $HostingManager -EventName DownloadApplicationCompleted -Action {

            New-Event -SourceIdentifier 'DownloadApplicationCompleted'
        
        } > $null

    }

    process {

        Write-Verbose 'Starting manifest download...'

        # start manifest download
        $HostingManager.GetManifestAsync()
    
        # wait for download to complete
        $Event = Wait-Event -SourceIdentifier 'ManifestDownloadComplete' -Timeout $ManifestTimeout

        if ( -not $Event ) {

            Write-Error ( 'ClickOnce manifest download timed out after {0} seconds' -f $ManifestTimeout )
            return

        }

        $Event | Remove-Event

        # elevate installation if needed
        $HostingManager.AssertApplicationRequirements( $Elevate )
            
        Write-Verbose 'Manifest download complete, beginning application download...'

        # start application download
        $HostingManager.DownloadApplicationAsync()
            
        # wait for download to complete
        $Event = Wait-Event -SourceIdentifier 'DownloadApplicationCompleted' -Timeout $DownloadTimeout

        if ( -not $Event ) {

            Write-Error ( 'Application download timed out after {0} seconds' -f $DownloadTimeout )
            return

        }

        $Event | Remove-Event

        Write-Verbose 'Application download completed'
    
    }
    
    end {
    
        Get-EventSubscriber |
            Where-Object { $_.SourceObject.ToString() -eq 'System.Deployment.Application.InPlaceHostingManager' } |
            Unregister-Event

        $HostingManager.Dispose()
    
    }

}

