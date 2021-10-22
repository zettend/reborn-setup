[Files]
Source: InstallFiles\MusicFiles\*.*; Flags: DontCopy DeleteAfterInstall

[Code]
var
 MusicButton, mp3Handle: HWND;
 
Function BASS_Init(device: Integer; freq, flags: DWORD; win: hwnd; CLSID: Integer): Boolean; External 'BASS_Init@files:BASS.dll stdcall delayload';
Function BASS_Start: Boolean; External 'BASS_Start@files:BASS.dll stdcall delayload';
Function BASS_ChannelPlay(handle: DWORD; restart: BOOL): Boolean; External 'BASS_ChannelPlay@files:BASS.dll stdcall delayload';
Function BASS_ChannelIsActive(handle: DWORD): Integer; External 'BASS_ChannelIsActive@files:BASS.dll stdcall delayload';
Function BASS_ChannelPause(handle: DWORD): Boolean; External 'BASS_ChannelPause@files:BASS.dll stdcall delayload';
Function BASS_Pause: Boolean; External 'BASS_Pause@files:BASS.dll stdcall delayload';
Function BASS_Stop: Boolean; External 'BASS_Stop@files:BASS.dll stdcall delayload';
Function BASS_Free: Boolean; External 'BASS_Free@files:BASS.dll stdcall delayload';
Function BASS_StreamCreateFileLib(MEM: BOOL; fil: PAnsiChar; offset, length, flags: DWORD): DWORD; External 'BASS_StreamCreateFile@{tmp}\bp.dll stdcall delayload';

Function BASS_StreamCreateFile(MEM: BOOL; Fil: AnsiString; OffSet, Flags: DWORD): DWORD;
var
  Size: LongInt;
  Buffer: AnsiString;
begin
  if MEM then begin
    Size := ExtractTemporaryFileSize(Fil);
    SetLength(Buffer, Size);
    ExtractTemporaryFileToBuffer(Fil, Cast{#defined UNICODE ? "Ansi" : ""}StringToInteger(Buffer));
    Result := BASS_StreamCreateFileLib(MEM, Buffer, 0, Size, Flags);
  end else
    Result := BASS_StreamCreateFileLib(MEM, Fil, OffSet, 0, Flags);
end;

Procedure MusicButtonClick(hBtn:HWND);
begin
  SoundClickPlay();
  if BtnGetChecked(MusicButton) then
    BASS_ChannelPause(mp3Handle)
  else if BASS_ChannelIsActive(mp3Handle) = 3 then
    BASS_ChannelPlay(mp3Handle, False);
end;

Procedure InitMusic();
begin
  if not FileExists(ExpandConstant('{tmp}\Bass.dll')) then ExtractTemporaryFile('Bass.dll');
  if not FileExists(ExpandConstant('{tmp}\BP.dll'))   then ExtractTemporaryFile('BP.dll');

  MusicButton := BtnCreate(WizardForm.Handle, ScaleX(906), ScaleY(7), ScaleX(25), ScaleY(25), 'MusicButton.png', 1, True);
  BtnSetCursor(MusicButton, GetSysCursorHandle(32649));
  BtnSetEvent(MusicButton, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(MusicButton, BtnClickEventID, CallBackAddr('MusicButtonClick'));
  BtnSetVisibility(MusicButton, True);

  BASS_Init(-1, 44100, 0, 0, 0);
  mp3Handle := BASS_StreamCreateFile(TRUE, 'Music.mp3', 0, 4);
  BASS_Start();
  BASS_ChannelPlay(mp3Handle, False);
end;

Procedure StopMusic();
begin
  BASS_Stop();
  BASS_Free();
end;