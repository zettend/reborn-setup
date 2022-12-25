//created by troyan90 07.2011
//*********************************
//modifed by Shegorat 27.07.2011]
//*********************************
//Changes:
//taskbar updates every half-second
//more correctly usage of DC
//*********************************
//Notes:
//this version needs InnoCallback.dll

[code]
type
  TTimerProc = procedure(HandleW, Msg, idEvent, TimeSys: LongWord);
  
var
  Taskbar_Init: Boolean;
  Taskbar_Timer: Longword;
  
function GetDC(hWnd: HWND): LongWord; external 'GetDC@user32 stdcall';
function BitBlt(DestDC: LongWord; X, Y, Width, Height: Integer; SrcDC: LongWord; XSrc, YSrc: Integer; Rop: DWORD): BOOL; external 'BitBlt@gdi32 stdcall';
function ReleaseDC(hWnd: HWND; hDC: LongWord): Integer; external 'ReleaseDC@user32.dll stdcall';
function WrapTimerProc(callback: TTimerProc; Paramcount: Integer): longword; external 'wrapcallbackaddr@{tmp}\CallbackCtrl.dll stdcall delayload';
function SetTimer(hWnd, nIDEvent, uElapse, lpTimerFunc: LongWord): longword; external 'SetTimer@user32.dll stdcall';
function KillTimer(hWnd, nIDEvent: LongWord): LongWord; external 'KillTimer@user32.dll stdcall';

function isWin6: Boolean;
var
  ver: TWindowsVersion;
begin
  GetWindowsVersionEx(ver)
  if ver.Major < 6 then result:=false
    else result:=true;
end;

procedure update_img(HandleW, Msg, idEvent, TimeSys: LongWord);
var
  FormDC, DC: LongWord;
begin
  MainForm.ClientWidth:= WizardForm.ClientWidth;
  MainForm.ClientHeight:= WizardForm.ClientHeight;
  DC:= GetDC(MainForm.Handle);
  FormDC := GetDC(WizardForm.Handle);
  BitBlt(DC, 0, 0, MainForm.ClientWidth, MainForm.ClientHeight, FormDC, 0, 0, $00CC0020);
  ReleaseDC(MainForm.Handle, DC);
  ReleaseDC(WizardForm.Handle, FormDC);
end;

procedure init_taskbar;
begin
  Taskbar_Init:= isWin6;
  if Taskbar_Init then begin
    MainForm.ClientWidth:=WizardForm.ClientWidth;
    MainForm.ClientHeight:=WizardForm.ClientHeight;
    MainForm.Left:=-100000;
    MainForm.Show;

    Taskbar_Timer:= SetTimer(0, 0, 500, WrapTimerProc(@Update_Img, 4));
  end;
end;

procedure deinit_taskbar;
begin
  if Taskbar_Init then
    KillTimer(0, Taskbar_Timer);
end;