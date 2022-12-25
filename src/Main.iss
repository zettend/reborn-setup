;Необходимое место для установки в мегабайтах ;
  #define NeedSize                 "35308"
  #define NeedInstallSize          "5238"
;Установка и удаление программ в Панели управления (1048576 байтов = 1 МБ)
  #define UninlDisSiz              "5238"
;Необходимое количество ОЗУ для установки в мегабайтах ;
  #define NeedMem                  "512"

;Если нужнeн английский язык в установщике. Ксли не нужны - закомментировать;
 ;#define English

;Если нужны компоненты. Если не нужны - закомментировать;
  #define Components
    ;Выбор возможных сочетаний
    #ifdef Components
      ;Выбор текста
        #define Subtitles
      ;Выбор озвучки
        ;#define Voice
    #endif

;Кол-во чекбоксов для дополнительного ПО, доступно 2, 4(4 только если откл. Voice)
  #define TaskCheckBox "4"

;Название шрифта;
  #define Font "InstallFiles\fonts\Roboto-Light.ttf"
  #define FontName "'Roboto Light'"
  ;; Цвет шрифта;
    #define FontColor "$f1f0ec"

;Если нужно отображать полноценную иконку в Панели задач;
  #define TaskBar

//РАБОТА С IsDone.dll
;#define records
;Если нужен precomp - раскомментируем
  ;#define PrecompInside
;Если нужен srep(srep через arc.ini) - раскомментируем;
  ;#define SrepInside
;Ускорения распаковки .arc архивов
  ;#define facompress
;На будущее
  ;#define MSCInside
;Указываем версию precompа, которую использывали пры запаковке
  ;#define precomp "0.42"
;Если нужна распаковки .rar архивов. Если не нужны - закомментировать;
  ;#define unrar
;если нужно  распаковать  diff файлы, созданных xdelta3;
  ;#define XDelta
;Если нужна упаковки файлов в zip архивы. Если не нужны - закомментировать;
  ;#define PackZIP

;Hазвание и разширение архивов(доступно 20)
  #define Data1 "part1.bin"
  ;#define Data2 "part2.bin"
  ;#define Data3 "part3.bin"
  ;#define Data4 "part4.bin"
  ;#define Data5 "part5.bin"
  ;#define Data6 "part6.bin"
  ;#define Data7 "part7.bin"
  ;#define Data8 "part8.bin"
  ;#define Data9 "part9.bin"
  ;#define Data10 "part10.bin"
  ;#define Data11 "part11.bin"
  ;#define Data12 "part12.bin"
  ;#define Data13 "part13.bin"
  ;#define Data14 "part14.bin"
  ;#define Data15 "part15.bin"
  ;#define Data16 "part16.bin"
  ;#define Data17 "part17.bin"
  ;#define Data18 "part18.bin"
  ;#define Data19 "part19.bin"
  ;#define Data20 "part20.bin"

;Пароль для распаковки архивов
  #define Password "007007007007l"

;Проверка MD5-хеша файлов
;---До ума не доведено!11!!!
;Закоментировать, которые не используются
  ;#define MD5_1 "5C160487864C8C0B60CADF64449C7B53"
  ;#define MD5_2 "273a129e2f61c40881204c10364ea951"
  ;#define MD5_3 "c938c10d268cfc013fa6073e272522ad"
  ;#define MD5_4 ""
  ;#define MD5_5 ""
  ;#define MD5_6 ""
  ;#define MD5_7 ""
  ;#define MD5_8 ""

;Ссылка на кнопку "Купить в SteamBuy.com"                                  ;Не работает
  #define urlSteamBuy    "http://adf.ly/12368653/stalkercop-steambuy"      ;
;Ссылка на кнопку "Купить в steam или прочий сервис"                       ;Не работает
  #define urlLecensBuy   "http://adf.ly/12368653/stalkercop-steam"         ;
                                                                           ;Не работает
;Ссылка на сайт с инфой;
  #define urlInfo         "http://adf.ly/12368653/def0lt"

;Если "White_Mode" то значки "Свернуть, Закрыть, Инфо" белым, и наоборот
  #define Black_Mode
  ;#define White_Mode

;Название игры, использующееся установщиком
  #define GameName              "The Wicther 3: Wild Hunt 223"
;Название без символов(папка установки)
  #define GameNameDir           "The Wicther 3 Wild Hunt 223"
;Версия игры
  #define GameVersion           "1.6.0.2"
  ;;Название установочника
    #define InstallVersion        "Reborn Setup"
  ;;Версия файла в цифрах
    #define InstallVersion123     "2.0.0.0"
;Расположение exe файла игры (только название файла без каталогов!)
  #define ExeFile                "unins000.exe"
;Названия релиз-группы
  #define Group                  "by.dE0lT"
;Никнейм автора репака
  #define RePacker               "by.dE0lT"
;Путь к иконке инсталятора
  #define icon                   ""

;Путь до сохранений(закоментировать, если не надо)
  ;#define DirGameSave "('D:\The Wicther 3 Wild Hunt 223')"
  ;#define DirGameSave "('{userdocs}')+'\{#GameNameDir}'"

;Предупреждение о неработоспособности в Windows 32-х битной
  ;#define Win32
;Предупреждение о неработоспособности в Windows XP
  ;#define WinXP

[Setup]
AppName={#GameName}
DefaultDirName={code:NoSD}\{#GameNameDir}
DefaultGroupName={#Group}\{#GameNameDir}
InternalCompressLevel=ultra64
SolidCompression=true
Compression=lzma/ultra64
AppVerName={#GameName}
AppVersion={#GameVersion}
VersionInfoDescription={#GameName} v{#GameVersion} / RePack {#RePacker}
VersionInfoTextVersion={#InstallVersion}
VersionInfoVersion={#InstallVersion123}
VersionInfoCompany={#Group}
AppCopyright=© {#Group}
AppPublisher=RePack {#RePacker}
AppPublisherURL=http://rutracker.org/
AppSupportURL={#urlInfo}
SetupIconFile={#icon}
DisableReadyPage=yes
RawDataResource=font:{#Font}
AppComments={cm:AppComment}
UninstallDisplaySize={#UninlDisSiz}
UninstallDisplayIcon={app}\{#ExeFile}

#ifdef Components
[Types]
Name: full; Description: Full installation; Flags: iscustom

[Components]
Name: text;    Description: Язык субтитров; Types: full; Flags: fixed
  Name: text\rus; Description: Русский; Flags: exclusive; ExtraDiskSpaceRequired: 100000000
  Name: text\eng; Description: Английский; Flags: exclusive; ExtraDiskSpaceRequired: 200000000
Name: voice;   Description: Язык озвучки; Types: full; Flags: fixed
  Name: voice\rus; Description: Русский; Flags: exclusive; ExtraDiskSpaceRequired: 500000000
  Name: voice\eng; Description: Английский; Flags: exclusive; ExtraDiskSpaceRequired: 600000000
#endif

[Files]
//Source: "ru.ini"; DestDir: "{app}"; DestName: "steam_api.ini"; Check: RUSText;
//Source: "en.ini"; DestDir: "{app}"; DestName: "steam_api.ini"; Check: ENGText;

Source: {#Font};                                   Flags: dontcopy;
Source: dllFiles\b2p.dll;                          Flags: dontcopy;
Source: dllFiles\CallbackCtrl.dll;                 Flags: dontcopy;
Source: dllFiles\botva2.dll;                       Flags: dontcopy;
Source: InstallFiles\frame.png;                    Flags: dontcopy;
#ifdef Black_Mode
  Source: InstallFiles\close.png;                  Flags: dontcopy;
  Source: InstallFiles\min.png;                    Flags: dontcopy;
  Source: InstallFiles\info.png;                   Flags: dontcopy;
#endif
#ifdef White_Mode
  Source: InstallFiles\close_white.png;            Flags: dontcopy;
  Source: InstallFiles\min_white.png;              Flags: dontcopy;
  Source: InstallFiles\info_white.png;             Flags: dontcopy;
#endif
Source: InstallFiles\fon.png;                      Flags: dontcopy;
Source: InstallFiles\button.png;                   Flags: dontcopy;
Source: InstallFiles\dirbutton.png;                Flags: dontcopy;
Source: InstallFiles\direditimg.png;               Flags: dontcopy;
Source: InstallFiles\radiobuttons.png;             Flags: dontcopy;
Source: InstallFiles\checkbox.png;                 Flags: dontcopy;
Source: InstallFiles\ProgressBackground.png;       Flags: dontcopy;
Source: InstallFiles\ProgressImg.png;              Flags: dontcopy;

[Icons]
Name: "{group}\{cm:Run}";              Filename: "{app}\{#ExeFile}";     Check: IconGroup and CheckError;
Name: "{group}\{cm:Uninstall}";        Filename: "{uninstallexe}";       Check: IconGroup and CheckError;
Name: "{userdesktop}\{#GameNameDir}";  Filename: {app}\{#ExeFile};       WorkingDir: "{app}"; Check: IconDP;

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Run]
Filename: "{src}\redist\DirectX\DXSETUP.exe"; WorkingDir: "{src}\redist\DirectX"; Check:Soft1 and CheckError; Flags: waituntilterminated; BeforeInstall: Soft1Progress;
Filename: "{src}\redist\vcredist\vcredist_x86.exe"; WorkingDir: {src}\redist\vcredist; Parameters: /Q; Flags: waituntilterminated; Check: not IsWin64 and CheckError and Soft2; BeforeInstall: Soft2Progress;
Filename: "{src}\redist\vcredist\vcredist_x64.exe"; WorkingDir: {src}\redist\vcredist; Parameters: /Q; Flags: waituntilterminated; Check: IsWin64 and CheckError and Soft2; BeforeInstall: Soft2Progress;

//Примеры софта
//Filename: "{#RedistFolder}\{#GameForWindows}"; Parameters: "/quiet /norestart"; WorkingDir: "{#RedistFolder}"; Flags: shellexec runminimized waituntilterminated; Check: DpoChecks;
//Filename: "{#RedistFolder}\{#DirectX}"; WorkingDir: "{#RedistFolder}"; Check: CheckError and DpoChecks;
//Filename: "{#RedistFolder}\{#VCx86}"; WorkingDir: {#RedistFolder}; Parameters: /Q; Flags: waituntilterminated; Check: not IsWin64 and CheckError and DpoChecks;
//Filename: "{#RedistFolder}\{#VCx64}"; WorkingDir: {#RedistFolder}; Parameters: /Q; Flags: waituntilterminated; Check: IsWin64 and CheckError and DpoChecks;
//Filename: "{#RedistFolder}\{#OpenAL}"; WorkingDir: {#RedistFolder}; Parameters: /q/s; Flags: waituntilterminated; Check: CheckError and DpoChecks;
//Filename: "{#RedistFolder}\{#Punkbuster}"; WorkingDir: {#RedistFolder}; Parameters: /i --no-prompts; Flags: waituntilterminated; Check: CheckError and DpoChecks;
//Filename: "{#RedistFolder}\{#Rapture3D}"; WorkingDir: {#RedistFolder}; Parameters: /silent; Flags: waituntilterminated; Check: CheckError and DpoChecks;
//Filename: "{#RedistFolder}\{#SocialClub}"; WorkingDir: {#RedistFolder}; Flags: waituntilterminated; Check: CheckError and DpoChecks;

[UninstallDelete]
Type: FilesAndOrDirs; Name: {app}

[Code]
#ifdef UNICODE
    #define A "W"
#else
    #define A "A"
#endif

const
  FR_PRIVATE = $10;
  radius = 9;
  #ifdef Components
    LanguagetextButtonCount  = 2;
    LanguagevoiceButtonCount  = 2;
  #endif

var
  DirEditImg: Longint;
  hCancelBtn, hNextBtn, hBackBtn, hDirBrowseBtn, InfoBtn, Min, CloseBtn, SiteRGBtn, hLecensBuyBtn , hSteamBuyBtn, IconGroupBtn, IconBtn, hSoftBtn1, hSoftBtn2, hSoftBtn3, hSoftBtn4: HWND;
  WFButtonFont, BuyButtonFont, WindButtonFont, SiteRgButtonFont: TFont;
  UpdBtn: TTimer;
  LabelOne, LabelTwo, SelectTasksLabel, IconLabel, Soft1Label, Soft2Label, Soft3Label, Soft4Label, StatusLabel, InstallingLabel, NoIconsLabel: TLabel;
  FreeSpaceLabel, NeedSpacelabel: TLabel;
  FreeMB, TotalMB: Cardinal;
  #ifdef Components
  TextLabel, VoiceLabel, RUSTextLabel, ENGTextLabel, RUSVoiceLabel, ENGVoiceLabel: TLabel;
  LanguagetextButton: array [1..LanguagetextButtonCount] of HWND;
  LanguagevoiceButton: array [1..LanguagevoiceButtonCount] of HWND;
  #endif
  b2p:Boolean;

#ifdef TaskBar
  #include "Modules\Win6TaskBar.iss"
  #include "Modules\Win7TBP v1.0.iss"
#endif
#include "Modules\Messages.iss"
#include "Modules\botva2.iss"
#include "Modules\ProgressBar.iss"
#include "Modules\IsDone.iss"
#include "Modules\Header.iss"
#include "Modules\Disk.iss"
#ifdef MD5_1
 #include "Modules\MD5.iss"
#endif

function AddFontResource(lpszFilename: String; fl, pdv: DWORD): Integer; external 'AddFontResourceEx{#A}@gdi32.dll stdcall';
function RemoveFontResource(lpFileName: String; fl, pdv: DWORD): BOOL; external 'RemoveFontResourceEx{#A}@gdi32.dll stdcall';
function SetWindowPos(hWnd: HWND; hWndInsertAfter: HWND; X, Y, cx, cy: Integer; uFlags: UINT): BOOL; external 'SetWindowPos@user32.dll stdcall';
function SetClassLong(hWnd: HWND; Index, NewLong: Longint): Longint; external 'SetClassLongA@user32 stdcall';

function CheckError: Boolean;
begin
  Result:= not ISDoneError;
end;

procedure ShapeForm(aForm: TForm; edgeSize: integer);
var
  FormRegion: HWND;
begin
  FormRegion:= CreateRoundRectRgn(0, 0, aForm.Width, aForm.Height, edgeSize, edgeSize);
  SetWindowRgn(aForm.Handle, FormRegion, True);
end;

procedure FrameMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  WizardForm.SetFocus;
  ReleaseCapture;
  SendMessage(WizardForm.Handle,$0112,$F012,0);
end;

#ifdef Win32
function IsNotWin64(): Boolean;
begin
  if IsWin64 then
  begin
    Result := True;
  end else
    MsgBox(ExpandConstant('{cm:Win32Error}'), mbError, MB_OK);
    Result := False;
end;
#endif

#ifdef WinXP
function IsNotWinXP(): Boolean;
begin
  if (GetWindowsVersion shr 24) = 5 then
  begin
  MsgBox(ExpandConstant('{cm:WinXPError}'), mbError, MB_OK);  
    Result := False;
  end else
    Result := True;
end;
#endif

function InitializeSetup:boolean;
begin
  #ifdef WinXP
    Result := IsNotWinXP;
  #endif
  #ifdef Win32
    Result := IsNotWin64;
  #endif
  if not FileExists(ExpandConstant('{tmp}\b2p.dll')) then ExtractTemporaryFile('b2p.dll');
  if not FileExists(ExpandConstant('{tmp}\botva2.dll')) then ExtractTemporaryFile('botva2.dll');
  if not FileExists(ExpandConstant('{tmp}\CallbackCtrl.dll')) then ExtractTemporaryFile('CallbackCtrl.dll');
  #ifdef MD5_1
  MD5Check;
  if MD5Error = True then begin
    if MsgBox(ExpandConstant('{cm:MD5Error}'), mbError, MB_YESNO) = IDYES then Result:=True;
  end else begin
    Result := False;
  end;
  #else
    Result:= True;
 #endif
end;

procedure CreateWizardEvent;
begin
  with TLabel.Create(WizardForm) do begin
    Parent:=WizardForm;
    AutoSize:=False;
    Left:=0;
    Top:=0;
    Transparent:=true;
    WordWrap:=true;
    Width:=ScaleX(1000);
    Height:=ScaleY(422);
    OnMouseDown:=@FrameMouseDown;
  end;
end;

//************************************************ [Начало - Текстуры кнопок] ***************************************************//
procedure SetStateNewButtons;
begin
  with WizardForm.BackButton do begin
    BtnSetText(hBackBtn,PAnsiChar(Caption));
    BtnSetVisibility(hBackBtn,Visible);
    BtnSetEnabled(hBackBtn,Enabled);
    BtnRefresh(hBackBtn);
  end;

  with WizardForm.NextButton do begin
    BtnSetText(hNextBtn,PAnsiChar(Caption));
    BtnSetVisibility(hNextBtn,Visible);
    BtnSetEnabled(hNextBtn,Enabled);
    BtnRefresh(hNextBtn);
  end;

  with WizardForm.CancelButton do begin
    BtnSetText(hCancelBtn,PAnsiChar(ExpandConstant('{cm:Exit}')));
    BtnSetVisibility(hCancelBtn,Visible);
    BtnSetEnabled(hCancelBtn,Enabled);
    BtnRefresh(hCancelBtn);
  end;

end;

procedure TimerRefreshBtn(S: TObject);
begin
  BtnRefresh(hBackBtn);
  BtnRefresh(hNextBtn);
  BtnRefresh(hCancelBtn);
  BtnRefresh(hDirBrowseBtn);
end;

procedure WizardFormBtnClick(hBtn:HWND);
var
  Btn:TButton;
begin
  case hBtn of
    hCancelBtn: Btn:=WizardForm.CancelButton;
    hNextBtn: Btn:=WizardForm.NextButton;
    hBackBtn: Btn:=WizardForm.BackButton;
    hDirBrowseBtn: Btn:=WizardForm.DirBrowseButton;
  end;
  Btn.OnClick(Btn);
  SetStateNewButtons;
  BtnRefresh(hBtn);
end;

procedure MinimizeBtnClick(h:HWND);
begin
  WizardForm.SetFocus;
  ReleaseCapture;
  SendMessage(WizardForm.Handle,$112,61472,0);
end;

procedure InfoBtnClick(h:HWND);
  var
    ErrorCode: Integer;
  begin
    ShellExec('open', '{#urlInfo}', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure LecensBuyBtnClick(h:HWND);
  var
    ErrorCode: Integer;
  begin
    ShellExec('open', '{#urlLecensBuy}', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure SteamBuyBtnClick(h:HWND);
  var
    ErrorCode: Integer;
  begin
    ShellExec('open', '{#urlSteamBuy}', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;
 
procedure CancelBtnClick(h:HWND);
  begin
    WizardForm.CancelButton.OnClick(WizardForm.CancelButton);
end;

procedure ButtonsTextures;
begin
  WFButtonFont:=TFont.Create;
  WFButtonFont.Name:={#FontName};
  WFButtonFont.Size:=9;

  WindButtonFont:=TFont.Create;
  WindButtonFont.Name:={#FontName};
  WindButtonFont.Size:=11;

  with WizardForm.NextButton do begin
    hNextBtn:=BtnCreate(WizardForm.Handle, ScaleX(856), ScaleY(472), ScaleX(130),ScaleY(40), ExpandConstant('button.png'), 1, False);
    BtnSetEvent(hNextBtn,BtnClickEventID,WrapBtnCallback(@WizardFormBtnClick,1));
    BtnSetFont(hNextBtn,WFButtonFont.Handle);
    BtnSetCursor(hNextBtn,GetSysCursorHandle(32649));
    BtnSetFontColor(hNextBtn, {#FontColor}, $FFFFFF, $FFFFFF, $FFFFFF);
    Width:=0;
    Height:=0;
  end;

  with WizardForm.BackButton do begin
    hBackBtn:=BtnCreate(WizardForm.Handle, ScaleX(717), ScaleY(472), ScaleX(130),ScaleY(40), ExpandConstant('button.png'), 1, False);
    BtnSetEvent(hBackBtn,BtnClickEventID,WrapBtnCallback(@WizardFormBtnClick,1));
    BtnSetFont(hBackBtn,WFButtonFont.Handle);
    BtnSetCursor(hBackBtn,GetSysCursorHandle(32649));
    BtnSetFontColor(hBackBtn, {#FontColor}, $FFFFFF, $FFFFFF, $FFFFFF);
    Width:=0;
    Height:=0;
  end;

  with WizardForm.CancelButton do begin
    hCancelBtn:=BtnCreate(WizardForm.Handle, ScaleX(1004), ScaleY(337), ScaleX(130),ScaleY(40), ExpandConstant('button.png'), 1, False);
    BtnSetEvent(hCancelBtn,BtnClickEventID,WrapBtnCallback(@WizardFormBtnClick,1));
    BtnSetCursor(hCancelBtn,GetSysCursorHandle(32649));
    BtnSetText(hCancelBtn,'{cm:exit}')
    Width:=0;
    Height:=0;
  end;

  with WizardForm.DirBrowseButton do begin
    hDirBrowseBtn:=BtnCreate(WizardForm.Handle, ScaleX(380), ScaleY(482), ScaleX(30),ScaleY(30), ExpandConstant('dirbutton.png'), 1, False);
    BtnSetEvent(hDirBrowseBtn,BtnClickEventID,WrapBtnCallback(@WizardFormBtnClick,1));
    BtnSetCursor(hDirBrowseBtn,GetSysCursorHandle(32649));
    Width:=0;
    Height:=0;
  end;

  #ifdef Black_Mode
    InfoBtn:=BtnCreate(WizardForm.Handle, ScaleX(920), ScaleY(14), ScaleX(6), ScaleY(12), ExpandConstant('info.png'), 1, false);
    BtnSetFont(InfoBtn,WindButtonFont.Handle);
    BtnSetEvent(InfoBtn, BtnClickEventID,WrapBtnCallback(@InfoBtnClick,1));
    BtnSetCursor(InfoBtn,GetSysCursorHandle(32649));

    Min:=BtnCreate(WizardForm.Handle, ScaleX(942), ScaleY(14), ScaleX(12), ScaleY(12), ExpandConstant('min.png'), 1, false);
    BtnSetFont(Min,WindButtonFont.Handle);
    BtnSetEvent(Min, BtnClickEventID, WrapBtnCallback(@MinimizeBtnClick, 1));
    BtnSetCursor(Min,GetSysCursorHandle(32649));

    CloseBtn:=BtnCreate(WizardForm.Handle, ScaleX(970), ScaleY(14), ScaleX(12), ScaleY(12), ExpandConstant('close.png'), 1, false);
    BtnSetFont(CloseBtn,WindButtonFont.Handle);
    BtnSetEvent(CloseBtn, BtnClickEventID,WrapBtnCallback(@CancelBtnClick,1));
    BtnSetCursor(CloseBtn,GetSysCursorHandle(32649));
  #endif

  #ifdef White_Mode
    InfoBtn:=BtnCreate(WizardForm.Handle, ScaleX(920), ScaleY(14), ScaleX(6), ScaleY(12), ExpandConstant('info_white.png'), 1, false);
    BtnSetFont(InfoBtn,WindButtonFont.Handle);
    BtnSetEvent(InfoBtn, BtnClickEventID,WrapBtnCallback(@InfoBtnClick,1));
    BtnSetCursor(InfoBtn,GetSysCursorHandle(32649));

    Min:=BtnCreate(WizardForm.Handle, ScaleX(942), ScaleY(14), ScaleX(12), ScaleY(12), ExpandConstant('min_white.png'), 1, false);
    BtnSetFont(Min,WindButtonFont.Handle);
    BtnSetEvent(Min, BtnClickEventID, WrapBtnCallback(@MinimizeBtnClick, 1));
    BtnSetCursor(Min,GetSysCursorHandle(32649));

    CloseBtn:=BtnCreate(WizardForm.Handle, ScaleX(970), ScaleY(14), ScaleX(12), ScaleY(12), ExpandConstant('close_white.png'), 1, false);
    BtnSetFont(CloseBtn,WindButtonFont.Handle);
    BtnSetEvent(CloseBtn, BtnClickEventID,WrapBtnCallback(@CancelBtnClick,1));
    BtnSetCursor(CloseBtn,GetSysCursorHandle(32649));
  #endif
end;
//************************************************ [Конец - Текстуры кнопок] ***************************************************//

//************************************************[Начало - Проверка места на диске]*************************************************************//
function NumToStr(Float: Extended): String;
begin
  Result:= format('%.2n', [Float]); StringChange(Result, ',', '.');
  while (Result[Length(Result)] = '0')or((Result[Length(Result)] = '.')and(Pos('.', Result) > 0)) do
    SetLength(Result, Length(Result)-1);
end;

function MbOrTb(Float: Extended): String;
begin
  if Float < 1024 then Result:= NumToStr(Float)+' Мб' else
    if Float/1024 < 1024 then Result:= NumToStr(Float/1024)+' Гб' else
      Result:= NumToStr(Float/(1024*1024))+' Тб';
end;

procedure ObjectFunc(Sender: TObject);
var Drive: String;
begin
  Drive:= ExtractFileDrive(WizardForm.DirEdit.Text);
  GetSpaceOnDisk(Drive, True, FreeMB, TotalMB);
  FreeSpaceLabel.Caption:= ExpandConstant('{cm:FreeSpace} ') +MbOrTb(FreeMB)+' ('+IntToStr(round(FreeMB*100/TotalMB))+'%)';
  NeedSpaceLabel.Caption:= ExpandConstant('{cm:NeedSpace} ') +MbOrTb({#NeedSize});
  WizardForm.NextButton.Enabled:= (FreeMB>{#NeedInstallSize})and(FreeMB>{#NeedSize})  ;
  BtnSetEnabled(hNextBtn, true);
  if (FreeMB>{#NeedInstallSize})and(FreeMB>{#NeedSize}) then FreeSpaceLabel.Font.Color:={#FontColor} else FreeSpaceLabel.Font.Color:=$3c4ce7;
end;

procedure NeedSpace;
begin
  FreeSpaceLabel:= TLabel.Create(WizardForm);
  FreeSpaceLabel.SetBounds(ScaleX(270), ScaleY(452), ScaleX(200), ScaleY(13))
  FreeSpaceLabel.Parent:= WizardForm;
  FreeSpaceLabel.Font.Name:={#FontName};
  FreeSpaceLabel.Font.Size:= 9;
  FreeSpaceLabel.Font.Color:={#FontColor};
  FreeSpaceLabel.Transparent:=true;

  NeedSpaceLabel:= TLabel.Create(WizardForm);
  NeedSpaceLabel.SetBounds(ScaleX(270), ScaleY(470), ScaleX(200), ScaleY(13))
  NeedSpaceLabel.Parent:= WizardForm;
  NeedSpaceLabel.Font.Name:={#FontName};
  NeedSpaceLabel.Font.Size:= 9;
  NeedSpaceLabel.Font.Color:={#FontColor};
  NeedSpaceLabel.Transparent:=true;

  WizardForm.DirEdit.OnChange:= @ObjectFunc;
  WizardForm.DirEdit.Text:= WizardForm.DirEdit.Text + #0;
end;
//************************************************[Конец - Проверка места на диске]*************************************************************//

//************************************************ [Начало - Загрузка изображений и подготовка визарда] ****************************************//
procedure CreateWizardImg;
begin
  with WizardForm do begin
    Bevel.Hide;
    InnerNotebook.Hide;
    OuterNotebook.Hide;
    ClientWidth:=ScaleX(994);
    ClientHeight:=ScaleY(493);
    BorderStyle := bsNone;
    Bevel.Hide;
    Center;
  end;

  ImgLoad(WizardForm.handle, ExpandConstant('fon.png'), ScaleX(0), ScaleY(0), ScaleX(1000), ScaleY(422), True, True);
  ImgLoad(WizardForm.handle, ExpandConstant('frame.png'), ScaleX(0), ScaleY(422), ScaleX(1000), ScaleY(100), True, True);
  DirEditImg:= ImgLoad(WizardForm.handle, ExpandConstant('direditimg.png'), ScaleX(21), ScaleY(511), ScaleX(333), ScaleY(1), True, True);

  //SetClassLong(WizardForm.Handle, (-26), GetWindowLong(WizardForm.Handle, (-26)) or $00020000);
end;
//************************************************ [Конец - Загрузка изображений и подготовка визарда] *******************************************//

//************************************************ [Начало - Создание лебелов] ***************************************************//
procedure CreateLabel;
 begin
  //=============== [Начало - Main] ===============\\
  LabelOne:=TLabel.Create(WizardForm);
  with LabelOne do begin
    Left:= ScaleX(15);
    Top:= ScaleY(434);;
    Width:= ScaleX(700);
    Height:= ScaleY(70);
    AutoSize:= false;
    WordWrap:= true;
    Font.Name:={#FontName};
    Font.Size:= 10;
    Transparent:= true;
    Font.Color:={#FontColor};
    Parent:= WizardForm;
  end;

  LabelTwo:=TLabel.Create(WizardForm);
  with LabelTwo do begin
    Left:= ScaleX(21);
    Top:= ScaleY(449);;
    Width:= ScaleX(700);
    Height:= ScaleY(70);
    AutoSize:= false;
    WordWrap:= true;
    Font.Name:={#FontName};
    Font.Size:= 10;
    Transparent:= true;
    Font.Color:={#FontColor};
    Parent:= WizardForm;
  end;
  //=============== [Конец - Main] ===============\\

  //=============== [Начало - SelectDirPage] ===============\\
  with WizardForm.DirEdit do begin
    Parent:= WizardForm;
    Left:= ScaleX(31);
    Top:= ScaleY(490);
    BorderStyle:= bsNone;
    Color:= $272727;
    Font.Name:={#FontName};
    Font.Size:= 10;
    Font.Color:={#FontColor};
    Width:= ScaleX(300);
    Height:= ScaleY(16);
    OnChange:= @ObjectFunc;
  end;

  NoIconsLabel:=TLabel.Create(WizardForm);
  with NoIconsLabel do begin
    Left:= ScaleX(38);
    Top:= ScaleY(470);
    Width:= ScaleX(280);
    Height:= ScaleY(13);
    AutoSize:= false;
    WordWrap:= true;
    Font.Name:={#FontName};
    Font.Size:= 9;
    Transparent:= true;
    Font.Color:={#FontColor};
    Parent:= WizardForm;
    Caption:= ExpandConstant('{cm:NoIconsCheck}');
    OnClick:= @IconGroupLabelClick;
  end;

  IconGroupBtn:=BtnCreate(WizardForm.Handle,ScaleX(21),ScaleY(468), ScaleX(13),ScaleY(13), ExpandConstant('checkbox.png'), 1, true);
  BtnSetEvent(IconGroupBtn,BtnClickEventID,WrapBtnCallback(@IconGroupClick,1));
  BtnSetCursor(IconGroupBtn,GetSysCursorHandle(32649));
  BtnSetChecked(IconGroupBtn, True);

  IconLabel:=TLabel.Create(WizardForm);
  with IconLabel do begin
    Left:= ScaleX(38);
    Top:= ScaleY(452);
    Width:= ScaleX(280);
    Height:= ScaleY(13);
    AutoSize:= false;
    WordWrap:= true;
    Font.Name:={#FontName};
    Font.Size:= 9;
    Transparent:= true;
    Font.Color:={#FontColor};
    Parent:= WizardForm;
    Caption:= ExpandConstant('{cm:Icon}');
    OnClick:= @IconLabelClick;
  end;

  IconBtn:=BtnCreate(WizardForm.Handle,ScaleX(21),ScaleY(450), ScaleX(13),ScaleY(13), ExpandConstant('checkbox.png'), 1, true);
  BtnSetEvent(IconBtn,BtnClickEventID,WrapBtnCallback(@IconClick,1));
  BtnSetCursor(IconBtn,GetSysCursorHandle(32649));
  BtnSetChecked(IconBtn, True);

  //=============== [Конец - SelectDirPage] ===============\\

  #ifdef Components
  //=============== [Начало - SelectComponentsPage] ================\\
    #ifdef Subtitles
      TextLabel:= TLabel.Create(WizardForm);
      with TextLabel do begin
        Left:= 21;
        Top:= 449;
        Width:= 150;
        Height:= 74;
        AutoSize:= false;
        Transparent:= true;
        Font.Name:={#FontName};
        Font.Size:= 10;
        Font.Color:={#FontColor};
        WordWrap:= true;
        Parent:= WizardForm;
        OnClick:= @Languagetext1LabelClick;
        Caption:= ExpandConstant('{cm:Text1}');
      end;

      RUSTextLabel:= TLabel.Create(WizardForm);
      with RUSTextLabel do begin
        Left:= 36;
        Top:= 474;
        Width:= 150;
        Height:= 20;
        AutoSize:= false;
        Transparent:= true;
        WordWrap:= true;
        Font.Name:={#FontName};
        Font.Size:= 9;
        Font.Color:={#FontColor};
        Parent:= WizardForm;
        OnClick:= @Languagetext1LabelClick;
        Caption:=ExpandConstant('{cm:Text2}');
      end;

      ENGTextLabel:= TLabel.Create(WizardForm);
      with ENGTextLabel do begin
        Left:= 36;
        Top:= 491;
        Width:= 150;
        Height:= 20;
        AutoSize:= false;
        Transparent:= true;
        Font.Name:={#FontName};
        Font.Size:= 9;
        Font.Color:={#FontColor};
        WordWrap:= true;
        Parent:= WizardForm;
        OnClick:= @Languagetext2LabelClick;
        Caption:= ExpandConstant('{cm:Text3}');
      end;

      LanguagetextButton[1]:=BtnCreate(WizardForm.Handle,21,473,13,13,ExpandConstant('{tmp}\radiobuttons.png'),1,True);
      BtnSetEvent(LanguagetextButton[1],BtnClickEventID,WrapBtnCallback(@SelectLanguagetext,1));
      BtnSetCursor(LanguagetextButton[1],GetSysCursorHandle(32649));
      LanguagetextButton[2]:=BtnCreate(WizardForm.Handle,21,491,13,13,ExpandConstant('{tmp}\radiobuttons.png'),1,True);
      BtnSetEvent(LanguagetextButton[2],BtnClickEventID,WrapBtnCallback(@SelectLanguagetext,1));
      BtnSetCursor(LanguagetextButton[2],GetSysCursorHandle(32649));
      BtnSetChecked(LanguagetextButton[1],True);
    #endif

    #ifdef Voice
      VoiceLabel:= TLabel.Create(WizardForm);
      with VoiceLabel do begin
        Left:= 199;
        Top:= 449;
        Width:= 150;
        Height:= 74;
        AutoSize:= false;
        Font.Name:={#FontName};
        Font.Size:= 10;
        Font.Color:={#FontColor};
        Transparent:= true;
        WordWrap:= true;
        Parent:= WizardForm;
        Caption:= ExpandConstant('{cm:Text4}');
      end;

      RUSVoiceLabel:= TLabel.Create(WizardForm);
      with RUSVoiceLabel do begin
        Left:= 214;
        Top:= 474;
        Width:= 150;
        Height:= 20;
        AutoSize:= false;
        Transparent:= true;
        Font.Name:={#FontName};
        Font.Size:= 9;
        Font.Color:={#FontColor};
        WordWrap:= true;
        Parent:= WizardForm;
        OnClick:= @LanguageVoice1LabelClick;
        Caption:= ExpandConstant('{cm:Text2}');
      end;

      ENGVoiceLabel:= TLabel.Create(WizardForm);
      with ENGVoiceLabel do begin
        Left:= 214;
        Top:= 491;
        Width:= 150;
        Height:= 20;
        AutoSize:= false;
        Transparent:= true;
        Font.Name:={#FontName};
        Font.Size:= 9;
        Font.Color:={#FontColor};
        WordWrap:= true;
        Parent:= WizardForm;
        OnClick:= @LanguageVoice2LabelClick;
        Caption:=ExpandConstant('{cm:Text3}');
      end;

      LanguagevoiceButton[1]:=BtnCreate(WizardForm.Handle,199,473,13,13,ExpandConstant('{tmp}\radiobuttons.png'),1,True);
      BtnSetEvent(LanguagevoiceButton[1],BtnClickEventID,WrapBtnCallback(@SelectLanguagevoice,1));
      BtnSetCursor(LanguagevoiceButton[1],GetSysCursorHandle(32649));
      LanguagevoiceButton[2]:=BtnCreate(WizardForm.Handle,199,491,13,13,ExpandConstant('{tmp}\radiobuttons.png'),1,True);
      BtnSetEvent(LanguagevoiceButton[2],BtnClickEventID,WrapBtnCallback(@SelectLanguagevoice,1));
      BtnSetCursor(LanguagevoiceButton[2],GetSysCursorHandle(32649));
      BtnSetChecked(LanguagevoiceButton[1],True);
    #endif

    #ifdef TaskCheckBox
      #if TaskCheckBox == "4"
        SelectTasksLabel:=TLabel.Create(WizardForm);
        with SelectTasksLabel do begin
          Left:= ScaleX(199);
          Top:= ScaleY(449);
          Width:= ScaleX(450);
          Height:= ScaleY(200);
          AutoSize:= false;
          WordWrap:= true;
          Font.Name:={#FontName};
          Font.Size:= 10;
          Font.Color:={#FontColor};
          Transparent:= true;
          Parent:= WizardForm;
          Caption:= ExpandConstant('{cm:SelectTasks}');
        end;

        hSoftBtn1:=BtnCreate(WizardForm.Handle,199,473,13,13,ExpandConstant('{tmp}\checkbox.png'),1,True);
        BtnSetEvent(hSoftBtn1,BtnClickEventID,WrapBtnCallback(@Soft1Click,1));
        BtnSetCursor(hSoftBtn1,GetSysCursorHandle(32649));
        BtnSetChecked(hSoftBtn1,True);

        hSoftBtn2:=BtnCreate(WizardForm.Handle,199,491,13,13,ExpandConstant('{tmp}\checkbox.png'),1,True);
        BtnSetEvent(hSoftBtn2,BtnClickEventID,WrapBtnCallback(@Soft2Click,1));
        BtnSetCursor(hSoftBtn2,GetSysCursorHandle(32649));
        BtnSetChecked(hSoftBtn2,True);

        hSoftBtn3:=BtnCreate(WizardForm.Handle,355,473,13,13,ExpandConstant('{tmp}\checkbox.png'),1,True);
        BtnSetEvent(hSoftBtn3,BtnClickEventID,WrapBtnCallback(@Soft3Click,1));
        BtnSetCursor(hSoftBtn3,GetSysCursorHandle(32649));
        BtnSetChecked(hSoftBtn3,True);

        hSoftBtn4:=BtnCreate(WizardForm.Handle,355,491,13,13,ExpandConstant('{tmp}\checkbox.png'),1,True);
        BtnSetEvent(hSoftBtn4,BtnClickEventID,WrapBtnCallback(@Soft4Click,1));
        BtnSetCursor(hSoftBtn4,GetSysCursorHandle(32649));
        BtnSetChecked(hSoftBtn4,True);

        Soft1Label:= TLabel.Create(WizardForm);
        with Soft1Label do begin
          Left:= 214;
          Top:= 474;
          Width:= 201;
          Height:= 20;
          AutoSize:= false;
          Font.Name:={#FontName};
          Font.Size:= 9;
          Transparent:= true;
          Font.Color:={#FontColor};
          WordWrap:= true;
          Parent:= WizardForm;
          OnClick:= @Soft1LabelClick;
          Caption:=ExpandConstant('{cm:Soft1}');
        end;

        Soft2Label:= TLabel.Create(WizardForm);
        with Soft2Label do begin
          Left:= 214;
          Top:= 491;
          Width:= 200;
          Height:= 20;
          AutoSize:= false;
          Font.Name:={#FontName};
          Font.Size:= 9;
          Transparent:= true;
          Font.Color:={#FontColor};
          WordWrap:= true;
          Parent:= WizardForm;
          OnClick:= @Soft2LabelClick;
          Caption:=ExpandConstant('{cm:Soft2}');
        end;

        Soft3Label:= TLabel.Create(WizardForm);
        with Soft3Label do begin
          Left:= 370;
          Top:= 473;
          Width:= 201;
          Height:= 20;
          AutoSize:= false;
          Font.Name:={#FontName};
          Font.Size:= 9;
          Transparent:= true;
          Font.Color:={#FontColor};
          WordWrap:= true;
          Parent:= WizardForm;
          OnClick:= @Soft3LabelClick;
          Caption:=ExpandConstant('{cm:Soft3}');
        end;

        Soft4Label:= TLabel.Create(WizardForm);
        with Soft4Label do begin
          Left:= 370;
          Top:= 491;
          Width:= 200;
          Height:= 20;
          AutoSize:= false;
          Font.Name:={#FontName};
          Font.Size:= 9;
          Transparent:= true;
          Font.Color:={#FontColor};
          WordWrap:= true;
          Parent:= WizardForm;
          OnClick:= @Soft4LabelClick;
          Caption:=ExpandConstant('{cm:Soft4}');
        end;
      #else
      #if TaskCheckBox == "2"
        SelectTasksLabel:=TLabel.Create(WizardForm);
        with SelectTasksLabel do begin
          Left:= ScaleX(355);
          Top:= ScaleY(449);
          Width:= ScaleX(450);
          Height:= ScaleY(200);
          AutoSize:= false;
          WordWrap:= true;
          Font.Name:={#FontName};
          Font.Size:= 10;
          Font.Color:={#FontColor};
          Transparent:= true;
          Parent:= WizardForm;
          Caption:= ExpandConstant('{cm:SelectTasks}');
        end;

        hSoftBtn1:=BtnCreate(WizardForm.Handle,355,473,13,13,ExpandConstant('{tmp}\checkbox.png'),1,True);
        BtnSetEvent(hSoftBtn1,BtnClickEventID,WrapBtnCallback(@Soft1Click,1));
        BtnSetCursor(hSoftBtn1,GetSysCursorHandle(32649));
        BtnSetChecked(hSoftBtn1,True);

        hSoftBtn2:=BtnCreate(WizardForm.Handle,355,491,13,13,ExpandConstant('{tmp}\checkbox.png'),1,True);
        BtnSetEvent(hSoftBtn2,BtnClickEventID,WrapBtnCallback(@Soft2Click,1));
        BtnSetCursor(hSoftBtn2,GetSysCursorHandle(32649));
        BtnSetChecked(hSoftBtn2,True);

        Soft1Label:= TLabel.Create(WizardForm);
        with Soft1Label do begin
          Left:= 370;
          Top:= 473;
          Width:= 201;
          Height:= 20;
          AutoSize:= false;
          Font.Name:={#FontName};
          Font.Size:= 9;
          Transparent:= true;
          Font.Color:={#FontColor};
          WordWrap:= true;
          Parent:= WizardForm;
          OnClick:= @Soft1LabelClick;
          Caption:=ExpandConstant('{cm:Soft1}');
        end;

        Soft2Label:= TLabel.Create(WizardForm);
        with Soft2Label do begin
          Left:= 370;
          Top:= 491;
          Width:= 200;
          Height:= 20;
          AutoSize:= false;
          Font.Name:={#FontName};
          Font.Size:= 9;
          Transparent:= true;
          Font.Color:={#FontColor};
          WordWrap:= true;
          Parent:= WizardForm;
          OnClick:= @Soft2LabelClick;
          Caption:=ExpandConstant('{cm:Soft2}');
        end;
      #endif
    #endif
  #endif

  //=============== [Конец - SelectComponentsPage] ===============\\
  #endif

  //=============== [Начало - InstallingPage] ===============\\

  IsDoneAddComponents

  StatusLabel:= TLabel.Create(WizardForm);
  with StatusLabel do begin
    Parent := WizardForm;
    AutoSize:=True;
    Transparent := True;
    SetBounds(ScaleX(21), ScaleY(458), ScaleX(0), ScaleY(0));
    Font.Name:={#FontName};
    Font.Size:= 10
    Font.Color:={#FontColor};
  end;

  LabelCurrFileName:= TLabel.Create(WizardForm);
  with LabelCurrFileName do begin
    Parent := WizardForm;
    AutoSize:=True;
    Transparent := True;
    SetBounds(ScaleX(21), ScaleY(472), ScaleX(0), ScaleY(0));
    Font.Name:={#FontName};
    Font.Size:= 10
    Font.Color:={#FontColor};
  end;

  //=============== [Конец - InstallingPage] ===============\\
  end;
//************************************************ [Конец - Создание лебелов] ***************************************************//

procedure InitializeWizard;
  begin
      if not FontExists({#FontName}) then
      begin
          ExtractTemporaryFile('Roboto-Light.ttf');
          AddFontResource(ExpandConstant('{tmp}\Roboto-Light.ttf'), FR_PRIVATE, 0);
      end;
      WizardForm.Font.Name := {#FontName};
      CreateWizardEvent;
      CreateWizardImg;
      CreateLabel;
      ButtonsTextures;
      NeedSpace;
      #ifdef TaskBar
      init_taskbar;
      InitWin7TaskBar;
      #endif
      b2p:= true;
  end;

procedure HideComponents;
begin
    LabelOne.Hide;
    LabelTwo.Hide;
    BtnSetVisibility(hDirBrowseBtn, false);
    BtnSetVisibility(IconGroupBtn, False);
    ImgSetVisibility(DirEditImg, false);
    WizardForm.DirEdit.Hide;
    NoIconsLabel.Hide;
    FreeSpaceLabel.Hide;
    NeedSpaceLabel.Hide;
  #ifdef Components
    WizardForm.ComponentsList.Hide;
    #ifdef Subtitles
      TextLabel.hide;
      RUSTextLabel.hide;
      ENGTextLabel.hide;
      BtnSetVisibility(LanguagetextButton[1], False);
      BtnSetVisibility(LanguagetextButton[2], False);
    #endif
    #ifdef Voice
      VoiceLabel.hide;
      RUSVoiceLabel.hide;
      ENGVoiceLabel.hide;
      BtnSetVisibility(LanguagevoiceButton[1], False);
      BtnSetVisibility(LanguagevoiceButton[2], False);
    #endif
  #endif
    SelectTasksLabel.Hide;
    IconLabel.hide;
    BtnSetVisibility(IconBtn, False);
#ifdef TaskCheckBox
  #if TaskCheckBox == "4"
    Soft1Label.hide;
    Soft2Label.hide;
    Soft3Label.hide;
    Soft4Label.hide;
    BtnSetVisibility(hSoftBtn1, False);
    BtnSetVisibility(hSoftBtn2, False);
    BtnSetVisibility(hSoftBtn3, False);
    BtnSetVisibility(hSoftBtn4, False);
  #else
  #if TaskCheckBox == "2"
    Soft1Label.hide;
    Soft2Label.hide;
    BtnSetVisibility(hSoftBtn1, False);
    BtnSetVisibility(hSoftBtn2, False);
  #endif
  #endif
#endif
    StatusLabel.Hide;
    LabelCurrFileName.Hide;
    IsDoneHide;
end;

//-------- Пропуск страниц
function ShouldSkipPage(PageID: Integer): Boolean;
begin
  if (PageID = wpSelectTasks) or (PageID = wpSelectComponents) then
  Result:= True;
end;

Procedure CurPageChanged(CurPageID: Integer);
Begin
  SetStateNewButtons;
  HideComponents;

  if CurPageID = wpWelcome then
    begin
      SetTaskBarProgressState(TBPF_INDETERMINATE);
      LabelOne.Show;
      LabelOne.Caption:= ExpandConstant('{cm:Welcome1}');
      LabelTwo.Show;
      LabelTwo.Caption:= ExpandConstant('{cm:Welcome2}');
    end;

  if CurPageID = wpSelectDir then
    begin
      LabelOne.Show;
      LabelOne.Caption:= ExpandConstant('{cm:SelectDirLabel}');
      BtnSetVisibility(hDirBrowseBtn, true);
      WizardForm.DirEdit.Show;
      ImgSetVisibility(DirEditImg, true);
      ObjectFunc(nil);
      NoIconsLabel.Show;
      IconLabel.Show;
      BtnSetVisibility(IconBtn, True);
      BtnSetVisibility(IconGroupBtn, True);
      FreeSpaceLabel.Show;
      NeedSpaceLabel.Show;
    end;

  #ifdef Components
  if CurPageID = wpSelectProgramGroup then
    begin
      LabelOne.Show;
      LabelOne.Caption:= ExpandConstant('{cm:SelectComponentsLabel}');
    #ifdef Subtitles
      TextLabel.Show;
      RUSTextLabel.Show;
      ENGTextLabel.Show;
      BtnSetVisibility(LanguagetextButton[1], True);
      BtnSetVisibility(LanguagetextButton[2], True);
    #endif
    #ifdef Voice
      VoiceLabel.Show;
      RUSVoiceLabel.Show;
      ENGVoiceLabel.Show;
      BtnSetVisibility(LanguagevoiceButton[1], True);
      BtnSetVisibility(LanguagevoiceButton[2], True);
    #endif
    #ifdef TaskCheckBox
      SelectTasksLabel.Show;
      #if TaskCheckBox == "4"
        Soft1Label.Show;
        Soft2Label.Show;
        Soft3Label.Show;
        Soft4Label.Show;
        BtnSetVisibility(hSoftBtn1, True);
        BtnSetVisibility(hSoftBtn2, True);
        BtnSetVisibility(hSoftBtn3, True);
        BtnSetVisibility(hSoftBtn4, True);
      #else
      #if TaskCheckBox == "2"
        Soft1Label.Show;
        Soft2Label.Show;
        BtnSetVisibility(hSoftBtn1, True);
        BtnSetVisibility(hSoftBtn2, True);
      #endif
    #endif
  #endif
    TButton(WizardForm.FindComponent('NextButton')). Caption:=ExpandConstant('{cm:Next}'); // текст кнопки Далее на Установить
    end;
   #endif

  if CurPageID = wpInstalling then
    begin
      LabelOne.Show;
      LabelOne.Caption:= ExpandConstant('{cm:InstallingLabel}');
      StatusLabel.Show;
      LabelCurrFileName.Show;
      IsDoneShow();
    end;

  if CurPageID = wpFinished then
    begin
      SetTaskBarProgressValue(100);
      SetTaskBarProgressState(TBPF_NORMAL);
      LabelOne.Show;
      LabelOne.Caption:= ExpandConstant('{cm:FinishedHeadingLabel}');
      LabelTwo.Show;
      LabelTwo.Caption:= ExpandConstant('{cm:FinishedLabel}');
    end;

  if (CurPageID = wpFinished) and ISDoneError then
    begin
      SetTaskBarProgressValue(100);
      SetTaskBarProgressState(TBPF_ERROR);
      LabelTime3.Hide;
      LabelOne.Show;
      LabelOne.Font.Color:= $3c4ce7;
      LabelOne.Caption:= ExpandConstant('{cm:ErrorFinishedHeadingLabel}');
      LabelTwo.Show;
      LabelTwo.Caption:= ExpandConstant('{cm:ErrorFinishedLabel}');
      DelTree(ExpandConstant('{app}'), True, True, True);
    end;
    ImgApplyChanges(WizardForm.Handle);
end;

#ifdef DirGameSave
//================== Удаление сохранений ==================//

procedure DeleteSavedGames(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep=usUninstall then
  if DirExists(ExpandConstant{#DirGameSave}) then
  if MsgBox(ExpandConstant('{cm:DeleteSave}'), mbInformation, MB_YESNO) = idYes then
  DelTree(ExpandConstant{#DirGameSave}, True, True, True)
end;
//================== Удаление сохранений ==================//
#endif

procedure CurStepChanged(CurStep: TSetupStep);
 begin
  IsDoneUnpack(CurStep);
 end;

#ifdef DirGameSave
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  DeleteSavedGames(CurUninstallStep);
end;
#endif

procedure DeinitializeSetup();
 begin
   if b2p then begin
   gdipShutdown;
   WFButtonFont.Free;
   RemoveFontResource(ExpandConstant('{tmp}\Roboto-Light.ttf'), FR_PRIVATE, 0);
   WizardForm.Free;
   #ifdef TaskBar
   DeInit_TaskBar;
   DeInitWin7TaskBar;
   #endif
   end;
 end;