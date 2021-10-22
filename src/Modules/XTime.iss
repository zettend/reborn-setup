[Code]
type
//---------- XTime - Split/Merge -----------\\
  TSMCallBack = procedure(CurrentFile: WideString; TotalPct: Integer);
//---------- XTime - XWrap -----------\\
  TTimerProc = procedure(Wnd: HWND; Msg: UINT; TimerID: UINT_PTR; SysTime: DWORD);
//---------- XTime - XGetHash -----------\\
  TGetHashCallBack = procedure(CurrentFile: WideString; TotalPct: Integer);
//---------- XTime - XVerifyHashFromFile -----------\\
  THashCallBack = procedure(CurrentFile: WideString; TotalFiles: Integer; ProcessedFiles: Integer; TotalPct: Integer; CurrentPct: Integer; TotalSize: WideString; CurrentSize: WideString; Status: Integer);
//---------- XTime - EncryptDecrypt -----------\\
  TCryptCallBack = procedure(TotalPct: WideString);

///////// Repack Functions /////////
function GetTime: Integer; external 'GetTime@files:XTime.dll stdcall';
function GetElapsedTime(TimeDiff, TimeDispFormat: integer): WideString; external 'GetElapsedTime@files:XTime.dll stdcall';
function GetRemainsTime(TimeDiff, TimeDispFormat: integer; Max, Position: LongInt): WideString; external 'GetRemainsTime@files:XTime.dll stdcall';
function GetPercentage(Max, Position: LongInt; Decimal: Integer): WideString; external 'GetPercentage@files:XTime.dll stdcall';
function GetInstallingSpeed(GamesizeMB, TimeDiff, Decimal: Integer; Max, Position: LongInt): WideString; external 'GetInstallingSpeed@files:XTime.dll stdcall delayload';
function GetArcFile(FileName: WideString): WideString; external 'GetArcFile@files:XTime.dll stdcall delayload';

///////// Open/Save File and Folders /////////
function XSaveFile(DefFileName,Title: WideString): WideString; external 'XSaveFile@files:XTime.dll stdcall delayload';
function XSaveAnyFile(Title: WideString): WideString; external 'XSaveAnyFile@files:XTime.dll stdcall delayload';
function XOpenFile(DefFileName,Title: WideString): WideString; external 'XOpenFile@files:XTime.dll stdcall delayload';
function XOpenAnyFile(Title: WideString): WideString; external 'XOpenAnyFile@files:XTime.dll stdcall delayload';
function XBrowseFolder(Title: WideString): WideString; external 'XBrowseFolder@files:XTime.dll stdcall delayload';

///////// MbOrTB /////////
function XMbOrTb(Float: Extended; Decimal: Integer): WideString; external 'XMbOrTb@files:XTime.dll stdcall';

///////// Run Exe /////////
function XRun(exeFile, param: WideString; Wait, Show: Boolean): Boolean; external 'XRun@files:XTime.dll stdcall';

///////// Split/Merge Files /////////
function XSplit(InputFile, SplitSize: WideString; splitType: Integer; SplitCallBack: TSMCallBack): Boolean; external 'XSplit@files:XTime.dll stdcall delayload';
procedure XSplitClose; external 'XSplitClose@files:XTime.dll stdcall';

function XMerge(FirstPartName, OutputFolder: WideString; DelSplitParts: Boolean; splitType: Integer; MergeCallBack: TSMCallBack): Boolean; external 'XMerge@files:XTime.dll stdcall delayload';
procedure XMergeClose; external 'XMergeClose@files:XTime.dll stdcall';

///////// CallBack Wrapper /////////
function XWrapper(Callback: TTimerProc; paramcount: integer): longword; external 'XWrap@files:XTime.dll stdcall';

///////// Set/Kill Timers /////////
function XSetTimer(lpTimerFunc: longword): integer; external 'XSetTimer@files:XTime.dll stdcall';
procedure XKillTimer(TimerID: Integer); external 'XKillTimer@files:XTime.dll stdcall';

///////// Task Kill /////////
function XTaskKill(ExeFileName: WideString): Integer; external 'XTaskKill@files:XTime.dll stdcall';

///////// Get Hash Value /////////
function XGetHash(InputFileName: WideString; HashType: WideString; CallBack: TGetHashCallBack): WideString; external 'XGetHash@files:XTime.dll stdcall delayload';
procedure XGetHashClose; external 'XGetHashClose@files:XTime.dll stdcall';

///////// Check Hash From File /////////
Function XVerifyHashFromFile(FileName: WideString; HashType: WideString; HashCallBack :THashCallBack): Boolean; external 'XVerifyHashFromFile@files:XTime.dll stdcall delayload';
procedure XVerifyHashFromFileClose; external 'XVerifyHashFromFileClose@files:XTime.dll stdcall';

///////// Packing Functions //////////
function PackInit(ZipFile: WideString; OutputDir: WideString; Password: WideString): Boolean; external 'PackInit@files:XTime.dll stdcall delayload';
function PackAddFolder(Folder: WideString; AddSubFolders: Boolean; RelativePath: WideString): Boolean;  external 'PackAddFolder@files:XTime.dll stdcall delayload';
function PackAddFile(FileName: WideString): Boolean;  external 'PackAddFile@files:XTime.dll stdcall delayload';
function PackAddFiles(Folder: WideString; FileMask: WideString; AddSubFolders: Boolean; RelativePath: WideString): Boolean; external 'PackAddFiles@files:XTime.dll stdcall delayload';
function PackBuild: Boolean;  external 'PackBuild@files:XTime.dll stdcall delayload';

///////// UnPacking Functions /////////
function UnPackInit(ZipFile: WideString; Password: WideString; CheckCRC: Boolean): Boolean; external 'UnPackInit@files:XTime.dll stdcall delayload';
function UnPackExtractFile(FileName: WideString; Outpath: WideString): Boolean; external 'UnPackExtractFile@files:XTime.dll stdcall delayload';
function UnPackExtractAll(Outpath: WideString): Boolean;  external 'UnPackExtractAll@files:XTime.dll stdcall delayload';
function UnpackFinish: Boolean; external 'UnpackFinish@files:XTime.dll stdcall delayload';

///////// Encrypt/Decrypt Files /////////
function XEncryptFile(InFile: WideString; OutFile: WideString; Password: WideString; CallBack: TCryptCallBack): Boolean; external 'XEncryptFile@files:XTime.dll stdcall delayload';
function XDecryptFile(InFile: WideString; OutFile: WideString; Password: WideString; CallBack: TCryptCallBack): Boolean; external 'XDecryptFile@files:XTime.dll stdcall delayload';

///////// Write/Read Protected INI /////////
procedure XINIsearch(INIFile: WideString); external 'XINIsearch@files:XTime.dll stdcall delayload';
procedure XINIwriteFloat(Section: WideString; Name: WideString; Value: Extended); external 'XINIwriteFloat@files:XTime.dll stdcall delayload';
procedure XINIwriteString(Section: WideString; Name: WideString; Value: WideString); external 'XINIwriteString@files:XTime.dll stdcall delayload';
procedure XINIwriteInteger(Section: WideString; Name: WideString; Value: Integer); external 'XINIwriteInteger@files:XTime.dll stdcall delayload';
procedure XINIwriteBoolean(Section: WideString; Name: WideString; Value: Boolean); external 'XINIwriteBoolean@files:XTime.dll stdcall delayload';

function XINIreadFloat(Section: WideString; Name: WideString): Extended; external 'XINIreadFloat@files:XTime.dll stdcall delayload';
function XINIreadString(Section: WideString; Name: WideString): WideString; external 'XINIreadString@files:XTime.dll stdcall delayload';
function XINIreadInteger(Section: WideString; Name: WideString): Integer; external 'XINIreadInteger@files:XTime.dll stdcall delayload';
function XINIreadBoolean(Section: WideString; Name: WideString): Boolean; external 'XINIreadBoolean@files:XTime.dll stdcall delayload';
procedure XINIclose; external 'XINIclose@files:XTime.dll stdcall delayload';

///////// Splash Image /////////
procedure XSplash(ImgFile: WideString; Duration: Integer); external 'XSplash@files:XTime.dll stdcall delayload';

///////// Play Music /////////
procedure MusicPlay(); external 'MusicPlay@files:XTime.dll stdcall';
procedure MusicStop(); external 'MusicStop@files:XTime.dll stdcall';
procedure MusicPause(); external 'MusicPause@files:XTime.dll stdcall';
procedure MusicSetVolume(volume: Integer); external 'MusicSetVolume@files:XTime.dll stdcall';
function IsMusicPlayOn: Boolean; external 'IsMusicPlayOn@files:XTime.dll stdcall';
procedure MusicPlayInit(filename: String; volume: Integer); external 'MusicPlayInit@files:XTime.dll stdcall';
procedure MusicPlayDeInit(); external 'MusicPlayDeInit@files:XTime.dll stdcall';