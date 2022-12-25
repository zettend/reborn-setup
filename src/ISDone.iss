[Files]
Source: InstallFiles\ISDoneFiles\ISDone\*.*;           DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall

#ifdef Facompress
  Source: InstallFiles\ISDoneFiles\Facompress\*.*;     DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef pZlib
  Source: InstallFiles\ISDoneFiles\pZlib\*.*;          DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef NanoZip
  Source: InstallFiles\ISDoneFiles\NanoZip\*.*;        DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef FAZip
  Source: InstallFiles\ISDoneFiles\FAZip\*.*;          DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef PrecompInside
  Source: InstallFiles\ISDoneFiles\PrecompInside\*.*;  DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef SrepInside
  Source: InstallFiles\ISDoneFiles\SrepInside\*.*;     DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef MSCInside
  Source: InstallFiles\ISDoneFiles\MSCInside\*.*;      DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef Precomp_MT
  Source: InstallFiles\ISDoneFiles\Precomp_MT\*.*;     DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef Reflate_MT
  Source: InstallFiles\ISDoneFiles\Reflate_MT\*.*;     DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef PackZIP
  Source: InstallFiles\ISDoneFiles\7Zip\*.*;           DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef UnRAR
  Source: InstallFiles\ISDoneFiles\Unrar\Unrar.dll;    DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
#endif
#ifdef XDelta
  Source: InstallFiles\ISDoneFiles\XDelta\XDelta3.dll; DestDir: {tmp}; Flags: DontCopy DeleteAfterInstall
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

Function ISDoneInit(RecordFileName: AnsiString; TimeType, Comp1, Comp2, Comp3: Cardinal; WinHandle, NeededMem: LongInt; CallBack:TCallback): Boolean; External 'ISDoneInit@files:ISDone.dll stdcall';
Function ISDoneStop: Boolean; External 'ISDoneStop@files:ISDone.dll stdcall';

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
Function ISGetName(TypeStr: Integer): PAnsichar; External 'ISGetName@files:ISDone.dll stdcall delayload';
Function ISFindFree(FindHandle:Integer): Boolean; External 'ISFindFree@files:ISDone.dll stdcall delayload';

Function ChangeLanguage(Language: AnsiString): Boolean; External 'ChangeLanguage@files:ISDone.dll stdcall delayload';
Function SrepInit(TmpPath: PAnsiChar; VirtMem, MaxSave: Cardinal): Boolean; External 'SrepInit@files:ISDone.dll stdcall delayload';
Function PrecompInit(TmpPath: PAnsiChar; VirtMem: Cardinal; PrecompVers: Single): Boolean; External 'PrecompInit@files:ISDone.dll stdcall delayload';

Function SuspendProc: Boolean; External 'SuspendProc@files:ISDone.dll stdcall';
Function ResumeProc: Boolean; External 'ResumeProc@files:ISDone.dll stdcall';

Function CheckError: Boolean; begin Result:= not ISDoneError; end;

//============================================================================================================================================================\\

Procedure CancelButtonOnClick(Sender: TObject);
begin
  SuspendProc;
  if MsgBox(SetupMessage(msgExitSetupMessage), mbConfirmation, MB_YESNO) = IDYES then ISDoneCancel:= 1;
  ResumeProc;
end;

Function ProgressCallback(OveralPct, CurrentPct: Integer; CurrentFile, TimeStr1, TimeStr2, TimeStr3: PAnsiChar): LongWord;
begin
  if OveralPct<=1000 then ImgPBSetPosition(ISDoneProgressBar, OveralPct);

  ExtractedFileLB.Caption:= CustomMessage('ExtractedFile') + ' ' + MinimizePathName(CurrentFile, ExtractedFileLB.Font, ExtractedFileLB.Width-150);
  PassedTimeLB.Caption:= CustomMessage('PassedTime') + ' ' + TimeStr2;
  LeftTimeLB.Caption:= CustomMessage('LeftTime') + ' ' + TimeStr1;
  ProgressLB.Caption:= CustomMessage('Progress') + ' ' + IntToStr(OveralPct div 10) + '.' + chr(48 + OveralPct mod 10) + ' %';

  SetTaskBarProgressValue(OveralPct div 10);
  ImgApplyChanges(WizardForm.Handle);
  Result:= ISDoneCancel;
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
  ISDoneHide;
  BtnSetEnabled(Min, False);
  BtnSetEnabled(CloseBtn, False);
  LabelOne.Caption:= ExpandConstant('{cm:StatusRollback}');
  Exec2(ExpandConstant('{uninstallexe}'), '/SILENT', False);
  ImgApplyChanges(WizardForm.Handle);
end;
//============================================== [Ошибка Установки - Конец] ==============================================\\

//============================================== [Выполнение изменений после установки - Начало] ==============================================\\
Procedure PostInstallProcess();
begin
  //Изменение размера игры для "Программы и Компоненты"
  if ISWin64 then
    RegWriteDWordValue(HKLM,'Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{#GameID}_is1', 'EstimatedSize', {#NeedSize}*1024*1024)
  else
    RegWriteDWordValue(HKLM,'Software\Microsoft\Windows\CurrentVersion\Uninstall\{#GameID}_is1', 'EstimatedSize', {#NeedSize}*1024*1024);
  //Изменение размера игры для "Программы и Компоненты"

  //Установка Доп.ПО
  if Soft then begin
    LabelOne.Caption:= CustomMessage('SoftInstall');
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
      ISDoneProgressBar:= ImgPBCreate(WizardForm.Handle, 'ProgressImg.png', 'ProgressBackground.png', ScaleX(0), ScaleY(512), ScaleX(1000), ScaleY(10));
      WizardForm.ProgressGauge.Hide;
      WizardForm.CancelButton.OnClick:= @CancelButtonOnClick;
      ISDoneCancel:= 0;
      
    //Извлечение файлов
      ExtractTemporaryFile('UnArc.dll');
      ExtractTemporaryFile('Russian.ini');
      ExtractTemporaryFile('arc.ini');

      #ifdef Records
        ExtractTemporaryFile('Records.inf');
      #endif
      #ifdef Facompress
        ExtractTemporaryFile('Facompress.dll');
        ExtractTemporaryFile('Facompress_MT.dll');
      #endif
      #ifdef pZlib
        ExtractTemporaryFile('pZlib.exe');
      #endif
      #ifdef FAZip
        ExtractTemporaryFile('FAZip.exe');
      #endif
      #ifdef NanoZip
        ExtractTemporaryFile('CLS-NanoZip.dll');
        ExtractTemporaryFile('NanoZip.exe');
      #endif
      #ifdef PrecompInside
        ExtractTemporaryFile('CLS-Precomp.dll');
        ExtractTemporaryFile('Precomp.exe');
      #endif
      #ifdef SrepInside
        ExtractTemporaryFile('CLS-Srep.dll');
      #endif
      #ifdef MSCInside
        ExtractTemporaryFile('CLS-MSC.dll');
      #endif
      #ifdef Precomp_MT
        ExtractTemporaryFile('Precomp_MT.exe');
        ExtractTemporaryFile('Precomp046.exe');
      #endif
      #ifdef Reflate_MT
        ExtractTemporaryFile('Reflate_MT.exe');
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

      Comps1:= 0; Comps2:= 0; Comps3:= 0;
      TmpValue:=1;
      if Soft then Comps1:=Comps1+TmpValue;     //Компонент 1

      ISDoneError:= True;
      if ISDoneInit(ExpandConstant('{src}\records.inf'), $F777, Comps1,Comps2,Comps3, MainForm.Handle, 0, @ProgressCallback) then begin
        repeat
          #ifdef SrepInside
            if not SrepInit(ExpandConstant('{app}\'), 512, 0) then Break;
          #endif
          #ifdef PrecompInside
            if not PrecompInit(ExpandConstant('{app}\'), 256, 0) then Break;
          #endif
          if not FileSearchInit(True) then Break;

    //************************************************ [Архивы ISDone] ***************************************************//

          if not ISArcExtract ( 0, 0, ExpandConstant('{src}\Data-1.bin'),  ExpandConstant('{app}'), '', False, '{#Password}', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), notPCFonFLY {PCFonFLY} ) then Break;

          if not ISArcExtract ( 1, 0, ExpandConstant('{src}\Soft-1.bin'),  ExpandConstant('{app}'), '', False, '{#Password}', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), notPCFonFLY {PCFonFLY} ) then Break;

    //************************************************ [Архивы ISDone] ***************************************************//

          ISDoneError:= False;
        until True;
        ISDoneStop;
      end;
    end;
  end;
end;



//*******************************************************************************************************************************************************************************************************************


(*
//Распаковка Reflate
  if not ISArcExtract ( 0, 0, ExpandConstant('{src}\Data-1.bin'), ExpandConstant('{app}'), '', False, '{#Password}', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), notPCFonFLY {PCFonFLY} ) then Break;
  if not FileCopy(ExpandConstant('{tmp}\Reflate_MT.exe'), ExpandConstant('{app}\Temp\Reflate_MT.exe'), True) then Break;
  if not ISExec (0, 0, 0, ExpandConstant('{app}\Temp\Reflate_MT.exe'),  ExpandConstant(''), ExpandConstant('{app}\Temp'), 'Temp\Completed_1.bin', False {Показать окно cmd: True} ) then Break;
  Sleep(1000);
  DelTree(ExpandConstant('{app}\Temp'), True, True, True);
  if not ISArcExtract ( 0, 0, ExpandConstant('{app}\Completed.bin'), ExpandConstant('{app}'), '', True, '', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then Break;
//Распаковка Reflate

//Распаковка с использованием FAZip
   if not ISArcExtract ( 0, 0, ExpandConstant('{src}\New.bin'), ExpandConstant('{app}'), '', False, '{#Password}', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), notPCFonFLY {PCFonFLY} ) then Break;
//Распаковка с использованием FAZip

//Распаковка отдельной папки из архива
   if not ISArcExtract ( 0, 0, ExpandConstant('{src}\Data-1.bin'), ExpandConstant('{app}'), 'ПАПКА', False, '', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY}) then Break;
//Распаковка отдельной папки из архива

//Многопоточная распаковка Precomp'ом
   if not ISExec (0, 0, 0, ExpandConstant('{tmp}\Timick.cmd'), ExpandConstant(''), ExpandConstant('{tmp}'), 'Data-1.bin.pcf', False {Показать окно cmd: True} ) then Break;
 //Или
   if not ISExec (0, 0, 0, ExpandConstant('{tmp}\UPR.exe'), ExpandConstant('%NUMBER_OF_PROCESSORS% "{app}" 1 "{tmp}\Precomp043.exe"'), ExpandConstant('{tmp}'), 'Data-1.bin.pcf', False {Показать окно cmd: True} ) then Break;
 //Или
   if not ISExec (0, 0, 0, ExpandConstant('{tmp}\Precomp_MT.dll'), ExpandConstant('"{app}" 0.43 200'), ExpandConstant('{tmp}'), 'Data-1.bin.pcf', False {Показать окно cmd: True} ) then Break;
//Многопоточная распаковка Precomp'ом

//Удаление файла\папки
  DelTree(ExpandConstant('{app}\archives_win64\data2 '), True, True, True);
  DeleteFile(ExpandConstant('{app}\data_01.bin'));
//Удаление файла\папки

//Запрос второго диска
  if not ISArcExtract ( 0, 0, ExpandConstant('{src}\Data-1.bin'), ExpandConstant('{app}'), '', False, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY} ) then Break;
  if not ShowChangeDiskWindow ('Пожалуйста, вставьте второй диск и дождитесь его инициализации.', ExpandConstant('{src}'),'Data-2.bin'                                   ) then Break;
  if not ISArcExtract ( 0, 0, ExpandConstant('{src}\Data-2.bin'), ExpandConstant('{app}'), '', False, '{#Password}', '', ExpandConstant('{app}'), notPCFonFLY {PCFonFLY} ) then Break;
//Запрос второго диска

//Распаковка звуковых файлов [OGG]
   FindHandle1:=ISFindFiles(0,ExpandConstant('{app}\*.ogg'),ColFiles1);
   ExecError:=False;
    while not ExecError and ISPickFilename(FindHandle1,ExpandConstant('{app}\'),CurIndex1,True) do begin
      InFilePath:=ISGetName(0);
      OutFilePath:=ISGetName(1)+'.wav';
      OutFileName:=ISGetName(2)+'.wav';
      ExecError:=not ISExec(0, 0, 0, ExpandConstant('{tmp}\oggdec.exe'), '"'+InFilePath+'" -w "'+OutFilePath+'"', ExpandConstant('{tmp}'), OutFileName, False);
    end;
   ISFindFree(FindHandle1);
   if ExecError then Break;
//Распаковка звуковых файлов [OGG]

//Различные примеры
  if not IS7ZipExtract ( 0, 0, ExpandConstant('{src}\CODMW2.7z'), ExpandConstant('{app}\data1'), False, ''                                                ) then Break;
  if not ISPackZIP     ( 0, 0, ExpandConstant('{app}\1a1\*'), ExpandConstant('{app}\1a1.pak'), 2, False                                                   ) then Break;
  if not ISRarExtract  ( 0, 0, ExpandConstant('{src}\data_*.rar'), ExpandConstant('{app}'), False, ''                                                     ) then Break;
  if not ISExec        ( 0, 0, 0, ExpandConstant('{tmp}\Arc.exe'), ExpandConstant('x -o+ "{src}\001.arc" "{app}"'), ExpandConstant('{tmp}'), '...', False ) then Break;
//Различные примеры
*)