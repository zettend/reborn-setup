#ifndef IS_ENHANCED
  #error Enhanced edition of Inno Setup (ResTools) is required to compile this script
#endif

//====== [Игровые параметры] ======\\
#define GameID "{598C9B28-DD19-4006-8A41-AB939D1DF257}_TimickRepack" ;GUID игры.

#define GameName "Far Cry 5: Gold Edition" ;Название игры
#define GameVerName  "Far Cry 5: Gold Edition [V.1.4.0.0 + DLCs]" ;Название игры + Версия
#define GameNameFolder "Far Cry 5 Gold Edition" ;Название игры (Без \ / ? : * "" > < |)
#define GameVer "1.4.0.0" ;Версия игры

#define exeGameFile "FarCry5.exe" ;Файл запуска (x86) (Пример: pCARS.exe)
#define exeGameFolder "{app}\bin" ;Папка где лежит файл запуска (Пример: {app}\bin32)

;#define exeGameFile64 "pCARS64.exe" ;Файл запуска (x64) (Пример: pCARS64.exe)
;#define exeGameFolder64 "{app}" ;Папка где лежит файл запуска (Пример: {app}\bin64)

#define SetupName "Setup" ;Название файла установки

#define Publisher "Ubisoft" ;Издетель
#define Company   "Timick (N.06.17)" ;Репакер

#define NeedSize "25" ;Игра займёт на диске (МБ) | (11ГБ = 11264МБ)
#define TMPNeedSize "25" ;Требуется для распаковки (МБ) | (11ГБ = 11264МБ)
//====== [Игровые параметры] ======\\

//====== [Модули] ======\\
;#define Music /* Музыка */
#define MD5 /* Проверка MD5 */
;#define Splash /* Splash Заставка */
//====== [Модули] ======\\

//====== [Оформление] ======\\
;Цвет значков "Свернуть, Закрыть, Инфо":
#define Mode "Black" ;"Black" или "White"

;Настройки шрифта:
#define CustomFont "InstallFiles\Fonts\Roboto Light.ttf" ;Кастомный шрифт (Ненужен - Закомментировать)
#define FontName "'Roboto Light'" ;Название используемого шрифта
#define FontColor "$f1f0ec" ;Основной Цвет текста
#define ErrFontColor "$3c4ce7" ;Цвет текста при ошибке
#define GoodFontColor "$228b22" ;Цвет текста при ошибке
//====== [Оформление] ======\\

//====== [Работа с ISDone] ======\\
#define Components /* Компоненты */
#define TaskCheckBox /* Установка ПО */

;#define Records

// Проверял только эти методы
#define XTool
;#define MSC
#define Srep
#define FaZip
// Проверял только эти методы

;#define LolZ
;#define UnRar
;#define XDelta
;#define PackZIP

#define Password "1g2x3h7421" /* Пароль на архивы */
//====== [Работа с ISDone] ======\\

//====== [Другое] ======\\
#define RusError /* Поиск в пути русских букв */
//====== [Другое] ======\\

//====== [Сохранения] ======\\
;#define DeleteSaved
  ;#define Save1 "ExpandConstant('{userdocs}') + '\My Games\Life Is Strange\'"
  ;#define Save2 "ExpandConstant('{sd}') + '\ProgramData\Steam\228048\Fallout4'"
  ;#define Save3 "ExpandConstant('{localappdata}') + '\SKIDROW\207610'"
//====== [Сохранения] ======\\

[Setup]
AppID={{#GameID}
AppName={#GameName}
AppVerName={#GameVerName}
AppCopyright=© {#Company}
AppPublisher={#Publisher}
DefaultDirName={code:NoSD}\Games\PirateLibrary\{#GameNameFolder}
DefaultGroupName=TimickRePack\{#GameNameFolder}
VersionInfoDescription=Setup For {#GameName}
VersionInfoCompany={#Company}
VersionInfoProductVersion={#GameVer}
OutputBaseFilename={#SetupName}
#ifdef CustomFont
  RawDataResource=Font:{#CustomFont}
#endif
;------------------------------------------
VersionInfoVersion = 4.5.0
DisableReadyPage = Yes
DirExistsWarning = No
;Иконка инсталлятора
SetupIconFile = Icons\Icon_1.ico
;Куда поместить деинсталлятор
UninstallFilesDir = {app}\Uninstall
;Степень сжатия (lzma2 - Максимум)
Compression = lzma2/Max
;Разбивать файлы инсталлятора
DiskSpanning = False
;Привилегии инсталлятора (none, poweruser, admin)
PrivilegesRequired = Admin

[Files]
//************************* [Инсталлятор] *************************\\
Source: InstallFiles\ImageFiles\*.*;  Flags: DontCopy
Source: InstallFiles\DllFiles\*.*;    Flags: DontCopy
Source: InstallFiles\SoundFiles\*.*;  Flags: DontCopy

#ifdef CustomFont
  Source: {#CustomFont};              Flags: DontCopy
#endif
#if Mode == "Black"
  Source: InstallFiles\ImageFiles\B&W_Mode\Close_Black.png;    Flags: DontCopy
  Source: InstallFiles\ImageFiles\B&W_Mode\Min_Black.png;      Flags: DontCopy
#else if Mode == "White"
  Source: InstallFiles\ImageFiles\B&W_Mode\Close_White.png;    Flags: DontCopy
  Source: InstallFiles\ImageFiles\B&W_Mode\Min_White.png;      Flags: DontCopy
#endif
//************************* [Инсталлятор] *************************\\

//************************* [Деинсталлятор] *************************\\
Source: Icons\*.*; DestDir: {app}\Uninstall; Flags: IgnoreVersion; Attribs: Hidden System
//************************* [Деинсталлятор] *************************\\

[Icons]
//--------------------------------------------------------------------- [Рабочий стол] ---------------------------------------------------------------------\\:
#ifndef exeGameFile64
  Name: {userdesktop}\{#GameNameFolder}; Filename: {#exeGameFolder}\{#exeGameFile}; WorkingDir: {#exeGameFolder}; IconFilename: {app}\Uninstall\Icon_1.ico; Check: IconDP and CheckError
#endif
#ifdef exeGameFile64
  Name: {userdesktop}\{#GameNameFolder}; Filename: {#exeGameFolder}\{#exeGameFile}; WorkingDir: {#exeGameFolder}; IconFilename: {app}\Uninstall\Icon_1.ico; Check: not ISWin64 and IconDP and CheckError
  Name: {userdesktop}\{#GameNameFolder}; Filename: {#exeGameFolder64}\{#exeGameFile64}; WorkingDir: {#exeGameFolder64}; IconFilename: {app}\Uninstall\Icon_1.ico; Check: ISWin64 and IconDP and CheckError
#endif
//--------------------------------------------------------------------- [Рабочий стол] ---------------------------------------------------------------------\\:

//--------------------------------------------------------------------- [Меню "Пуск"] ---------------------------------------------------------------------\\:
#ifndef exeGameFile64
  Name: {group}\{#GameNameFolder}; Filename: {#exeGameFolder}\{#exeGameFile}; WorkingDir: {#exeGameFolder}; IconFilename: {app}\Uninstall\Icon_1.ico; Check: IconGroup and CheckError
#endif
#ifdef exeGameFile64
  Name: {group}\{#GameNameFolder}; Filename: {#exeGameFolder}\{#exeGameFile}; WorkingDir: {#exeGameFolder}; IconFilename: {app}\Uninstall\Icon_1.ico; Check: not ISWin64 and IconGroup and CheckError
  Name: {group}\{#GameNameFolder}; Filename: {#exeGameFolder64}\{#exeGameFile64}; WorkingDir: {#exeGameFolder64}; IconFilename: {app}\Uninstall\Icon_1.ico; Check: ISWin64 and IconGroup and CheckError
#endif
Name: {group}\{cm:UninstallProgram,awd}; Filename: {uninstallexe}; IconFilename: {app}\Uninstall\1.ico; Check: IconGroup and CheckError
//--------------------------------------------------------------------- [Меню "Пуск"] ---------------------------------------------------------------------\\:

[UninstallDelete]
Type: FilesAndOrDirs; Name: {app}

[Registry]
Root: HKLM; SubKey: "SOFTWARE\TimickRepack";                                                                                          Flags: UninsDeleteKeyIfEmpty CreateValueIfDoesntExist
Root: HKLM; SubKey: "SOFTWARE\TimickRepack\{#GameNameFolder}"; ValueName: "Install Dir";  ValueType: String; ValueData: "{app}";      Flags: UninsDeleteValue UninsDeleteKeyIfEmpty CreateValueIfDoesntExist
Root: HKLM; SubKey: "SOFTWARE\TimickRePack\{#GameNameFolder}"; ValueName: "Product GUID"; ValueType: String; ValueData: "{{#GameID}"; Flags: UninsDeleteValue UninsDeleteKeyIfEmpty CreateValueIfDoesntExist

Root: HKLM; SubKey: "SOFTWARE\TimickRepack\{#GameNameFolder}"; ValueName: "GameEXE";      ValueType: String; ValueData: "{#exeGameFolder}\{#exeGameFile}"; Flags: UninsDeleteValue UninsDeleteKeyIfEmpty CreateValueIfDoesntExist; Check: not ISWin64
Root: HKCU; SubKey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: String; ValueName: "{#exeGameFolder}\{#exeGameFile}"; ValueData: RUNASADMIN; Flags: UninsDeleteValue UninsDeleteKeyIfEmpty CreateValueIfDoesntExist; Check: not ISWin64
#ifdef exeGameFile64
  Root: HKLM; SubKey: "SOFTWARE\TimickRepack\{#GameNameFolder}"; ValueName: "GameEXE";      ValueType: String; ValueData: "{#exeGameFolder64}\{#exeGameFile64}"; Flags: UninsDeleteValue UninsDeleteKeyIfEmpty CreateValueIfDoesntExist; Check: ISWin64
  Root: HKCU; SubKey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: String; ValueName: "{#exeGameFolder64}\{#exeGameFile64}"; ValueData: RUNASADMIN; Flags: UninsDeleteValue UninsDeleteKeyIfEmpty CreateValueIfDoesntExist; Check: ISWin64
#endif

[Code]
var
  InstallTrue: Boolean;
  Time3Label: String;
  CustomDirEdit: TEdit;
  DirEditImg, I: LongInt;
  DiskTimer: LongWord;
  BtnFont: TFont;
#ifdef MD5
  hMD5Btn,
#endif
#ifdef Components
  hComponentsBtn,
#endif
  hBackBtn, hNextBtn, hCancelBtn, hDirBrowseBtn, hMinBtn, hIconDPCheckBox, hIconGroupCheckBox, hSoftCheckBox: HWND;
#ifdef TaskCheckBox
  SelectTasksLabel2, SoftLabel,
#endif
  EmptyLabel, LabelOne, LabelTwo, Total_Free_SpaceLabel, NeedSpacelabel, SelectTasksLabel1, IconLabel, NoIconsLabel: TLabel;

//============ [Подключение модулей ] ============\\
#include "Modules\XTime.iss"

#include "Modules\Botva2.iss"
#include "Modules\Func&Proc.iss"
#include "Modules\TLabelFunc.iss" 
#include "Modules\TButtonFunc.iss"
#include "Modules\Other.iss"
#include "Modules\WinTB.iss"
#include "Modules\Messages.iss"
#include "Modules\ProgressBar.iss"
#include "Modules\ExecAndWait.iss"
#include "Modules\Uninstall.iss"
#include "Modules\Header.iss"
#include "ISDone.iss"    

#ifdef Splash
  #include "Modules\Splash.iss"
#endif
#ifdef Music
  #include "Modules\MusicSkripts.iss"
#endif
#ifdef MD5
  #include "Modules\MD5.iss"
#endif
#ifdef Components
  #include "Modules\Components.iss"
#endif
//============ [Подключение модулей ] ============\\

Function InitializeSetup(): Boolean;
begin
  if not FileExists(ExpandConstant('{tmp}\B2P.dll'))    then ExtractTemporaryFile('B2P.dll');
  if not FileExists(ExpandConstant('{tmp}\Botva2.dll')) then ExtractTemporaryFile('Botva2.dll');
  if not FileExists(ExpandConstant('{tmp}\XTime.dll')) then ExtractTemporaryFile('XTime.dll');

  Result := True;
  InstallTrue := Result;
end;

//************************************************ [Начало - Загрузка изображений] ****************************************//
Procedure CreateWizardImg();
begin
  With WizardForm do begin
    Bevel.Hide;
    InnerNotebook.Hide;
    OuterNotebook.Hide;
    Font.Name := {#FontName};
    BorderStyle := bsNone;
    ClientWidth := ScaleX(1000);
    ClientHeight := ScaleY(522);
    Center;
  end;

  EmptyLabel := TLabelCreate(WizardForm, ScaleX(0), ScaleX(0), ScaleX(1000), ScaleX(422), 10, '', {#FontName}, {#FontColor}, [], False, taLeftJustify, nil, @FrameMouseDown);

  ImgLoad(WizardForm.Handle, 'Fon.jpg', ScaleX(0), ScaleY(0), ScaleX(1000), ScaleY(422), True, True);
  ImgLoad(WizardForm.Handle, 'Frame1.png', ScaleX(0), ScaleY(422), ScaleX(1000), ScaleY(100), True, True);

  DirEditImg := ImgLoad(WizardForm.Handle, 'DirEditImg.png', ScaleX(21), ScaleY(511), ScaleX(333), ScaleY(1), True, True);

  ImgApplyChanges(WizardForm.Handle);
end;
//************************************************ [Конец - Загрузка изображений] *******************************************//

//************************************************ [Начало - Текстуры кнопок] ***************************************************//
Procedure GetStateOriginalBtn();
begin
  With WizardForm.BackButton do begin
    BtnSetText(hBackBtn, PAnsiChar(Caption));
    BtnSetVisibility(hBackBtn, Visible);
    BtnSetEnabled(hBackBtn, Enabled);
    BtnRefresh(hBackBtn);
  end;

  With WizardForm.NextButton do begin
    BtnSetText(hNextBtn, PAnsiChar(Caption));
    BtnSetVisibility(hNextBtn, Visible);
    BtnSetEnabled(hNextBtn, Enabled);
    BtnRefresh(hNextBtn);
  end;

  With WizardForm.CancelButton do begin
    BtnSetVisibility(hCancelBtn, Visible);
    BtnSetEnabled(hCancelBtn, Enabled);
    BtnRefresh(hCancelBtn);
  end;
end;

Procedure WizardFormBtnClick(hBtn: HWND);
var
  Btn: TButton;
begin
  Case hBtn of
    hNextBtn:
      Btn := WizardForm.NextButton;
    hBackBtn:
      Btn := WizardForm.BackButton;
    hCancelBtn:
      Btn := WizardForm.CancelButton;
    hDirBrowseBtn:
      Btn := WizardForm.DirBrowseButton;
  end;
  if Btn <> nil then
    Btn.OnClick(Btn);

  SoundClickPlay();
  GetStateOriginalBtn();
  BtnRefresh(hBtn);
end;

Procedure MinimizeBtnClick();
begin
  SoundClickPlay();
  WizardForm.SetFocus;
  ReleaseCapture();
  SendMessage(WizardForm.Handle, $112, 61472, 0);
end;

// Не работает!
Procedure DirBrowseBtnClick();
var
  f: String;
begin
  f := XBrowseFolder('');
  if f <> '' then
    WizardForm.DirEdit.Text := f;
end;

Procedure CreateButtons();
var
  MinColorBtn, CloseColorBtn: String;
begin
  StandartBtnHide();

  BtnFont := TFont.Create();
  With BtnFont do begin
    Name := {#FontName};
    Size := 9;
  end;

#if Mode == "Black"
  MinColorBtn := 'Min_Black.png';
  CloseColorBtn := 'Close_Black.png';
#else if Mode == "White"
  MinColorBtn := 'Min_White.png';
  CloseColorBtn := 'Close_White.png';
#endif
 
  hNextBtn := TButtonCreate(WizardForm.Handle, 856, 472, 130, 40, 'Button.png', BtnFont.Handle, '', 'SoundEnterPlay', 'WizardFormBtnClick');
  BtnSetFontColor(hNextBtn, {#FontColor}, $FFFFFF, $FFFFFF, $FFFFFF);

  hBackBtn := TButtonCreate(WizardForm.Handle, 717, 472, 130, 40, 'Button.png', BtnFont.Handle, '', 'SoundEnterPlay', 'WizardFormBtnClick');
  BtnSetFontColor(hBackBtn, {#FontColor}, $FFFFFF, $FFFFFF, $FFFFFF);

#ifdef MD5
  hMD5Btn := TButtonCreate(WizardForm.Handle, 717, 472, 130, 40, 'Button.png', BtnFont.Handle, CustomMessage('CheckMD5'), 'SoundEnterPlay', 'MD5CheckShow');
  BtnSetFontColor(hMD5Btn, {#FontColor}, $FFFFFF, $FFFFFF, $FFFFFF);
#endif

#ifdef Components
  hComponentsBtn := TButtonCreate(WizardForm.Handle, 578, 472, 130, 40, 'Button.png', BtnFont.Handle, CustomMessage('CheckComponents'), 'SoundEnterPlay', 'ComponentsForm');
  BtnSetFontColor(hComponentsBtn, {#FontColor}, $FFFFFF, $FFFFFF, $FFFFFF);
#endif

  hDirBrowseBtn := TButtonCreate(WizardForm.Handle, 380, 482, 30, 30, 'DirButton.png', -1, '', 'SoundEnterPlay', 'WizardFormBtnClick');
  hCancelBtn := TButtonCreate(WizardForm.Handle, 970, 14, 12, 12, CloseColorBtn, -1, '', 'SoundEnterPlay', 'WizardFormBtnClick');
  hMinBtn := TButtonCreate(WizardForm.Handle, 942, 14, 12, 12, MinColorBtn, -1, '', 'SoundEnterPlay', 'MinimizeBtnClick');
end;
//************************************************ [Конец - Текстуры кнопок] ***************************************************//

//************************************************[Начало - Проверка места на диске]*************************************************************\\
Procedure GetFreeSpaceCaption(Sender: TObject);
var
  EnblDisk, GoodSize: Boolean;
  FreeMB, TotalMB: Cardinal;
begin
  EnblDisk := GetSpaceOnDisk(ExtractFileDrive(WizardForm.DirEdit.Text), True, FreeMB, TotalMB);
  if EnblDisk and ({#TMPNeedSize} < FreeMB) then GoodSize := True else GoodSize := False;

  TLabelText(Total_Free_SpaceLabel, FmtMessage(CustomMessage('DiskInfo'), [MbOrTb(TotalMB), MbOrTB(FreeMb)]));
  if {#NeedSize} = {#TMPNeedSize} then TLabelText(NeedSpaceLabel, CustomMessage('NeedSpace') + ' ' + MbOrTb({#NeedSize})) else TLabelText(NeedSpaceLabel, FmtMessage(CustomMessage('TNeedSpace'), [MbOrTb({#NeedSize}), MbOrTb({#TMPNeedSize})]));

  if GoodSize then begin
    TLabelColor(NeedSpaceLabel, {#FontColor});
    TLabelColor(Total_Free_SpaceLabel, {#FontColor});
  end else begin
    TLabelColor(NeedSpaceLabel, {#ErrFontColor});
    TLabelColor(Total_Free_SpaceLabel, {#ErrFontColor});
  end;

  BtnSetEnabled(hNextBtn, GoodSize);
  WizardForm.NextButton.Enabled:= GoodSize;
end;

Procedure SSOK();
begin
  GetFreeSpaceCaption(nil);
  CustomDirEdit.Text := MinimizePathName(WizardForm.DirEdit.Text, CustomDirEdit.Font, CustomDirEdit.Width);
end;

Procedure NeedSpace();
begin
  Total_Free_SpaceLabel := TLabelCreate(WizardForm, 15, 447, 300, 16, 9, '', {#FontName}, {#FontColor}, [], False,  taLeftJustify, nil, nil);
  NeedSpaceLabel := TLabelCreate(WizardForm, 15, 462, 300, 16, 9, '', {#FontName}, {#FontColor}, [], False,  taLeftJustify, nil, nil);

  WizardForm.DirEdit.OnChange := @GetFreeSpaceCaption;
  WizardForm.DirEdit.Text := WizardForm.DirEdit.Text + #0;
end;
//************************************************[Конец - Проверка места на диске]*************************************************************\\

//************************************************ [Начало - Создание лейблов] ***************************************************//
Procedure CreateLabels();
begin
  //=============== [Начало - Main] ===============\\
  LabelOne := TLabelCreate(WizardForm, 15, 428, 800, 70, 10, '', {#FontName}, {#FontColor}, [], False,  taLeftJustify, nil, nil);
  labelTwo := TLabelCreate(WizardForm, 15, 446, 700, 70, 10, '', {#FontName}, {#FontColor}, [], False,  taLeftJustify, nil, nil);
  //=============== [Конец - Main] ===============\\

  //=============== [Начало - SelectDirPage] ===============\\
  CustomDirEdit := TEdit.Create(WizardForm);
  With CustomDirEdit do begin
    Parent := WizardForm;
    SetBounds(ScaleX(35), ScaleY(490), ScaleX(300), ScaleY(18));
    BorderStyle := bsNone;
    Color := $272727;
    With Font do begin
      Name  := {#FontName};
      Color := {#FontColor};
      Size  := 10;
    end;
  end;
  //=============== [Конец - SelectDirPage] ===============\\

  //=============== [Начало - SelectComponentsPage] ================\\
  SelectTasksLabel1 := TLabelCreate(WizardForm, 15, 447, 100, 18, 10, CustomMessage('SelectTasks1'), {#FontName}, {#FontColor}, [], False,  taLeftJustify, nil, nil);

  //***************** [Ярлык на РБ] *****************\\
  hIconDPCheckBox := BtnCreate(WizardForm.Handle, ScaleX(30), ScaleY(468), ScaleX(13), ScaleY(13), 'CheckBox.png', 1, True);
  BtnSetEvent(hIconDPCheckBox, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(hIconDPCheckBox, BtnClickEventID, CallBackAddr('IconClick'));
  BtnSetCursor(hIconDPCheckBox, GetSysCursorHandle(32649));
  BtnSetChecked(hIconDPCheckBox, True);

  IconLabel := TLabelCreate(WizardForm, 50, 467, 148, 18, 9, CustomMessage('Icon'), {#FontName}, {#FontColor}, [], False, taLeftJustify, @IconLabelClick, nil);
  //***************** [Ярлык на РБ] *****************\\

  //***************** [Ярлык в МП] *****************\\
  hIconGroupCheckBox := BtnCreate(WizardForm.Handle, ScaleX(30), ScaleY(489), ScaleX(13), ScaleY(13), 'CheckBox.png', 1, True);
  BtnSetEvent(hIconGroupCheckBox, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(hIconGroupCheckBox, BtnClickEventID, CallBackAddr('IconClick'));
  BtnSetCursor(hIconGroupCheckBox, GetSysCursorHandle(32649));

  NoIconsLabel := TLabelCreate(WizardForm, 50, 488, 128, 18, 9, CustomMessage('NoIconsCheck'), {#FontName}, {#FontColor}, [], False, taLeftJustify, @IconGroupLabelClick, nil);
  //***************** [Ярлык в МП] *****************\\

#ifdef TaskCheckBox
  SelectTasksLabel2 := TLabelCreate(WizardForm, 250, 447, 100, 18, 10, CustomMessage('SelectTasks2'), {#FontName}, {#FontColor}, [], False, taLeftJustify, nil, nil);

  //***************** [Установка ПО] *****************\\
  hSoftCheckBox := BtnCreate(WizardForm.Handle, ScaleX(265), ScaleY(468), ScaleX(13), ScaleY(13), 'CheckBox.png', 1, True);
  BtnSetEvent(hSoftCheckBox, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(hSoftCheckBox, BtnClickEventID, CallBackAddr('IconClick'));
  BtnSetCursor(hSoftCheckBox, GetSysCursorHandle(32649));
  BtnSetChecked(hSoftCheckBox, False);

  SoftLabel := TLabelCreate(WizardForm, 285, 467, 190, 18, 9, CustomMessage('Soft'), {#FontName}, {#FontColor}, [], False, taLeftJustify, @SoftLabelClick, nil);
  //***************** [Установка ПО] *****************\\
#endif

  //=============== [Конец - SelectComponentsPage] ===============\\

  //=============== [Начало - InstallingPage] ===============\\
  ExtractedFileLB:= TLabelCreate(WizardForm, 15, 446, 700, 18, 9, '', {#FontName}, {#FontColor}, [], False, taLeftJustify, nil, nil);
  PassedTimeLB:=    TLabelCreate(WizardForm, 15, 461, 300, 18, 9, '', {#FontName}, {#FontColor}, [], False, taLeftJustify, nil, nil);
  LeftTimeLB:=      TLabelCreate(WizardForm, 15, 476, 300, 18, 9, '', {#FontName}, {#FontColor}, [], False, taLeftJustify, nil, nil);
  ProgressLB:=      TLabelCreate(WizardForm, 15, 491, 700, 18, 9, '', {#FontName}, {#FontColor}, [], False, taLeftJustify, nil, nil);
  //=============== [Конец - InstallingPage] ===============\\
end;
//************************************************ [Конец - Создание лебелов] ***************************************************//

Procedure InitializeWizard();
begin
  CreateWizardImg();

  #ifdef Music
    InitMusic();
  #endif
  #ifdef Splash
    RunSplash();
  #endif
  #ifdef CustomFont
    if not FontExists({#FontName}) then begin
      ExtractTemporaryFile({#FontName} + '.ttf');
      AddFontResource(ExpandConstant('{tmp}\' + {#FontName} + '.ttf'), $10, 0);
    end;
  #endif

  SetPriorityClass(GetCurrentProcess, $00000080);
  SetClassLong(WizardForm.Handle, -26, GetClassLong(WizardForm.Handle, -26) or $200);

  CreateLabels();
  CreateButtons();
  NeedSpace();
  WinTBWizard();
end;

Procedure HideComponents();
begin
//Лейблы:
  LabelTwo.Hide;
  CustomDirEdit.Hide;
  NeedSpaceLabel.Hide;
  Total_Free_SpaceLabel.Hide;
  SelectTasksLabel1.Hide;
  IconLabel.Hide;
  NoIconsLabel.Hide;
#ifdef TaskCheckBox
  SelectTasksLabel2.Hide;
  SoftLabel.Hide;
  BtnSetVisibility(hSoftCheckBox, False);
#endif

//Кнопки:
#ifdef MD5
  BtnSetVisibility(hMD5Btn, False);
#endif
#ifdef Components
  BtnSetVisibility(hComponentsBtn, False);
#endif
  BtnSetVisibility(hDirBrowseBtn, False);
  BtnSetVisibility(hIconGroupCheckBox, False);
  BtnSetVisibility(hIconDPCheckBox, False);

//Изображения:
  ImgSetVisibility(DirEditImg, False);

//Другое:
  ISDoneHide();
end;

Procedure CurPageChanged(CurPageID: Integer);
begin
  GetStateOriginalBtn();
  HideComponents();

  Case CurPageID of
    wpWelcome: begin
      SetTaskBarThumbnailTooltip('{#GameName} | Приветствие');

      LabelOne.Caption := ExpandConstant('{cm:Welcome1}');
      LabelTwo.Show;
      LabelTwo.Caption := ExpandConstant('{cm:Welcome2}');
      #ifdef MD5
        BtnSetVisibility(hMD5Btn, True);
      #endif
    end;

    wpSelectDir: begin
      SetTaskBarThumbnailTooltip('{#GameName} | Выбор папки');

      LabelOne.Caption := ExpandConstant('{cm:SelectDirLabel}');
      Total_Free_SpaceLabel.Show;
      NeedSpaceLabel.Show;
      CustomDirEdit.Show;
      BtnSetVisibility(hDirBrowseBtn, True);
      ImgSetVisibility(DirEditImg, True);
      GetFreeSpaceCaption(nil);
      DiskTimer := SetTimer(WizardForm.Handle, 02, 10, CallBackAddr('SSOK'));
    end;

    wpSelectProgramGroup: begin
      SetTaskBarThumbnailTooltip('{#GameName} | Дополнительно');

      KillTimer(WizardForm.Handle, DiskTimer);
      SelectTasksLabel1.Show;
      NoIconsLabel.Show;
      IconLabel.Show;
      LabelOne.Caption:= ExpandConstant('{cm:SelectComponentsLabel}');
      BtnSetVisibility(hIconDPCheckBox, True);
      BtnSetVisibility(hIconGroupCheckBox, True);
      TButton(WizardForm.FindComponent('NextButton')).Caption:= CustomMessage('ButtonInstall');
      #ifdef Components
        BtnSetVisibility(hComponentsBtn, True);
      #endif
      #ifdef TaskCheckBox
        SelectTasksLabel2.Show;
        SoftLabel.Show;
        BtnSetVisibility(hSoftCheckBox, True);
      #endif
    end;

    wpInstalling: begin
      SetTaskBarThumbnailTooltip('{#GameName} | Установка');

      LabelOne.Caption:= ExpandConstant('{cm:InstallingLabel}');
      ISDoneShow();
    end;

    wpFinished: begin
      SetTaskBarThumbnailTooltip('{#GameName} | Окончание');

      BtnSetEnabled(hMinBtn, False);
      BtnSetEnabled(hCancelBtn, False);
      LabelOne.Font.Color:= {#GoodFontColor};
      LabelOne.Caption:= ExpandConstant('{cm:FinishedHeadingLabel} ') + Time3Label;
      LabelTwo.Show;
      LabelTwo.Caption:= ExpandConstant('{cm:FinishedLabel}');
    end;
  end;

  if (CurPageID = wpFinished) and ISDoneError then
    begin
      SetTaskBarThumbnailTooltip('{#GameName} | Окончание');

      BtnSetEnabled(hMinBtn, False);
      BtnSetEnabled(hCancelBtn, False);
      LabelOne.Font.Color:= {#ErrFontColor};
      LabelOne.Caption:= ExpandConstant('{cm:ErrorFinishedHeadingLabel}');
      LabelTwo.Show;
      LabelTwo.Caption:= ExpandConstant('{cm:ErrorFinishedLabel}');
    end;

  ImgApplyChanges(WizardForm.Handle);
end;

Procedure CurStepChanged(CurStep: TSetupStep);
begin
  ISDoneUnPack(CurStep);
end;

Procedure DeinitializeSetup();
begin
  if InstallTrue then begin
    #ifdef CustomFont
      RemoveFontResource(ExpandConstant('{tmp}\' + {#FontName} + '.ttf'), $10, 0);
    #endif
    #ifdef Music
      StopMusic();
    #endif
    gdipShutdown();

    if BtnFont <> nil then
      BtnFont.Free;
    if WizardForm <> nil then
      WizardForm.Free;
  end;
end;
