[Code]
const
  TBPF_INDETERMINATE = 1;
  TBPF_PAUSED = 8;

procedure SetupPreview(handle: hwnd); external 'SetupPreview@{tmp}\WinTB.dll stdcall delayload';
procedure SetTaskBarProgressValue(value: integer); external 'SetTaskBarProgressValue@{tmp}\WinTB.dll stdcall delayload';
procedure SetTaskBarProgressState(value: integer); external 'SetTaskBarProgressState@{tmp}\WinTB.dll stdcall delayload';
procedure SetTaskBarTitleWinTB(const Caption: String); external 'SetTaskBarTitle@{tmp}\wintb.dll stdcall delayload';
procedure SetTaskBarThumbnailTooltip(const Caption: String); external 'SetTaskBarThumbnailTooltip@{tmp}\wintb.dll stdcall delayload';
procedure SetTaskBarOverlayIcon(hIcon: HICON); external 'SetTaskBarOverlayIcon@{tmp}\wintb.dll stdcall delayload';

Procedure WinTBWizard();
begin
  if not FileExists(ExpandConstant('{tmp}\WinTB.dll')) then ExtractTemporaryFile('WinTB.dll');

  SetTaskBarProgressState(TBPF_INDETERMINATE);

  SetTaskBarTitleWinTB('{#GameName}');
  SetTaskBarThumbnailTooltip('{#GameName} | TimickRePack');

  SetupPreview(WizardForm.Handle);
end;