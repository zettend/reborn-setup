[Files]
Source: Include\English.ini; DestDir: {tmp}; Flags: dontcopy
Source: Include\Russian.ini; DestDir: {tmp}; Flags: dontcopy
Source: Include\unarc.dll; DestDir: {tmp}; Flags: dontcopy
Source: Include\ISDone.dll; DestDir: {tmp}; Flags: dontcopy

#ifdef records
Source: records.inf; DestDir: {tmp}; Flags: dontcopy
#endif

#ifdef PrecompInside
Source: Include\CLS-precomp.dll; DestDir: {tmp}; Flags: dontcopy
Source: Include\packjpg_dll.dll; DestDir: {tmp}; Flags: dontcopy
Source: Include\packjpg_dll1.dll; DestDir: {tmp}; Flags: dontcopy
Source: Include\precomp.exe; DestDir: {tmp}; Flags: dontcopy
Source: Include\zlib1.dll; DestDir: {tmp}; Flags: dontcopy
#endif
#ifdef SrepInside
Source: Include\CLS-srep.dll; DestDir: {tmp}; Flags: dontcopy
#endif
#ifdef MSCInside
Source: Include\CLS-MSC.dll; DestDir: {tmp}; Flags: dontcopy
#endif
#ifdef facompress
Source: Include\facompress.dll; DestDir: {tmp}; Flags: dontcopy
#endif
#ifdef precomp
  #if precomp == "0.38"
  Source: Include\precomp038.exe; DestDir: {tmp}; Flags: dontcopy
  #else
    #if precomp == "0.4"
    Source: Include\precomp040.exe; DestDir: {tmp}; Flags: dontcopy
    #else
      #if precomp == "0.41"
      Source: Include\precomp041.exe; DestDir: {tmp}; Flags: dontcopy
      #else
        #if precomp == "0.42"
        Source: Include\precomp042.exe; DestDir: {tmp}; Flags: dontcopy
        #else
        Source: Include\precomp038.exe; DestDir: {tmp}; Flags: dontcopy
        Source: Include\precomp040.exe; DestDir: {tmp}; Flags: dontcopy
        Source: Include\precomp041.exe; DestDir: {tmp}; Flags: dontcopy
        Source: Include\precomp042.exe; DestDir: {tmp}; Flags: dontcopy
        #endif
      #endif
    #endif
  #endif
#endif
#ifdef unrar
Source: Include\Unrar.dll; DestDir: {tmp}; Flags: dontcopy
#endif
#ifdef XDelta
Source: Include\XDelta3.dll; DestDir: {tmp}; Flags: dontcopy
#endif
#ifdef PackZIP
Source: Include\7z.dll; DestDir: {tmp}; Flags: dontcopy
Source: Include\packZIP.exe; DestDir: {tmp}; Flags: dontcopy
#endif

[code]
type
  TCallback = function (OveralPct,CurrentPct: integer;CurrentFile,TimeStr1,TimeStr2,TimeStr3:PAnsiChar): longword;

const
  PCFonFLY=true;
  notPCFonFLY=false;

var
  LabelPct1,LabelCurrFileName,LabelTime1,LabelTime2,LabelTime3: TLabel;

  ISDoneProgressBar1: TImgPB;
  
  ISDoneCancel:integer;
  ISDoneError:boolean;
  PCFVer:double;

function WrapCallback(callback:TCallback; paramcount:integer):longword;external 'wrapcallback@files:ISDone.dll stdcall delayload';

function ISArcExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutPath, ExtractedPath: AnsiString; DeleteInFile:boolean; Password, CfgFile, WorkPath: AnsiString; ExtractPCF: boolean ):boolean; external 'ISArcExtract@files:ISDone.dll stdcall delayload';
function IS7ZipExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutPath: AnsiString; DeleteInFile:boolean; Password: AnsiString):boolean; external 'IS7zipExtract@files:ISDone.dll stdcall delayload';
function ISRarExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutPath: AnsiString; DeleteInFile:boolean; Password: AnsiString):boolean; external 'ISRarExtract@files:ISDone.dll stdcall delayload';
function ISPrecompExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutFile: AnsiString; DeleteInFile:boolean):boolean; external 'ISPrecompExtract@files:ISDone.dll stdcall delayload';
function ISSRepExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutFile: AnsiString; DeleteInFile:boolean):boolean; external 'ISSrepExtract@files:ISDone.dll stdcall delayload';
function ISxDeltaExtract(CurComponent:Cardinal; PctOfTotal:double; minRAM,maxRAM:integer; InName, DiffFile, OutFile: AnsiString; DeleteInFile, DeleteDiffFile:boolean):boolean; external 'ISxDeltaExtract@files:ISDone.dll stdcall delayload';
function ISPackZIP(CurComponent:Cardinal; PctOfTotal:double; InName, OutFile: AnsiString;ComprLvl:integer; DeleteInFile:boolean):boolean; external 'ISPackZIP@files:ISDone.dll stdcall delayload';
function ShowChangeDiskWindow(Text, DefaultPath, SearchFile:AnsiString):boolean; external 'ShowChangeDiskWindow@files:ISDone.dll stdcall delayload';

function Exec2 (FileName, Param: PAnsiChar;Show:boolean):boolean; external 'Exec2@files:ISDone.dll stdcall delayload';
function ISFindFiles(CurComponent:Cardinal; FileMask:AnsiString; var ColFiles:integer):integer; external 'ISFindFiles@files:ISDone.dll stdcall delayload';
function ISPickFilename(FindHandle:integer; OutPath:AnsiString; var CurIndex:integer; DeleteInFile:boolean):boolean; external 'ISPickFilename@files:ISDone.dll stdcall delayload';
function ISGetName(TypeStr:integer):PAnsichar; external 'ISGetName@files:ISDone.dll stdcall delayload';
function ISFindFree(FindHandle:integer):boolean; external 'ISFindFree@files:ISDone.dll stdcall delayload';
function ISExec(CurComponent:Cardinal; PctOfTotal,SpecifiedProcessTime:double; ExeName,Parameters,TargetDir,OutputStr:AnsiString;Show:boolean):boolean; external 'ISExec@files:ISDone.dll stdcall delayload';

function SrepInit(TmpPath:PAnsiChar;VirtMem,MaxSave:Cardinal):boolean; external 'SrepInit@files:ISDone.dll stdcall delayload';
function PrecompInit(TmpPath:PAnsiChar;VirtMem:cardinal;PrecompVers:single):boolean; external 'PrecompInit@files:ISDone.dll stdcall delayload';
function FileSearchInit(RecursiveSubDir:boolean):boolean; external 'FileSearchInit@files:ISDone.dll stdcall delayload';
function ISDoneInit(RecordFileName:AnsiString; TimeType,Comp1,Comp2,Comp3:Cardinal; WinHandle, NeededMem:longint; callback:TCallback):boolean; external 'ISDoneInit@files:ISDone.dll stdcall';
function ISDoneStop:boolean; external 'ISDoneStop@files:ISDone.dll stdcall';
function ChangeLanguage(Language:AnsiString):boolean; external 'ChangeLanguage@files:ISDone.dll stdcall delayload';
function SuspendProc:boolean; external 'SuspendProc@files:ISDone.dll stdcall';
function ResumeProc:boolean; external 'ResumeProc@files:ISDone.dll stdcall';

function ProgressCallback(OveralPct,CurrentPct: integer;CurrentFile,TimeStr1,TimeStr2,TimeStr3:PAnsiChar): longword;
begin
  if OveralPct<=1000 then ImgPBSetPosition(ISDoneProgressBar1,OveralPct);
  LabelPct1.Caption :=' ';
  SetTaskBarProgressValue(OveralPct div 10);
  LabelCurrFileName.Caption:=ExpandConstant('{cm:ExtractedFile} ')+MinimizePathName(CurrentFile, LabelCurrFileName.Font, LabelCurrFileName.Width-ScaleX(100));
  StatusLabel.Caption:=ExpandConstant('{cm:iSDinstall} ')+IntToStr(OveralPct div 10)+'.'+chr(48 + OveralPct mod 10)+'%, '+ExpandConstant('{cm:iSDzdat} ')+TimeStr1;
  Result := ISDoneCancel;
  ImgApplyChanges(WizardForm.Handle);
end;

procedure CancelButtonOnClick(Sender: TObject);
begin
  SetTaskBarProgressState(TBPF_PAUSED);
  SuspendProc;
  if MsgBox(SetupMessage(msgExitSetupMessage), mbConfirmation, MB_YESNO) = IDYES then ISDoneCancel:=1;
  ResumeProc;
  SetTaskBarProgressState(TBPF_NOPROGRESS);
end;

procedure IsDoneAddComponents();
var PBTop:integer;
begin
  PBTop:=ScaleY(50);
  
  ISDoneProgressBar1:=ImgPBCreate(WizardForm.Handle, ExpandConstant('{tmp}\ProgressImg.png'), ExpandConstant('{tmp}\ProgressBackground.png'),0,512,1000,10);

  LabelPct1 := TLabel.Create(WizardForm);
  with LabelPct1 do begin
    Parent       := WizardForm;
    Font.Name    := {#FontName};
    Font.Size    := 10;
    Transparent  := true;
    Font.Color   := $f2f2f2;
    AutoSize     := False;
    Left         := ISDoneProgressBar1.Width+ScaleX(300);
    Top          := ISDoneProgressBar1.Top + ScaleY(8);
    Width        := ScaleX(80);
  end;

  LabelTime1 := TLabel.Create(WizardForm);
  with LabelTime1 do begin
    Parent   := WizardForm.InstallingPage;
    AutoSize := False;
    Width    := ISDoneProgressBar1.Width div 2;
    Left     := ScaleX(0);
    Top      := PBTop + ScaleY(35);
  end;
  LabelTime2 := TLabel.Create(WizardForm);
  with LabelTime2 do begin
    Parent   := WizardForm.InstallingPage;
    AutoSize := False;
    Width    := LabelTime1.Width+ScaleX(40);
    Left     := ISDoneProgressBar1.Width div 2;
    Top      := LabelTime1.Top;
  end;
  LabelTime3 := TLabel.Create(WizardForm);
  with LabelTime3 do begin
    Parent   := WizardForm.FinishedPage;
    AutoSize := False;
    Width    := 300;
    Left     := 180;
    Top      := 200;
  end;
end;

procedure IsDoneHide();
begin
  LabelPct1.Hide;
  LabelCurrFileName.Hide;
  LabelTime1.Hide;
  LabelTime2.Hide;
  LabelTime3.Hide;
  ImgPBVisibility(ISDoneProgressBar1, False);
end;

procedure IsDoneShow();
 begin
   LabelPct1.Show;
   LabelCurrFileName.Show;
   LabelTime1.Show;
   LabelTime2.Show;
   ImgPBVisibility(ISDoneProgressBar1, true);
 end;


procedure IsDoneUnpack(CurStep: TSetupStep);
var
  Comps1,Comps2,Comps3, TmpValue:cardinal;
  FindHandle1,ColFiles1,CurIndex1,tmp:integer;
  ExecError:boolean;
  InFilePath,OutFilePath,OutFileName:PAnsiChar;
begin
  if CurStep = ssInstall then begin  //Если необходимо, можно поменять на ssPostInstall
    WizardForm.ProgressGauge.Hide;
    StatusLabel.Caption:=ExpandConstant('{cm:StatusRollback}');
    WizardForm.CancelButton.OnClick := @CancelButtonOnClick;
    ISDoneCancel:=0;

// Распаковка всех необходимых файлов в папку {tmp}.

ExtractTemporaryFile('unarc.dll');

#ifdef PrecompInside
ExtractTemporaryFile('CLS-precomp.dll');
ExtractTemporaryFile('packjpg_dll.dll');
ExtractTemporaryFile('packjpg_dll1.dll');
ExtractTemporaryFile('precomp.exe');
ExtractTemporaryFile('zlib1.dll');
#endif
#ifdef SrepInside
ExtractTemporaryFile('CLS-srep.dll');
#endif
#ifdef MSCInside
ExtractTemporaryFile('CLS-MSC.dll');
#endif
#ifdef facompress
    ExtractTemporaryFile('facompress.dll'); //ускоряет распаковку .arc архивов.
#endif
#ifdef records
    ExtractTemporaryFile('records.inf');
#endif
#ifdef precomp
  #if precomp == "0.38"
    ExtractTemporaryFile('precomp038.exe');
  #else
    #if precomp == "0.4"
      ExtractTemporaryFile('precomp040.exe');
    #else
      #if precomp == "0.41"
        ExtractTemporaryFile('precomp041.exe');
      #else
        #if precomp == "0.42"
          ExtractTemporaryFile('precomp042.exe');
        #else
          ExtractTemporaryFile('precomp038.exe');
          ExtractTemporaryFile('precomp040.exe');
          ExtractTemporaryFile('precomp041.exe');
          ExtractTemporaryFile('precomp042.exe');
        #endif
      #endif
    #endif
  #endif
#endif
#ifdef unrar
    ExtractTemporaryFile('Unrar.dll');
#endif
#ifdef XDelta
    ExtractTemporaryFile('XDelta3.dll');
#endif
#ifdef PackZIP
    ExtractTemporaryFile('7z.dll');
    ExtractTemporaryFile('PackZIP.exe');
#endif

    ExtractTemporaryFile('English.ini');
    ExtractTemporaryFile('Russian.ini');
                          
// Подготавливаем переменную, содержащую всю информацию о выделенных компонентах для ISDone.dll
// максимум 96 компонентов.
    Comps1:=0; Comps2:=0; Comps3:=0;
#ifdef Components
    TmpValue:=1;
    if BtnGetChecked(LanguagetextButton[1]) then Comps1:=Comps1+TmpValue;     //компонент 1
    TmpValue:=TmpValue*2;
    if BtnGetChecked(LanguagetextButton[2]) then Comps1:=Comps1+TmpValue;     //компонент 2
    TmpValue:=TmpValue*2;
    if BtnGetChecked(LanguagevoiceButton[1]) then Comps1:=Comps1+TmpValue;    //компонент 3
    TmpValue:=TmpValue*2;
    if BtnGetChecked(LanguagevoiceButton[2]) then Comps1:=Comps1+TmpValue;    //компонент 4
#endif

#ifdef precomp
  PCFVer:={#precomp};
#else
  PCFVer:=0;
#endif
    ISDoneError:=true;
    if ISDoneInit(ExpandConstant('{src}\records.inf'), $F777, Comps1,Comps2,Comps3, MainForm.Handle, {#NeedMem}, @ProgressCallback) then begin
      repeat
  case ActiveLanguage of
   'eng': ChangeLanguage('English');
   'rus': ChangeLanguage('Russian');
  end;
        if not SrepInit('',512,0) then break;
        if not PrecompInit('',128,PCFVer) then break;
        if not FileSearchInit(true) then break;

        #ifdef Data1
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data1}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data1}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data2
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data2}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data2}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data3
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data3}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data3}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data4
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data4}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data4}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data5
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data5}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data5}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data6
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data6}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data6}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data7
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data7}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data7}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data8
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data8}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data8}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data9
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data9}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data9}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data10
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data10}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data10}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data11
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data11}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data11}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data12
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data12}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data12}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data13
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data13}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data13}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data14
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data14}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data14}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data15
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data15}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data15}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data16
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data16}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data16}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data17
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data17}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data17}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data18
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data18}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data18}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data19
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data19}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data19}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif
        #ifdef Data20
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте следующий диск и дождитесь его инициализации.', ExpandConstant('{src}'),'{#Data20}') then break;
        if not ISArcExtract ( 0, 0, ExpandConstant('{src}\{#Data20}'), ExpandConstant('{app}'), '', false, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then break;
        #endif

//    далее находятся закомментированые примеры различных функций распаковки (чтобы каждый раз не лазить в справку за примерами)
(*
        if not ISArcExtract    ( 0, 0, ExpandConstant('{src}\arc.arc'), ExpandConstant('{app}\'), '', false, '', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}\'), notPCFonFLY{PCFonFLY}) then break;
        if not IS7ZipExtract   ( 0, 0, ExpandConstant('{src}\CODMW2.7z'), ExpandConstant('{app}\data1'), false, '') then break;
        if not ISRarExtract    ( 0, 0, ExpandConstant('{src}\data_*.rar'), ExpandConstant('{app}'), false, '') then break;
        if not ISSRepExtract   ( 0, 0, ExpandConstant('{app}\data1024_1024.srep'),ExpandConstant('{app}\data1024.arc'), true) then break;
        if not ISPrecompExtract( 0, 0, ExpandConstant('{app}\data.pcf'),    ExpandConstant('{app}\data.7z'), true) then break;
        if not ISxDeltaExtract ( 0, 0, 0, 640, ExpandConstant('{app}\in.pcf'), ExpandConstant('{app}\*.diff'),   ExpandConstant('{app}\out.dat'), false, false) then break;
        if not ISPackZIP       ( 0, 0, ExpandConstant('{app}\1a1\*'), ExpandConstant('{app}\1a1.pak'), 2, false ) then break;
        if not ISExec          ( 0, 0, 0, ExpandConstant('{tmp}\Arc.exe'), ExpandConstant('x -o+ "{src}\001.arc" "{app}\"'), ExpandConstant('{tmp}'), '...',false) then break;
        if not ShowChangeDiskWindow ('Пожалуйста, вставьте второй диск и дождитесь его инициализации.', ExpandConstant('{src}'),'CODMW_2.arc') then break;

//    распаковка группы файлов посредством внешнего приложения

        FindHandle1:=ISFindFiles(0,ExpandConstant('{app}\*.ogg'),ColFiles1);
        ExecError:=false;
        while not ExecError and ISPickFilename(FindHandle1,ExpandConstant('{app}\'),CurIndex1,true) do begin
          InFilePath:=ISGetName(0);
          OutFilePath:=ISGetName(1);
          OutFileName:=ISGetName(2);
          ExecError:=not ISExec(0, 0, 0, ExpandConstant('{tmp}\oggdec.exe'), '"'+InFilePath+'" -w "'+OutFilePath+'"',ExpandConstant('{tmp}'),OutFileName,false);
        end;
        ISFindFree(FindHandle1);
        if ExecError then break;
*)

        ISDoneError:=false;
      until true;
      ISDoneStop;
    end;
  end;
  if (CurStep=ssPostInstall) and ISDoneError then begin
    SetTaskBarProgressState(TBPF_INDETERMINATE);
    IsDoneHide;
    BtnSetEnabled(hCancelBtn, False);
    ImgApplyChanges(WizardForm.Handle);
    StatusLabel.Caption:=ExpandConstant('{cm:StatusRollback}');
    ImgApplyChanges(WizardForm.Handle);
    Exec2(ExpandConstant('{uninstallexe}'), '/VERYSILENT', false);
  end;
end;