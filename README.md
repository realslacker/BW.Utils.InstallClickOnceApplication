# BW.Utils.InstallClickOnceApplication
Small utility module to handle installing ClickOnce apps. Most of the code
comes from a script by [Jonathon Chupinsky](https://techcommunity.microsoft.com/t5/user/viewprofilepage/user-id/147200)'s
[post](https://techcommunity.microsoft.com/t5/office-365/export-to-pst-via-powershell/m-p/95007)
on Microsoft Tech Community. I have just reformatted and packaged the code
for PSGallery.

# Usage
```powershell
PS C:\> $ManifestURI = 'https://complianceclientsdf.blob.core.windows.net/v16/Microsoft.Office.Client.Discovery.UnifiedExportTool.application'
PS C:\> Install-ClickOnceApplication $ManifestURI -Elevate
```
