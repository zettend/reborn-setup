#ifndef IS_ENHANCED
  #error Enhanced edition of Inno Setup (ResTools) is required to compile this script
#endif

//====== [Игровые параметры] ======\\
#define GameID "{202B9BB9-5AAA-4496-A202-44640DFF6A4D}_TimickRePack" ;GUID игры.

#define GameName "Project Cars" ;Название игры
#define GameVerName  "Project Cars [V.11.0.0.0.1235]" ;Название игры + Версия
#define GameNameFolder "Project Cars" ;Название игры (Без \ / ? : * " > < |)
#define GameVer "11.0.0.0.1235" ;Версия игры6.0.1211685

#define exeGameFile "pCARS.exe" ;Файл запуска (x86) (Пример: pCARS.exe)
#define exeGameFolder "{app}" ;Папка где лежит файл запуска (Пример: {app}\bin32)

#define exeGameFile64 "pCARS64.exe" ;Файл запуска (x64) (Пример: pCARS64.exe)
#define exeGameFolder64 "{app}" ;Папка где лежит файл запуска (Пример: {app}\bin64)

#define SetupName "Setup_PC" ;Название файла установки

#define Publisher "Slightly Mad Studios" ;Издетель
#define Company   "Timick (06.10.16)" ;Репакер

#define NeedSize "17408" ;Игра займёт на диске (МБ) | (11ГБ = 11264МБ)
#define TMPNeedSize "20408" ;Требуется для распаковки (МБ) | (11ГБ = 11264МБ)
//====== [Игровые параметры] ======\\

//====== [Модули] ======\\
#define TaskCheckBox /* Установка ПО */
#define Music /* Музыка */
#define MD5 /* Проверка MD5 */
#define Splash /* Splash Заставка */
//====== [Модули] ======\\

//====== [Оформление] ======\\
;Цвет значков "Свернуть, Закрыть, Инфо":
#define Mode "White" ;"Black" или "White"

;#define TopFrame /* Темная полоса сверху */

;#define Slides /* Слайдшоу на странице установке */
  #define SlidesCount "4" /* Количество слайдов */
  #define SlidesTime "5000" /* Время показа слайда */
  
;Настройки шрифта:
;#define CustomFont "InstallFiles\Fonts\Roboto-Light.ttf" ;Кастомный шрифт (Ненужен - Закомментировать)
#define FontName "'Georgia'" ;Название используемого шрифта
#define FontColor "$f1f0ec" ;Основной Цвет текста
#define ErrFontColor "$3c4ce7" ;Цвет текста при ошибке
#define GoodFontColor "$228b22" ;Цвет текста при ошибке
//====== [Оформление] ======\\

//====== [Работа с ISDone] ======\\
;#define Records
#define Facompress
#define SrepInside
;#define NanoZip
;#define PrecompInside
;#define Precomp_MT
;#define Reflate_MT
;#define pZlib
;#define FAZip
;#define MSCInside
;#define UnRar
;#define XDelta
;#define PackZIP

#define Password "1g2x3h7421" /* Пароль на архивы */
//====== [Работа с ISDone] ======\\

//====== [Сохранения] ======\\
;#define DeleteSaved
  ;#define Save1 "ExpandConstant('{userdocs}') + '\4A Games\Metro 2033\'"
  ;#define Save2 "ExpandConstant('{sd}') + '\ProgramData\Steam\228048\Fallout4'"
  ;#define Save3 "ExpandConstant('{localappdata}') + '\Fallout4'"
//====== [Сохранения] ======\\

[Setup]
AppID={{#GameID}
AppName={#GameName}
AppVerName={#GameVerName}
AppCopyright=© {#Company}
AppPublisher={#Publisher}
DefaultDirName={code:NoSD}\Games\{#GameNameFolder}
DefaultGroupName=TimickRePack\{#GameNameFolder}
VersionInfoDescription={#GameName}
VersionInfoCompany={#Company}
VersionInfoProductVersion={#GameVer}
OutputBaseFilename={#SetupName}
#ifdef CustomFont
  RawDataResource=Font:{#CustomFont}
#endif
;------------------------------------------
VersionInfoVersion=3.0
DisableReadyPage=Yes
DirExistsWarning=No
;Иконка инсталлятора
SetupIconFile=Icons\Icon_1.ico
;Куда поместить деинсталлятор
UninstallFilesDir={app}\Uninstall
;Степень сжатия (lzma2 - Максимум)
Compression=lzma2/Max
;Разбивать файлы инсталлятора
DiskSpanning=True
;Привилегии инсталлятора (none, poweruser, admin)
PrivilegesRequired=Admin

[Files]
//************************* [Инсталлятор] *************************\\
#ifdef CustomFont
  Source: {#CustomFont};              Flags: DontCopy
#endif
Source: InstallFiles\ImageFiles\*.*;  Flags: DontCopy
Source: InstallFiles\DllFiles\*.*;    Flags: DontCopy
#ifdef Slides
  Source: InstallFiles\ImageFiles\SlidesFiles\*.*;  Flags: DontCopy
#endif
#if Mode == "Black"
  Source: InstallFiles\ImageFiles\B&W_Mode\Close.png;          Flags: DontCopy
  Source: InstallFiles\ImageFiles\B&W_Mode\Min.png;            Flags: DontCopy
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
Root: HKLM; SubKey: "SOFTWARE\TimickRepack";                                                                                                               Flags: UninsDeleteKeyIfEmpty CreateValueIfDoesntExist
Root: HKLM; SubKey: "SOFTWARE\TimickRepack\{#GameNameFolder}"; ValueName: "Install Dir";  ValueType: String; ValueData: "{app}";                           Flags: UninsDeleteValue UninsDeleteKeyIfEmpty CreateValueIfDoesntExist
Root: HKLM; SubKey: "SOFTWARE\TimickRePack\{#GameNameFolder}"; ValueName: "Product GUID"; ValueType: String; ValueData: "{{#GameID}";                      Flags: UninsDeleteValue UninsDeleteKeyIfEmpty CreateValueIfDoesntExist
#ifndef exeGameFile64
  Root: HKLM; SubKey: "SOFTWARE\TimickRepack\{#GameNameFolder}"; ValueName: "GameEXE";  ValueType: String; ValueData: "{#exeGameFolder}\{#exeGameFile}"; Flags: UninsDeleteValue UninsDeleteKeyIfEmpty CreateValueIfDoesntExist; Check: not ISWin64
#endif
#ifdef exeGameFile64
  Root: HKLM; SubKey: "SOFTWARE\TimickRepack\{#GameNameFolder}"; ValueName: "GameEXE";  ValueType: String; ValueData: "{#exeGameFolder64}\{#exeGameFile64}"; Flags: UninsDeleteValue UninsDeleteKeyIfEmpty CreateValueIfDoesntExist; Check: ISWin64
#endif

Root: HKCU; SubKey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: String; ValueName: "{#exeGameFolder}\{#exeGameFile}"; ValueData: RUNASADMIN; Flags: UninsDeleteValue UninsDeleteKeyIfEmpty CreateValueIfDoesntExist
#ifdef exeGameFile64
  Root: HKCU; SubKey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: String; ValueName: "{#exeGameFolder64}\{#exeGameFile64}"; ValueData: RUNASADMIN; Flags: UninsDeleteValue UninsDeleteKeyIfEmpty CreateValueIfDoesntExist
#endif

[Code]
const
  SizeInt = {#NeedSize};
  TMPSizeInt = {#TMPNeedSize};

var
  CustomDirEdit: TEdit;
  DirEditImg: LongInt;
  DiskTimer: LongWord;
  I: Integer;
  hNextBtn, hBackBtn, hDirBrowseBtn, Min, CloseBtn, IconGroupBtn, IconBtn, hSoftBtn, hMD5Btn: HWND;
  WFButtonFont, WindButtonFont, MusicButtonFont: TFont;
  EmptyLabel, LabelOne, LabelTwo, Total_Free_SpaceLabel, NeedSpacelabel, SelectTasksLabel1, SelectTasksLabel2, IconLabel, SoftLabel, NoIconsLabel: TLabel;
  FreeMB, TotalMB: Cardinal;
  #ifdef Slides
    AImg           : Array of LongInt;
    CurrentImage   : Integer;
    TimerSL,       : LongWord;
  #endif

Function MbOrTb(Float: Extended): String;
begin
  if Float < 1024 then Result:= FormatFloat('0', Float) + ExpandConstant(' {cm:MB}') else
   if Float/1024 < 1024 then Result:= Format('%.2n', [Float/1024]) + ExpandConstant(' {cm:GB}') else
     Result:= Format('%.2n', [Float/(1024*1024)]) + ExpandConstant(' {cm:TB}');
  StringChange(Result, ',', '.');
end;

//============ [Подключение модулей - 2] ============\\
#include "Modules\ISSkin&WinTB.iss"
#include "Modules\Messages.iss"
#include "Modules\Botva2.iss"
#include "Modules\ProgressBar.iss"
#include "Modules\Header.iss"
#include "Modules\ExecAndWait.iss"
#include "Modules\Uninstall.iss"
#ifdef MD5
  #include "Modules\MD5.iss"
#endif
#ifdef Music
  #include "Modules\MusicSkripts.iss"
#endif
#ifdef Splash
  #include "Modules\Splash.iss"
#endif
#include "ISDone.iss"
//============ [Подключение модулей - 2] ============\\

Function SetTimer(hWnd, nIDEvent, uElapse, lpTimerFunc: LongWord): LongWord; external 'SetTimer@user32.dll stdcall';
Function KillTimer(hWnd, nIDEvent: LongWord): LongWord; external 'KillTimer@user32.dll stdcall';
Function SetWindowRgn(hWnd: HWND; hRgn: LongWord; bRedraw: BOOL): Integer;  external 'SetWindowRgn@user32.dll stdcall';
Function ReleaseCapture: Longint; external 'ReleaseCapture@user32.dll stdcall';
Function CreateRoundRectRgn(p1, p2, p3, p4, p5, p6: Integer): THandle; external 'CreateRoundRectRgn@gdi32 stdcall';
Function SetPriorityClass(hProcess: THandle; dwPriorityClass: DWORD): BOOL; external 'SetPriorityClass@kernel32';
Function GetCurrentProcess: THandle; external 'GetCurrentProcess@kernel32';
#ifdef CustomFont
  Function ADDFontResource(lpszFilename: String; fl, pdv: DWORD): Integer; external 'AddFontResourceEx{#A}@gdi32.dll stdcall';
  Function RemoveFontResource(lpFileName: String; fl, pdv: DWORD): BOOL; external 'RemoveFontResourceEx{#A}@gdi32.dll stdcall';
#endif

#ifdef Slides
  Procedure SlideShow();
  begin
    ImgSetVisibility(AImg[CurrentImage], False);
    CurrentImage:= CurrentImage + 1;
    if CurrentImage = GetArrayLength(AImg) then CurrentImage:= 0;
    ImgSetVisibility(AImg[CurrentImage], True);
    ImgApplyChanges(WizardForm.Handle);
  end;

  Procedure ExtrImageSL();
  begin
    SetArrayLength(AImg, {#SlidesCount});
    For i:= 0 to GetArrayLength(AImg)-1 do begin
      AImg[i]:= ImgLoad(WizardForm.Handle, IntToStr(i) + '.jpg', ScaleX(0), ScaleY(0), ScaleX(1000), ScaleY(422), True, True);
      ImgSetVisibility(AImg[i], False);
      ImgSetVisibility(AImg[0], True);
      ImgApplyChanges(WizardForm.Handle);
    end;
  end;
#endif

//================= [Установка на НЕ системный HDD] =================\\
Function GetDriveType(lpRootPathName: PAnsiChar): Cardinal; external 'GetDriveTypeA@kernel32.dll stdcall';
Function GetLogicalDrives: DWORD; external 'GetLogicalDrives@kernel32.dll stdcall';
Function NoSD(S: String): String;
var
  x, bit: Integer; tp: Cardinal; SD: String;
begin
  SD:= ExpandConstant('{sd}');
  Result:= SD;
  x:= GetLogicalDrives;
  if x <> 0 then for i:= 1 to 64 do begin
    bit:= x and 1;
    if bit = 1 then begin
      tp:= GetDriveType(PChar(Chr(64 + i) + ':'));
      if tp = 3 then
      if Chr(64 + i) <> Copy(SD, 1, 1) then begin
        Result:= Chr(64 + i) + ':';
        Break;
      end;
    end;
    x:= x shr 1;
  end;
end;
//================= [Установка на НЕ системный HDD] =================\\

//================= [Пропуск страниц] =================\\
Function ShouldSkipPage(PageID: Integer): Boolean;
begin
  if (PageID = wpSelectTasks) or (PageID = wpSelectComponents) then Result:= True;
end;
//================= [Пропуск страниц] =================\\

Procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
 Confirm:= False;
 Cancel:= True;
end;

Procedure ShapeForm(aForm: TForm; edgeSize: integer);
var
  FormRegion: HWND;
begin
  FormRegion:= CreateRoundRectRgn(0, 0, aForm.Width, aForm.Height, edgeSize, edgeSize);
  SetWindowRgn(aForm.Handle, FormRegion, True);
end;

Procedure FrameMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  WizardForm.SetFocus;
  ReleaseCapture;
  SendMessage(WizardForm.Handle, $0112, $F012, 0);
end;

Function LabelCreate1(WND: TWinControl; L, T, W, H, FontSize: Integer; Text, FontName: String; FontColor: TColor; _WordWrap, _AutoSize: Boolean; _Alignment: Talignment): TLabel;
begin
  Result:= TLabel.Create(WND);
  with Result do begin
    SetBounds(L, T, W, H);
    AutoSize:= _AutoSize;
    Alignment:= _Alignment;
    Transparent:= True;
    WordWrap:= _WordWrap;
    Font.Name:= FontName;
    Font.Size:= FontSize;
    Font.Color:= FontColor;
    Caption:= Text;
    Parent:= WND;
  end;
end;

Function LabelCreate2(WND: TWinControl; L, T, W, H, FontSize: Integer; Text, FontName: String; FontColor: TColor; _Alignment: Talignment): TLabel;
begin
  Result:= TLabel.Create(WND);
  with Result do begin
    SetBounds(L, T, W, H);
    Alignment:= _Alignment;
    Transparent:= True;
    Font.Name:= FontName;
    Font.Size:= FontSize;
    Font.Color:= FontColor;
    Caption:= Text;
    Parent:= WND;
  end;
end;

Function InitializeSetup: Boolean;
begin
  if not FileExists(ExpandConstant('{tmp}\B2P.dll')) then ExtractTemporaryFile('B2P.dll');
  if not FileExists(ExpandConstant('{tmp}\Botva2.dll')) then ExtractTemporaryFile('Botva2.dll');
  SkinSetup();
  Result:= True;
end;

//************************************************ [Начало - Загрузка изображений] ****************************************//
Procedure CreateWizardImg;
begin
  with WizardForm do begin
    Bevel.Hide;
    InnerNotebook.Hide;
    OuterNotebook.Hide;
    Font.Name:= {#FontName};
    ClientWidth:= ScaleX(994);
    ClientHeight:= ScaleY(493);
    BorderStyle := bsNone;
    Center;
  end;

  EmptyLabel:= LabelCreate1(WizardForm, ScaleX(0), ScaleY(0), ScaleX(1000), ScaleY(422), 10, '', {#FontName}, {#FontColor}, True, False, taLeftJustify);
  EmptyLabel.OnMouseDown:= @FrameMouseDown;

  ImgLoad(WizardForm.Handle, 'Fon.jpg', ScaleX(0), ScaleY(0), ScaleX(1000), ScaleY(422), True, True);
  ImgLoad(WizardForm.Handle, 'Frame1.png', ScaleX(0), ScaleY(442), ScaleX(1000), ScaleY(100), True, True);
  #ifdef TopFrame
    ImgLoad(WizardForm.Handle, 'Frame2.png', ScaleX(0), ScaleY(0), ScaleX(1000), ScaleY(40), True, True);
  #endif
  DirEditImg:= ImgLoad(WizardForm.Handle, 'DirEditImg.png', ScaleX(21), ScaleY(511), ScaleX(333), ScaleY(1), True, True);
end;
//************************************************ [Конец - Загрузка изображений] *******************************************//

//************************************************ [Начало - Текстуры кнопок] ***************************************************//
Procedure SetStateNewButtons;
begin
  with WizardForm.BackButton do begin
    BtnSetText(hBackBtn, PAnsiChar(Caption));
    BtnSetVisibility(hBackBtn, Visible);
    BtnSetEnabled(hBackBtn, Enabled);
    BtnRefresh(hBackBtn);
  end;

  with WizardForm.NextButton do begin
    BtnSetText(hNextBtn, PAnsiChar(Caption));
    BtnSetVisibility(hNextBtn, Visible);
    BtnSetEnabled(hNextBtn, Enabled);
    BtnRefresh(hNextBtn);
  end;

  WizardForm.CancelButton.Width:= 0;
  WizardForm.CancelButton.Height:= 0;
end;

Procedure TimerRefreshBtn(S: TObject);
begin
  BtnRefresh(hBackBtn);
  BtnRefresh(hNextBtn);
  BtnRefresh(hDirBrowseBtn);
  #ifdef MD5
    BtnRefresh(hMD5Btn);
  #endif
end;

Procedure WizardFormBtnClick(hBtn:HWND);
var
  Btn:TButton;
begin
  case hBtn of
    hNextBtn:      Btn:= WizardForm.NextButton;
    hBackBtn:      Btn:= WizardForm.BackButton;
    hDirBrowseBtn: Btn:= WizardForm.DirBrowseButton;
  end;
  Btn.OnClick(Btn);
  SetStateNewButtons;
  BtnRefresh(hBtn);
end;

Procedure MinimizeBtnClick(h:HWND);
begin
  WizardForm.SetFocus;
  ReleaseCapture;
  SendMessage(WizardForm.Handle, $112, 61472, 0);
end;

Procedure CancelBtnClick(h:HWND);
begin
  WizardForm.CancelButton.OnClick(WizardForm.CancelButton);
end;

Procedure ButtonsTextures;
begin
  WFButtonFont:= TFont.Create;
  WFButtonFont.Name:= {#FontName};
  WFButtonFont.Size:= 9;

  WindButtonFont:= TFont.Create;
  WindButtonFont.Name:= {#FontName};
  WindButtonFont.Size:= 11;   

  with WizardForm.NextButton do begin
    hNextBtn:= BtnCreate(WizardForm.Handle, ScaleX(856), ScaleY(472), ScaleX(130), ScaleY(40), 'Button.png', 1, False);
    BtnSetEvent(hNextBtn, BtnClickEventID, CallBackAddr('WizardFormBtnClick'));
    BtnSetFont(hNextBtn, WFButtonFont.Handle);
    BtnSetCursor(hNextBtn, GetSysCursorHandle(32649));
    BtnSetFontColor(hNextBtn, {#FontColor}, $FFFFFF, $FFFFFF, $FFFFFF);
    Width:= 0;
    Height:= 0;
  end;

  with WizardForm.BackButton do begin
    hBackBtn:= BtnCreate(WizardForm.Handle, ScaleX(717), ScaleY(472), ScaleX(130), ScaleY(40), 'Button.png', 1, False);
    BtnSetEvent(hBackBtn, BtnClickEventID, CallBackAddr('WizardFormBtnClick'));
    BtnSetFont(hBackBtn, WFButtonFont.Handle);
    BtnSetCursor(hBackBtn, GetSysCursorHandle(32649));
    BtnSetFontColor(hBackBtn, {#FontColor}, $FFFFFF, $FFFFFF, $FFFFFF);
    Width:= 0;
    Height:= 0;
  end;

  with WizardForm.DirBrowseButton do begin
    hDirBrowseBtn:=BtnCreate(WizardForm.Handle, ScaleX(380), ScaleY(482), ScaleX(30),ScaleY(30), 'DirButton.png', 1, False);
    BtnSetEvent(hDirBrowseBtn,BtnClickEventID, CallBackAddr('WizardFormBtnClick'));
    BtnSetCursor(hDirBrowseBtn,GetSysCursorHandle(32649));
    Width:= 0;
    Height:= 0;
  end;

  #ifdef MD5
    hMD5Btn:= BtnCreate(WizardForm.Handle, ScaleX(717), ScaleY(472), ScaleX(130),ScaleY(40), 'Button.png', 1, False);
    BtnSetFont(hMD5Btn, WFButtonFont.Handle);
    BtnSetFontColor(hMD5Btn, {#FontColor}, $FFFFFF, $FFFFFF, $FFFFFF);
    BtnSetEvent(hMD5Btn, BtnClickEventID, CallBackAddr('MD5Hash'));
    BtnSetCursor(hMD5Btn, GetSysCursorHandle(32649));
    BtnSetText(hMD5Btn, 'Проверить MD5');
  #endif

  #if Mode == "Black"
    Min:= BtnCreate(WizardForm.Handle, ScaleX(942), ScaleY(14), ScaleX(12), ScaleY(12), 'Min.png', 1, False);
    BtnSetFont(Min, WindButtonFont.Handle);
    BtnSetEvent(Min, BtnClickEventID, CallBackAddr('MinimizeBtnClick'));
    BtnSetCursor(Min, GetSysCursorHandle(32649));

    CloseBtn:= BtnCreate(WizardForm.Handle, ScaleX(970), ScaleY(14), ScaleX(12), ScaleY(12), 'Close.png', 1, False);
    BtnSetFont(CloseBtn, WindButtonFont.Handle);
    BtnSetEvent(CloseBtn, BtnClickEventID, CallBackAddr('CancelBtnClick'));
    BtnSetCursor(CloseBtn, GetSysCursorHandle(32649));
  #else if Mode == "White"
    Min:= BtnCreate(WizardForm.Handle, ScaleX(942), ScaleY(14), ScaleX(12), ScaleY(12), 'Min_White.png', 1, False);
    BtnSetFont(Min, WindButtonFont.Handle);
    BtnSetEvent(Min, BtnClickEventID, CallBackAddr('MinimizeBtnClick'));
    BtnSetCursor(Min,GetSysCursorHandle(32649));

    CloseBtn:= BtnCreate(WizardForm.Handle, ScaleX(970), ScaleY(14), ScaleX(12), ScaleY(12), 'Close_White.png', 1, False);
    BtnSetFont(CloseBtn, WindButtonFont.Handle);
    BtnSetEvent(CloseBtn, BtnClickEventID, CallBackAddr('CancelBtnClick'));
    BtnSetCursor(CloseBtn, GetSysCursorHandle(32649));
  #endif
end;
//************************************************ [Конец - Текстуры кнопок] ***************************************************//

//************************************************[Начало - Проверка места на диске]*************************************************************\\
Procedure GetFreeSpaceCaption(Sender: TObject);
var
  EnblDisk, GoodSize: Boolean;
begin
  EnblDisk:= GetSpaceOnDisk(ExtractFileDrive(WizardForm.DirEdit.Text), True, FreeMB, TotalMB);
  if EnblDisk and (TMPSizeInt < FreeMB) then GoodSize:= True else GoodSize:= False;

  Total_Free_SpaceLabel.Caption:= FmtMessage(CustomMessage('DiskInfo'), [MbOrTb(TotalMB), MbOrTB(FreeMb)]);
  if SizeInt = TMPSizeInt then NeedSpaceLabel.Caption:= CustomMessage('NeedSpace') + ' ' + MbOrTb(SizeInt) else NeedSpaceLabel.Caption:= FmtMessage(CustomMessage('TNeedSpace'), [MbOrTb(SizeInt), MbOrTb(TMPSizeInt)]);

  if GoodSize then begin NeedSpaceLabel.Font.Color:= {#FontColor}; Total_Free_SpaceLabel.Font.Color:= {#FontColor}; end else begin NeedSpaceLabel.Font.Color:= {#ErrFontColor}; Total_Free_SpaceLabel.Font.Color:= {#ErrFontColor}; end;

  BtnSetEnabled(hNextBtn, GoodSize);
  WizardForm.NextButton.Enabled:= GoodSize;
end;

Procedure SSOK(HandleW, Msg, idEvent, TimeSys: LongWord);
begin
  GetFreeSpaceCaption(nil);
  CustomDirEdit.Text:= MinimizePathName(WizardForm.DirEdit.Text, CustomDirEdit.Font, CustomDirEdit.Width);
end;

Procedure NeedSpace();
begin
  Total_Free_SpaceLabel:= LabelCreate2(WizardForm, ScaleX(15), ScaleY(447), ScaleX(209), ScaleY(13), 9, '', {#FontName}, {#FontColor}, taLeftJustify);
  NeedSpaceLabel:=        LabelCreate2(WizardForm, ScaleX(15), ScaleY(462), ScaleX(209), ScaleY(13), 9, '', {#FontName}, {#FontColor}, taLeftJustify);

  WizardForm.DirEdit.OnChange:= @GetFreeSpaceCaption;
  WizardForm.DirEdit.Text:= WizardForm.DirEdit.Text + #0
end;
//************************************************[Конец - Проверка места на диске]*************************************************************\\

//************************************************ [Начало - Создание лебелов] ***************************************************//
Procedure CreateLabel;
 begin
  //=============== [Начало - Main] ===============\\
  LabelOne:= LabelCreate1(WizardForm, ScaleX(15), ScaleY(428), ScaleX(800), ScaleY(70), 10, '', {#FontName}, {#FontColor}, True, False, taLeftJustify);
  labelTwo:= LabelCreate1(WizardForm, ScaleX(15), ScaleY(446), ScaleX(700), ScaleY(70), 10, '', {#FontName}, {#FontColor}, True, False, taLeftJustify);
  //=============== [Конец - Main] ===============\\

  //=============== [Начало - SelectDirPage] ===============\\
  CustomDirEdit:= TEdit.Create(WizardForm);
  with CustomDirEdit do begin
    Parent:= WizardForm;
    SetBounds(ScaleX(35), ScaleY(490), ScaleX(300), ScaleY(18));
    BorderStyle:= bsNone;
    Color:= $272727;
    Font.Name:={#FontName};
    Font.Size:= 10;
    Font.Color:={#FontColor};
  end;
  //=============== [Конец - SelectDirPage] ===============\\

  //=============== [Начало - SelectComponentsPage] ================\\
  SelectTasksLabel1:= LabelCreate1(WizardForm, ScaleX(15), ScaleY(447), ScaleX(450), ScaleY(18), 10, CustomMessage('SelectTasks1'), {#FontName}, {#FontColor}, True, False, taLeftJustify);

  //***************** [Ярлык на РБ] *****************\\
  IconBtn:= BtnCreate(WizardForm.Handle, ScaleX(30), ScaleY(468), ScaleX(13), ScaleY(13), 'CheckBox.png', 1, True);
  BtnSetEvent(IconBtn, BtnClickEventID, CallBackAddr('IconClick'));
  BtnSetCursor(IconBtn, GetSysCursorHandle(32649));
  BtnSetChecked(IconBtn, True);

  IconLabel:= LabelCreate1(WizardForm, ScaleX(50), ScaleY(467), ScaleX(148), ScaleY(18), 9, CustomMessage('Icon'), {#FontName}, {#FontColor}, True, False, taLeftJustify);
  Iconlabel.OnClick:= @IconLabelClick;
  //***************** [Ярлык на РБ] *****************\\

  //***************** [Ярлык в МП] *****************\\
  IconGroupBtn:= BtnCreate(WizardForm.Handle, ScaleX(30), ScaleY(489), ScaleX(13), ScaleY(13), 'CheckBox.png', 1, True);
  BtnSetEvent(IconGroupBtn, BtnClickEventID, CallBackAddr('IconGroupClick'));
  BtnSetCursor(IconGroupBtn, GetSysCursorHandle(32649));
  BtnSetChecked(IconGroupBtn, False);

  NoIconsLabel:= LabelCreate1(WizardForm, ScaleX(50), ScaleY(488), ScaleX(138), ScaleY(18), 9, CustomMessage('NoIconsCheck'), {#FontName}, {#FontColor}, True, False, taLeftJustify);
  NoIconsLabel.OnClick:= @IconGroupLabelClick;
  //***************** [Ярлык в МП] *****************\\

  #ifdef TaskCheckBox
    SelectTasksLabel2:= LabelCreate1(WizardForm, ScaleX(250), ScaleY(447), ScaleX(450), ScaleY(200), 10, CustomMessage('SelectTasks2'), {#FontName}, {#FontColor}, True, False, taLeftJustify);

    //***************** [Установка ПО] *****************\\
    hSoftBtn:= BtnCreate(WizardForm.Handle, ScaleX(265), ScaleY(468), ScaleX(13), ScaleY(13), 'CheckBox.png', 1, True);
    BtnSetEvent(hSoftBtn, BtnClickEventID, CallBackAddr('SoftClick'));
    BtnSetCursor(hSoftBtn, GetSysCursorHandle(32649));
    BtnSetChecked(hSoftBtn, False);

    SoftLabel:= LabelCreate1(WizardForm, ScaleX(285), ScaleY(467), ScaleX(200), ScaleY(20), 9, CustomMessage('Soft'), {#FontName}, {#FontColor}, True, False, taLeftJustify);
    SoftLabel.OnClick:= @SoftLabelClick;
    //***************** [Установка ПО] *****************\\
  #endif

  //=============== [Конец - SelectComponentsPage] ===============\\

  //=============== [Начало - InstallingPage] ===============\\
  ExtractedFileLB:= LabelCreate1(WizardForm, ScaleX(15), ScaleY(446), ScaleX(700), ScaleY(18), 9, '', {#FontName}, {#FontColor}, False, False, taLeftJustify);
  PassedTimeLB:=    LabelCreate1(WizardForm, ScaleX(15), ScaleY(461), ScaleX(300), ScaleY(18), 9, '', {#FontName}, {#FontColor}, False, False, taLeftJustify);
  LeftTimeLB:=      LabelCreate1(WizardForm, ScaleX(15), ScaleY(476), ScaleX(300), ScaleY(18), 9, '', {#FontName}, {#FontColor}, False, False, taLeftJustify);
  ProgressLB:=      LabelCreate1(WizardForm, ScaleX(15), ScaleY(491), ScaleX(300), ScaleY(18), 9, '', {#FontName}, {#FontColor}, False, False, taLeftJustify);
  //=============== [Конец - InstallingPage] ===============\\
end;
//************************************************ [Конец - Создание лебелов] ***************************************************//

//*************************************** [ Начало - Разное ] ***************************************\\
//Поиск файлов в папке установки:
Function FindFirstNotEmptyFile(FromDir: String; Mask: String): LongWord;
var
  FSR, DSR: TFindRec; FindResult: Boolean;
begin
  Result:= 0;
  FindResult:= FindFirst(AddBackslash(FromDir) + Mask, FSR);
  while FindResult do begin
    if FSR.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then Result:= FSR.SizeLow + FSR.SizeHigh;
    if Result>0 then Exit;
    FindResult:= FindNext(FSR);
  end;
  if (Result = 0) then begin
    FindResult:= FindFirst(AddBackslash(FromDir)+ '*.*', DSR);
    while FindResult do begin
      if ((DSR.Attributes and FILE_ATTRIBUTE_DIRECTORY) = FILE_ATTRIBUTE_DIRECTORY) and not ((DSR.Name = '.') or (DSR.Name = '..')) then begin
        Result:= FindFirstNotEmptyFile(AddBackSlash(FromDir) + DSR.Name, Mask);
        Break;
      end;
      FindResult:= FindNext(DSR);
    end;
  end;
end;
//Поиск файлов в папке установки.

//Поиск Русских символов в пути:
Function ISAnsi(S: String): Boolean;
var
  S1, S2: String;
begin
  S1:= AnsiUppercase(S);
  S2:= Uppercase(S);
  if CompareStr(S1, S2) = 0 then begin
    S1:= Lowercase(S);
    S2:= AnsiLowercase(S);
    if CompareStr(S1, S2) = 0 then Result:= True;
  end;
end;
//Поиск Русских символов в пути.

Function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result:= True;
  if CurPageID = wpSelectDir then begin
    //Поиск Русских символов в пути:
    if not (ISAnsi(WizardForm.DirEdit.Text)) then begin
      MsgBoxEx(WizardForm.Handle, CustomMessage('NotRus1')   + #13 + CustomMessage('NotMsgBox'), CustomMessage('NotRus2')   + ' | ', MB_ICONERROR, 0, 10);
      Result:= False;
    end;
    //Поиск Русских символов в пути.

    //Поиск файлов в папке установки:
    if FindFirstNotEmptyFile(Trim(WizardForm.DirEdit.Text) + '\', '*.*') <> 0 then begin
      MsgBoxEx(WizardForm.Handle, CustomMessage('NotFold1')  + #13 + CustomMessage('NotMsgBox'), CustomMessage('NotFold2')  + ' | ', MB_ICONERROR, 0, 10);
      Result:= False;
    end;
    //Поиск файлов в папке установки.

    //Запрет установки на съемный диск:
    if GetDriveType(ExtractFileDrive(WizardForm.DirEdit.Text)) = 2 then begin
      MsgBoxEx(WizardForm.Handle, CustomMessage('NotFlash1') + #13 + CustomMessage('NotMsgBox'), CustomMessage('NotFlash2') + ' | ', MB_ICONERROR, 0, 10);
      Result:= False;
    end;
    //Запрет установки на съемный диск.
  end;
end;
//*************************************** [ Конец - Разное ] ***************************************\\

Procedure InitializeWizard;
begin
  #ifdef CustomFont
    if not FontExists({#FontName}) then begin
      ExtractTemporaryFile('{#FontName}.ttf');
      AddFontResource(ExpandConstant('{tmp}\{#FontName}.ttf'), $10, 0);
    end;
  #endif
  #ifdef Music
    InitMusic();
  #endif
  #ifdef Splash
    RunSplash();
  #endif
  SetPriorityClass(GetCurrentProcess, $00000080);
  CreateWizardImg;
  CreateLabel;
  ButtonsTextures;
  NeedSpace;
  WinTBWizard;
end;

Procedure HideComponents;
begin
//Лейблы:
  LabelOne.Hide;
  LabelTwo.Hide;
  NoIconsLabel.Hide;
  NeedSpaceLabel.Hide;
  Total_Free_SpaceLabel.Hide;
  SelectTasksLabel1.Hide;
  IconLabel.Hide;
  #ifdef TaskCheckBox
    SelectTasksLabel2.Hide;
    SoftLabel.Hide;
    BtnSetVisibility(hSoftBtn, False);
  #endif
  CustomDirEdit.Hide;
//Кнопки:
  #ifdef MD5
    BtnSetVisibility(hMD5Btn, False);
  #endif
  BtnSetVisibility(hDirBrowseBtn, False);
  BtnSetVisibility(IconGroupBtn, False);
  BtnSetVisibility(IconBtn, False);
//Изображения:
  ImgSetVisibility(DirEditImg, False);
//Другое:
  ISDoneHide;
end;

Procedure CurPageChanged(CurPageID: Integer);
begin
  SetStateNewButtons;
  HideComponents;
  LabelOne.Show;

  Case CurPageID of
    wpWelcome: begin
      LabelOne.Caption:= ExpandConstant('{cm:Welcome1}');
      LabelTwo.Show;
      LabelTwo.Caption:= ExpandConstant('{cm:Welcome2}');
      #ifdef MD5
        if not ContinueInstallMD5 then BtnSetVisibility(hMD5Btn, True);
      #endif
    end;

    wpSelectDir: begin
      LabelOne.Caption:= ExpandConstant('{cm:SelectDirLabel}');
      Total_Free_SpaceLabel.Show;
      NeedSpaceLabel.Show;
      CustomDirEdit.Show;
      BtnSetVisibility(hDirBrowseBtn, True);
      ImgSetVisibility(DirEditImg, True);
      GetFreeSpaceCaption(nil);
      DiskTimer:= SetTimer(WizardForm.Handle, 02, 10, CallBackAddr('SSOK'));
      #ifdef MD5
        ContinueInstallMD5:= True;
        SetTaskBarProgressValue(0);
      #endif
    end;

    wpSelectProgramGroup: begin
      KillTimer(WizardForm.Handle, DiskTimer);
      SelectTasksLabel1.Show;
      NoIconsLabel.Show;
      IconLabel.Show;
      LabelOne.Caption:= ExpandConstant('{cm:SelectComponentsLabel}');
      BtnSetVisibility(IconBtn, True);
      BtnSetVisibility(IconGroupBtn, True);
      TButton(WizardForm.FindComponent('NextButton')).Caption:= CustomMessage('ButtonInstall');
      #ifdef TaskCheckBox
        SelectTasksLabel2.Show;
        SoftLabel.Show;
        BtnSetVisibility(hSoftBtn, True);
      #endif
    end;

    wpInstalling: begin
      LabelOne.Caption:= ExpandConstant('{cm:InstallingLabel}');
      ISDoneShow();
      #ifdef Slides
        ExtrImageSL();
        TimerSL:= SetTimer(WizardForm.Handle, 0, {#SlidesTime}, CallBackAddr('SlideShow'));
      #endif
    end;

    wpFinished: begin
      BtnSetEnabled(Min, False);
      BtnSetEnabled(CloseBtn, False);
      LabelOne.Font.Color:= {#GoodFontColor};
      LabelOne.Caption:= ExpandConstant('{cm:FinishedHeadingLabel}');
      LabelTwo.Show;
      LabelTwo.Caption:= ExpandConstant('{cm:FinishedLabel}');
      #ifdef Slides
        KillTimer(WizardForm.Handle, TimerSL);
        ImgSetVisibility(AImg[CurrentImage], False);
      #endif
    end;
  end;

  if (CurPageID = wpFinished) and ISDoneError then
    begin
      BtnSetEnabled(Min, False);
      BtnSetEnabled(CloseBtn, False);
      LabelOne.Font.Color:= {#ErrFontColor};
      LabelOne.Caption:= ExpandConstant('{cm:ErrorFinishedHeadingLabel}');
      LabelTwo.Show;
      LabelTwo.Caption:= ExpandConstant('{cm:ErrorFinishedLabel}');
      #ifdef Slides
        KillTimer(WizardForm.Handle, TimerSL);
        ImgSetVisibility(AImg[CurrentImage], False);
      #endif
    end;

  ImgApplyChanges(WizardForm.Handle);
end;

Procedure CurStepChanged(CurStep: TSetupStep);
begin
  ISDoneUnPack(CurStep);
end;

Procedure DeinitializeSetup();
begin
  #ifdef CustomFont
    RemoveFontResource(ExpandConstant('{tmp}\{#FontName}.ttf'), $10, 0);
  #endif
  #ifdef Music
    StopMusic();
  #endif
  UnloadSkin();
  WizardForm.Free;
  WFButtonFont.Free;
  gdipShutdown;
end;