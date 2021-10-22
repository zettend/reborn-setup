#ifdef UNICODE
    #define A "W"
#else
    #define A "A"
#endif

[Code]
const
  WM_MOVE = $3;
  GWL_WNDPROC = -4;

// Работа с таймером
Function SetTimer(hWnd, nIDEvent, uElapse, lpTimerFunc: LongWord): LongWord; External 'SetTimer@user32.dll StdCall';
Function KillTimer(hWnd, nIDEvent: LongWord): LongWord; External 'KillTimer@user32.dll StdCall';
// Работа с таймером

// Установка приоритета
Function SetPriorityClass(hProcess: THandle; dwPriorityClass: DWORD): BOOL; External 'SetPriorityClass@kernel32';
Function GetCurrentProcess: THandle; External 'GetCurrentProcess@kernel32';
// Установка приоритета

// Перемещение формы
Function SetWindowLong(Wnd: HWnd; Index: Integer; NewLong: LongInt): LongInt; External 'SetWindowLongA@user32.dll StdCall';
Function CallWindowProc(lpPrevWndFunc: LongInt; hWnd: HWND; Msg: UINT; wParam, lParam: LongInt): LongInt; External 'CallWindowProcA@user32.dll StdCall';
Function SetWindowPos(hWnd: HWND; hWndInsertAfter: HWND; X, Y, cx, cy: Integer; uFlags: UINT): BOOL; External 'SetWindowPos@user32.dll StdCall';
// Перемещение формы

// Перемещение основной формы 
Function ReleaseCapture: LongInt; external 'ReleaseCapture@user32.dll stdcall';
Procedure FrameMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  WizardForm.SetFocus;
  ReleaseCapture();
  SendMessage(WizardForm.Handle, $0112, $F012, 0);
end;
// Перемещение основной формы

// Запрет выхода при нажатии Alt + F4
Function GetClassLong(Wnd: HWnd; Index: Integer): LongInt; External 'GetClassLongA@user32.dll StdCall';
Function SetClassLong(Wnd: HWnd; Index: Integer; NewLong: LongInt): LongInt; External 'SetClassLongA@user32.dll StdCall';
// Запрет выхода при нажатии Alt + F4

// Установка Атрибутов файла
Function SetFileAttributesW(lpFileName: String; dwFileAttributes: DWORD): Boolean; External 'SetFileAttributesW@kernel32.dll StdCall';
// Установка Атрибутов файла

// Проигрывание звуков при наведении и нажатии
Function mciSendString(lpstrCommand, lpstrReturnString: PAnsiChar; uReturnLength, hWndCallback: Integer): Integer; external 'mciSendStringA@winmm stdcall delayload';

Procedure SoundEnterPlay();
begin
  //mciSendString('close AudioSetup', '', 0, 0);
  //mciSendString('open ' + ExpandConstant('{tmp}\Enter.wav') + ' type MpegVideo alias AudioSetup', '', 0, 0);
  //mciSendString('play AudioSetup', '', 0, 0);
end;

Procedure SoundClickPlay();
begin
  //mciSendString('close AudioSetup', '', 0, 0);
  //mciSendString('open ' + ExpandConstant('{tmp}\Click.wav') + ' type MpegVideo alias AudioSetup', '', 0, 0);
  //mciSendString('play AudioSetup', '', 0, 0);
end;
// Проигрывание звуков при наведении и нажатии

// Установка кастомного шрифта
Function ADDFontResource(lpszFilename: String; fl, pdv: DWORD): Integer; External 'AddFontResourceEx{#A}@gdi32.dll StdCall';
Function RemoveFontResource(lpFileName: String; fl, pdv: DWORD): BOOL; External 'RemoveFontResourceEx{#A}@gdi32.dll StdCall';
// Установка кастомного шрифта