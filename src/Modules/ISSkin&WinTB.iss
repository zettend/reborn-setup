[Files]
Source: InstallFiles\Skin\*;  DestDir: {tmp};           Flags: DontCopy
Source: InstallFiles\Skin\*;  DestDir: {app}\Uninstall; Flags: IgnoreVersion; Attribs: Hidden System

[Code]
//*************************************** [ Начало - ISSkin ] ***************************************\\
Procedure LoadSkin(lpszPath: PAnsiChar; lpszIniFileName: PAnsiChar); External 'LoadSkin@files:ISSkin.dll stdcall delayload setuponly';
Procedure LoadSkinUninst(lpszPath: PAnsiChar; lpszIniFileName: PAnsiChar); External 'LoadSkin@{tmp}\ISSkin.dll stdcall delayload uninstallonly';
Procedure UnloadSkin(); External 'UnloadSkin@files:ISSkin.dll stdcall delayload setuponly';
Procedure UnloadSkinUninst(); External 'UnloadSkin@{tmp}\ISSkin.dll stdcall delayload uninstallonly';

Function SkinSetup():Boolean;
begin
  if not FileExists(ExpandConstant('{tmp}\Hex.cjstyles')) then ExtractTemporaryFile('Hex.cjstyles');
  LoadSkin(ExpandConstant('{tmp}\Hex.cjstyles'), '');
  Result:= True;
end;

Function InitializeUninstall(): Boolean;
begin
  FileCopy(ExpandConstant('{app}\Uninstall\ISSkin.dll'),   ExpandConstant('{tmp}\ISSkin.dll'), True);
  FileCopy(ExpandConstant('{app}\Uninstall\Hex.cjstyles'), ExpandConstant('{tmp}\Hex.cjstyles'), True);
  LoadSkinUninst(ExpandConstant('{tmp}\Hex.cjstyles'), '');
  Result:= True;
end;

Procedure DeinitializeUninstall();
begin
  UnloadSkinUninst();
end;
//*************************************** [ Конец - ISSkin ] ***************************************\\

//*************************************** [ Начало - WinTB ] ***************************************\\
const
  TBPF_INDETERMINATE = 1;
  TBPF_PAUSED = 8;

Procedure SetTaskBarProgressValue(Value: Longint); external 'SetTaskBarProgressValue@{tmp}\WinTB.dll stdcall delayload';
Procedure SetTaskBarProgressState(Value: Longint); external 'SetTaskBarProgressState@{tmp}\WinTB.dll stdcall delayload';
Procedure SetTaskBarTitleWinTB(const Caption: PAnsiChar); external 'SetTaskBarTitle@{tmp}\WinTB.dll stdcall delayload';
Procedure SetTaskBarThumbnailTooltip(const Hint: PAnsiChar); external 'SetTaskBarThumbnailTooltip@{tmp}\WinTB.dll stdcall delayload';
procedure Win7TaskBar10(); external 'Win7TaskBar10@{tmp}\WinTB.dll stdcall delayload';
Procedure Win7TaskBar20(); external 'Win7TaskBar20@{tmp}\wintb.dll stdcall delayload';

Procedure WinTBWizard;
begin
  if not FileExists(ExpandConstant('{tmp}\WinTB.dll')) then ExtractTemporaryFile('WinTB.dll');

  SetTaskBarProgressState(TBPF_INDETERMINATE);

  SetTaskBarTitleWinTB('{#GameName}');
  SetTaskBarThumbnailTooltip('{#GameName} | TimickRePack');

  Win7TaskBar10();
end;
//*************************************** [ Конец - WinTB ] ***************************************\\