[Files]
Source: InstallFiles\ISDoneFiles\ISDone\*.*;   DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall

#ifdef XTool
  Source: InstallFiles\ISDoneFiles\xtool\*.*;  DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef MSC
  Source: InstallFiles\ISDoneFiles\msc\*.*;    DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef Srep
  Source: InstallFiles\ISDoneFiles\srep\*.*;   DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef FaZip
  Source: InstallFiles\ISDoneFiles\FaZip\*.*;  DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif     
#ifdef LolZ
  Source: InstallFiles\ISDoneFiles\lolz\*.*;   DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef PackZIP
  Source: InstallFiles\ISDoneFiles\7ZIP\*.*;   DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef UnRAR
  Source: InstallFiles\ISDoneFiles\UnRAR\*.*;  DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef XDelta
  Source: InstallFiles\ISDoneFiles\XDelta\*.*; DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif

[code]
Type
  TCallback = Function (OveralPct, CurrentPct: Integer; CurrentFile, TimeStr1, TimeStr2, TimeStr3: PAnsiChar): LongWord;

Const
  PCFonFLY = True;
  notPCFonFLY = False;

Var
  ExtractedFileLB, PassedTimeLB, LeftTimeLB, ProgressLB: TLabel;
  Comps1, Comps2, Comps3, TmpValue: Cardinal;
  ISDoneProgressBar: TImgPB;
  ISDoneCancel: Integer;
  ISDoneError: Boolean;
  InpArchive: String;

Function ISDoneInit(RecordFileName: AnsiString; TimeType, Comp1, Comp2, Comp3: Cardinal; WinHandle, NeededMem: LongInt; CallBack: TCallback): Boolean; External 'ISDoneInit@files:ISDone.dll stdcall';
Function ISDoneStop: Boolean; External 'ISDoneStop@files:ISDone.dll stdcall';
Function SuspendProc: Boolean; External 'SuspendProc@files:ISDone.dll stdcall';
Function ResumeProc: Boolean; External 'ResumeProc@files:ISDone.dll stdcall';

Function ISArcExtract(CurComponent: Cardinal; PctOfTotal: Double; InName, OutPath, ExtractedPath: AnsiString; DeleteInFile: Boolean; Password, CfgFile, WorkPath: AnsiString; ExtractPCF: Boolean): Boolean; External 'ISArcExtract@files:ISDone.dll stdcall delayload';
Function IS7ZipExtract(CurComponent: Cardinal; PctOfTotal: Double; InName, OutPath: AnsiString; DeleteInFile: Boolean; Password: AnsiString): Boolean; External 'IS7zipExtract@files:ISDone.dll stdcall delayload';
Function ISRarExtract(CurComponent: Cardinal; PctOfTotal: Double; InName, OutPath: AnsiString; DeleteInFile: Boolean; Password: AnsiString): Boolean; External 'ISRarExtract@files:ISDone.dll stdcall delayload';
Function ISPrecompExtract(CurComponent: Cardinal; PctOfTotal: Double; InName, OutFile: AnsiString; DeleteInFile: Boolean): Boolean; External 'ISPrecompExtract@files:ISDone.dll stdcall delayload';
Function ISSRepExtract(CurComponent: Cardinal; PctOfTotal: Double; InName, OutFile: AnsiString; DeleteInFile: Boolean): Boolean; External 'ISSrepExtract@files:ISDone.dll stdcall delayload';
Function ISxDeltaExtract(CurComponent: Cardinal; PctOfTotal: Double; minRAM, maxRAM: Integer; InName, DiffFile, OutFile: AnsiString; DeleteInFile, DeleteDiffFile: Boolean): Boolean; External 'ISxDeltaExtract@files:ISDone.dll stdcall delayload';
Function ISPackZIP(CurComponent: Cardinal; PctOfTotal: Double; InName, OutFile: AnsiString; ComprLvl: Integer; DeleteInFile: Boolean): Boolean; External 'ISPackZIP@files:ISDone.dll stdcall delayload';
Function Exec2(FileName, Param: PAnsiChar; Show: Boolean): Boolean; External 'Exec2@files:ISDone.dll stdcall delayload';
Function ISExec(CurComponent: Cardinal; PctOfTotal, SpecifiedProcessTime: Double; ExeName, Parameters, TargetDir, OutputStr: AnsiString; Show: Boolean): Boolean; External 'ISExec@files:ISDone.dll stdcall delayload';

Function ShowChangeDiskWindow(Text, DefaultPath, SearchFile: AnsiString): Boolean; External 'ShowChangeDiskWindow@files:ISDone.dll stdcall delayload';

Function FileSearchInit(RecursiveSubDir: Boolean): Boolean; External 'FileSearchInit@files:ISDone.dll stdcall delayload';
Function ISFindFiles(CurComponent: Cardinal; FileMask:AnsiString; var ColFiles: Integer): Integer; External 'ISFindFiles@files:ISDone.dll stdcall delayload';
Function ISPickFilename(FindHandle: Integer; OutPath:AnsiString; var CurIndex: Integer; DeleteInFile:Boolean):Boolean; External 'ISPickFilename@files:ISDone.dll stdcall delayload';
Function ISGetName(TypeStr: Integer): PAnsiChar; External 'ISGetName@files:ISDone.dll stdcall delayload';
Function ISFindFree(FindHandle:Integer): Boolean; External 'ISFindFree@files:ISDone.dll stdcall delayload';

Function ChangeLanguage(Language: AnsiString): Boolean; External 'ChangeLanguage@files:ISDone.dll stdcall delayload';
Function SrepInit(TmpPath: PAnsiChar; VirtMem, MaxSave: Cardinal): Boolean; External 'SrepInit@files:ISDone.dll stdcall delayload';
Function PrecompInit(TmpPath: PAnsiChar; VirtMem: Cardinal; PrecompVers: Single): Boolean; External 'PrecompInit@files:ISDone.dll stdcall delayload';

Function CheckError: Boolean;
begin
  Result:= not ISDoneError;
end;

//============================================================================================================================================================\\

Procedure CancelButtonOnClick(Sender: TObject);
begin
  SuspendProc();
  if MsgBox(SetupMessage(msgExitSetupMessage), mbConfirmation, MB_YESNO) = IDYES then ISDoneCancel := 1;
  ResumeProc();
end;

Function ProgressCallback(OveralPct, CurrentPct: Integer; CurrentFile, TimeStr1, TimeStr2, TimeStr3: PAnsiChar): LongWord;
var
  TotalProgress, CurrentProgress: String;
begin
  if OveralPct <= 1000 then ImgPBSetPosition(ISDoneProgressBar, OveralPct);

  TotalProgress := IntToStr(OveralPct DIV 10) + '.' + CHR(48 + OveralPct MOD 10);
  CurrentProgress := IntToStr(CurrentPct DIV 10) + '.' + CHR(48 + CurrentPct MOD 10);

  ExtractedFileLB.Caption := CustomMessage('ExtractedFile') + ' ' + MinimizePathName(CurrentFile, ExtractedFileLB.Font, ExtractedFileLB.Width-150);
  PassedTimeLB.Caption := CustomMessage('PassedTime') + ' ' + TimeStr2;
  LeftTimeLB.Caption := CustomMessage('LeftTime') + ' ' + TimeStr1;

  TLabelText(ProgressLB, FmtMessage(ExpandConstant('{cm:Progress}'), [TotalProgress, ExtractFileName(InpArchive), CurrentProgress]));

  Time3Label := TimeStr3;

  SetTaskBarTitleWinTB('{#GameName} - ' + IntToStr(OveralPct DIV 10) + ' %');
  SetTaskBarProgressValue(OveralPct DIV 10);

  ImgApplyChanges(WizardForm.Handle);
  Result := ISDoneCancel;
end;

Procedure ISDoneHide();
begin
  ExtractedFileLB.Hide;
  PassedTimeLB.Hide;
  LeftTimeLB.Hide;
  ProgressLB.Hide;
  ImgPBVisibility(ISDoneProgressBar, False);
end;

Procedure ISDoneShow();
begin
  ExtractedFileLB.Show;
  PassedTimeLB.Show;
  LeftTimeLB.Show;
  ProgressLB.Show;
  ImgPBVisibility(ISDoneProgressBar, True);
end;

//============================================== [Ошибка Установки - Начало] ==============================================\\
Procedure ErrorInstall();
begin
  ISDoneHide();
  BtnSetEnabled(hMinBtn, False);
  BtnSetEnabled(hCancelBtn, False);
  LabelOne.Caption:= ExpandConstant('{cm:StatusRollback}');

  ExecAndWait(ExpandConstant('{uninstallexe}'), '/SILENT', '', SW_SHOW, True);

  ImgApplyChanges(WizardForm.Handle);
end;
//============================================== [Ошибка Установки - Конец] ==============================================\\

//============================================== [Выполнение изменений после установки - Начало] ==============================================\\
Procedure PostInstallProcess();
begin
  //Изменение размера игры для "Программы и Компоненты"
  if ISWin64 then
    RegWriteDWordValue(HKLM,'Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{#GameID}_is1', 'EstimatedSize', {#NeedSize} * 1024 * 1024)
  else
    RegWriteDWordValue(HKLM,'Software\Microsoft\Windows\CurrentVersion\Uninstall\{#GameID}_is1', 'EstimatedSize', {#NeedSize} * 1024* 1024);
  //Изменение размера игры для "Программы и Компоненты"

  //Установка Доп.ПО
  if Soft then begin
    LabelOne.Caption := CustomMessage('SoftInstall');
    ExecAndWait(ExpandConstant('{app}\Soft\dxwebsetup.exe'),   '/Q', '', SW_SHOW, True);
    ExecAndWait(ExpandConstant('{app}\Soft\vcredist_x86.exe'), '/Q', '', SW_SHOW, True);
    ExecAndWait(ExpandConstant('{app}\Soft\vcredist_x86.exe'), '/Q', '', SW_SHOW, True);
  end;
  //Установка Доп.ПО
end;
//============================================== [Выполнение изменений после установки - Конец] ==============================================\\

Procedure ISDoneUnPack(CurStep: TSetupStep);
begin
  Case CurStep of
    ssPostInstall: if ISDoneError then ErrorInstall else PostInstallProcess;
    ssInstall: begin
      ISDoneProgressBar := ImgPBCreate(WizardForm.Handle, 'ProgressImg.png', 'ProgressBackground.png', ScaleX(0), ScaleY(512), ScaleX(1000), ScaleY(10));
      WizardForm.ProgressGauge.Hide;
      WizardForm.CancelButton.OnClick := @CancelButtonOnClick;
      ISDoneCancel := 0;
      
    //Извлечение файлов
      
      ExtractTemporaryFile('unarc.dll');
      ExtractTemporaryFile('russian.ini');
      ExtractTemporaryFile('arc.ini');
      ExtractTemporaryFile('CLS.ini');
      ExtractTemporaryFile('facompress.dll');
      ExtractTemporaryFile('facompress_mt.dll');

      #ifdef Records
        ExtractTemporaryFile('records.inf');
      #endif

      #ifdef XTool
        ExtractTemporaryFile('xtool.exe');
        ExtractTemporaryFile('zlibwapi.dll');
      #endif
      #ifdef MSC
        ExtractTemporaryFile('cls-msc.dll');
      #endif
      #ifdef Srep
        SetIniString('Srep', 'TempPath', ExpandConstant('{app}'), ExpandConstant('{tmp}\CLS.ini'));
        ExtractTemporaryFile('cls-srep.dll');
        ExtractTemporaryFile('cls-srep_x64.exe');
        ExtractTemporaryFile('cls-srep_x86.exe');
      #endif
      #ifdef FaZip
        ExtractTemporaryFile('FaZip.exe');
      #endif
      #ifdef LolZ
        SetIniString('lolz', 'TempPath', ExpandConstant('{app}'), ExpandConstant('{tmp}\CLS.ini'));
        ExtractTemporaryFile('cls-lolz.dll');
        ExtractTemporaryFile('cls-lolz_x64.exe');
        ExtractTemporaryFile('cls-lolz_x86.exe');
      #endif

      #ifdef UnRAR
        ExtractTemporaryFile('UnRAR.dll');
      #endif
      #ifdef PackZIP
        ExtractTemporaryFile('7Z.dll');
        ExtractTemporaryFile('PackZIP.exe');
      #endif
      #ifdef XDelta
        ExtractTemporaryFile('XDelta3.dll');
      #endif
    //Извлечение файлов

      Comps1 := 0; Comps2 := 0; Comps3 := 0;
      TmpValue := 1;
      if Soft then Comps1 := Comps1 + TmpValue;     //Компонент 1

      ISDoneError := True;
      if ISDoneInit(ExpandConstant('{src}\records.inf'), $F777, Comps1, Comps2, Comps3, MainForm.Handle, 0, @ProgressCallback) then begin
        Repeat
          if not FileSearchInit(True) then Break;

    //************************************************ [Архивы ISDone] ***************************************************//

          if not ISArcExtract(0, 0, ExpandConstant('{src}\Data-1.bin'),  ExpandConstant('{app}'), '', False, '{#Password}', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), False) then Break;
          if not ISArcExtract(1, 0, ExpandConstant('{src}\Soft-1.bin'),  ExpandConstant('{app}'), '', False, '{#Password}', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), False) then Break;

    //************************************************ [Архивы ISDone] ***************************************************//

          ISDoneError := False;
        Until True;
        ISDoneStop();
      end;
    end;
  end;
end;

//*******************************************************************************************************************************************************************************************************************

(*

//Распаковка отдельной папки из архива
   if not ISArcExtract ( 0, 0, ExpandConstant('{src}\Data-1.bin'), ExpandConstant('{app}'), 'ПАПКА', False, '', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then Break;
//Распаковка отдельной папки из архива

//Удаление файла\папки
  DelTree(ExpandConstant('{app}\archives_win64\data2 '), True, True, True);
  DeleteFile(ExpandConstant('{app}\data_01.bin'));
//Удаление файла\папки

//Запрос второго диска
  if not ISArcExtract ( 0, 0, ExpandConstant('{src}\Data-1.bin'), ExpandConstant('{app}'), '', False, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY} ) then Break;
  if not ShowChangeDiskWindow ('Пожалуйста, вставьте второй диск и дождитесь его инициализации.', ExpandConstant('{src}'),'Data-2.bin'                                   ) then Break;
  if not ISArcExtract ( 0, 0, ExpandConstant('{src}\Data-2.bin'), ExpandConstant('{app}'), '', False, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY} ) then Break;
//Запрос второго диска

*)