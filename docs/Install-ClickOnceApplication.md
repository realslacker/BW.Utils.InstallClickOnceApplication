---
external help file: BW.Utils.InstallClickOnceApplication-help.xml
Module Name: BW.Utils.InstallClickOnceApplication
online version:
schema: 2.0.0
---

# Install-ClickOnceApplication

## SYNOPSIS
Installs a ClickOnce application.

## SYNTAX

```
Install-ClickOnceApplication [-ManifestUri] <Uri> [-Elevate] [-ManifestTimeout <Int32>]
 [-DownloadTimeout <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Installs a ClickOnce application given a manifest URI.

## EXAMPLES

### Example 1
```powershell
PS C:\> $ManifestURI = 'https://complianceclientsdf.blob.core.windows.net/v16/Microsoft.Office.Client.Discovery.UnifiedExportTool.application'
PS C:\> Install-ClickOnceApplication $ManifestURI -Elevate
```

Installs the Microsoft UnifiedExportTool.

## PARAMETERS

### -ManifestUri
The URI of the manifest to be installed.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: Uri

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Elevate
Attempt to elevate permissions if required.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ManifestTimeout
How long to wait for the manifest to download.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DownloadTimeout
How long to wait for the application to download.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
