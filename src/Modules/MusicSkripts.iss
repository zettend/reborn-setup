[Files]
Source: InstallFiles\MusicFiles\*.*; Flags: DontCopy DeleteAfterInstall

[Code]
var
 MusicButton, mp3Handle: HWND;
 
Function BASS_Init(device: Integer; freq, flags: DWORD; win: hwnd; CLSID: Integer): Boolean; external 'BASS_Init@files:BASS.dll stdcall delayload';
Function BASS_Start: Boolean; external 'BASS_Start@files:BASS.dll stdcall delayload';
Function BASS_ChannelPlay(handle: DWORD; restart: BOOL): Boolean; external 'BASS_ChannelPlay@files:BASS.dll stdcall delayload';
Function BASS_ChannelIsActive(handle: DWORD): Integer; external 'BASS_ChannelIsActive@files:BASS.dll stdcall delayload';
Function BASS_ChannelPause(handle: DWORD): Boolean; external 'BASS_ChannelPause@files:BASS.dll stdcall delayload';
Function BASS_Pause: Boolean; external 'BASS_Pause@files:BASS.dll stdcall delayload';
Function BASS_Stop: Boolean; external 'BASS_Stop@files:BASS.dll stdcall delayload';
Function BASS_Free: Boolean; external 'BASS_Free@files:BASS.dll stdcall delayload';
Function BASS_StreamCreateFileLib(MEM: BOOL; fil: PAnsiChar; offset, length, flags: DWORD): DWORD; external 'BASS_StreamCreateFile@{tmp}\bp.dll stdcall delayload';

Function BASS_StreamCreateFile(MEM: BOOL; fil: AnsiString; offset, flags: DWORD): DWORD;
var
  Size: Longint;
  Buffer: ansistring;
begin
  if MEM then begin
    Size:= ExtractTemporaryFileSize(fil);
    SetLength(Buffer,Size);
    ExtractTemporaryFileToBuffer(fil, Cast{#defined UNICODE ? "Ansi" : ""}StringToInteger(Buffer));
    Result:= BASS_StreamCreateFileLib(MEM, Buffer, 0, Size, flags);
  end else Result:= BASS_StreamCreateFileLib(MEM, fil, offset, 0, flags);
end;

Procedure MusicButtonClick(hBtn:HWND);
begin
//sndPlaySound(ExpandConstant('{tmp}\Click.wav'),$0001);
  if BtnGetChecked(MusicButton) then BASS_ChannelPause(mp3Handle) else if BASS_ChannelIsActive(mp3Handle) = 3 then BASS_ChannelPlay(mp3Handle, False);
end;

Procedure InitMusic();
begin
  if not FileExists(ExpandConstant('{tmp}\Bass.dll')) then ExtractTemporaryFile('Bass.dll');
  if not FileExists(ExpandConstant('{tmp}\BP.dll'))   then ExtractTemporaryFile('BP.dll');

  MusicButtonFont:= TFont.Create;
  MusicButtonFont.Name:= {#FontName};
  MusicButtonFont.Size:= 11;

  MusicButton:= BtnCreate(WizardForm.Handle, ScaleX(9), ScaleY(7), ScaleX(25), ScaleY(25), 'MusicButton.png', 1, True);
  //BtnSetEvent(MusicButton, BtnMouseEnterEventID, CallBackAddr('WFBtnEnter'));
  BtnSetCursor(MusicButton, GetSysCursorHandle(32649));
  BtnSetEvent(MusicButton, BtnClickEventID, CallBackAddr('MusicButtonClick'));
  BtnSetVisibility(MusicButton, True);

  BASS_Init(-1, 44100, 0, 0, 0);
  mp3Handle:= BASS_StreamCreateFile(TRUE, 'Music.mp3', 0, 4);
  BASS_Start;
  BASS_ChannelPlay(mp3Handle, False);
end;

Procedure StopMusic();
begin
 BASS_Stop;
 BASS_Free;
end;