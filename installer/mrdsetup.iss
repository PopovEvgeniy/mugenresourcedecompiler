[Setup]
AppName=MUGEN RESOURCE DECOMPILER
AppVersion=1.8.3
AppPublisher=Tuzik
AppPublisherURL=http://tuzik87.ru54.com/
AppSupportURL=http://tuzik87.ru54.com/
AppUpdatesURL=http://tuzik87.ru54.com/
DefaultDirName={pf}\MUGEN RESOURCE DECOMPILER
DefaultGroupName=MUGEN RESOURCE DECOMPILER
DisableProgramGroupPage=true
OutputDir=C:\MUGEN RESOURCE DECOMPILER
OutputBaseFilename=mrdsetup
Compression=lzma/ultra64
SolidCompression=true
InternalCompressLevel=ultra64
UsePreviousGroup=false
UsePreviousSetupType=false
UsePreviousTasks=false
ShowLanguageDialog=no
MinVersion=4.1.1998,5.0.2195
RestartIfNeededByRun=false
PrivilegesRequired=none
AllowCancelDuringInstall=false
DisableReadyPage=true
Uninstallable=IsTaskSelected('typical')
UsePreviousUserInfo=false
InfoBeforeFile=C:\MUGEN RESOURCE DECOMPILER\Version 1.8.3\deploy\readme.txt
LicenseFile=C:\MUGEN RESOURCE DECOMPILER\Version 1.8.3\deploy\copying.txt

[Types]
Name: Normal; Description: Normal install; Flags: iscustom

[Components]
Name: Main; Description: Program files; Flags: fixed; Types: Normal
Name: Source; Description: Source code

[Tasks]
Name: typical; Description: Typical install; Flags: exclusive
Name: portable; Description: Install to portable media; Flags: exclusive unchecked

[Files]
Source: C:\MUGEN RESOURCE DECOMPILER\Version 1.8.3\deploy\copying.txt; DestDir: {app}
Source: C:\MUGEN RESOURCE DECOMPILER\Version 1.8.3\deploy\mrd.exe; DestDir: {app}
Source: C:\MUGEN RESOURCE DECOMPILER\Version 1.8.3\deploy\readme.txt; DestDir: {app}
Source: C:\MUGEN RESOURCE DECOMPILER\Version 1.8.3\deploy\source.zip; DestDir: {app}; Components: source

[Icons]
Name: {group}\Documentation\Help; Filename: {app}\readme.txt; Flags: runmaximized; Tasks: typical
Name: {group}\Documentation\License; Filename: {app}\copying.txt; Flags: runmaximized; Tasks: typical
Name: {group}\MUGEN RESOURCE DECOMPILER; Filename: {app}\mrd.exe; Tasks: typical
Name: {group}\Source; Filename: {app}\source.zip; Tasks: typical
Name: {group}\Uninstall MUGEN RESOURCE DECOMPILER; Filename: {app}\unins000.exe; Tasks: typical
