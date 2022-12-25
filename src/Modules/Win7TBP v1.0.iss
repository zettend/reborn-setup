
[code]
//created by troyan90 02.2012

#ifndef UNICODE
  #error REQUIRES UNICODE INNO SETUP!
#endif

const
  CLSID_TaskbarList = '{56FDF344-FD6D-11D0-958A-006097C9A090}';

  TBPF_NOPROGRESS         = 0;
  TBPF_INDETERMINATE      = 1;
  TBPF_NORMAL             = 2;
  TBPF_ERROR              = 4;
  TBPF_PAUSED             = 8;

type
  ITaskbarList = interface(IUnknown)
    '{56FDF342-FD6D-11D0-958A-006097C9A090}'
    procedure HrInit;
    procedure AddTab(hwnd: Cardinal);
    procedure DeleteTab(hwnd: Cardinal);
    procedure ActivateTab(hwnd: Cardinal);
    procedure SetActiveAlt(hwnd: Cardinal);
  end;

  ITaskbarList2 = interface(ITaskbarList)
    '{602D4995-B13A-429B-A66E-1935E44F4317}'
    procedure MarkFullscreenWindow(hwnd: Cardinal; fFullscreen: Bool);
  end;

  ITaskbarList3 = interface(ITaskbarList2)
    '{EA1AFB91-9E28-4B86-90E9-9E9F8A5EEFAF}'
    procedure SetProgressValue(hwnd: Cardinal; ullCompleted, ullTotal: Currency);
    procedure SetProgressState(hwnd: Cardinal; tbpFlags: DWORD);
  end;

  TEnumProc = function (Wd: HWnd; Param: LongInt) : Boolean;

function CallbackAddr (Callback: TEnumProc; ParamCount: Integer) : Bool; external 'wrapcallbackaddr@{tmp}\CallbackCtrl.dll stdcall delayload';
function EnumWindows(lpEnumFunc: bool; lParam: integer): BOOL; external 'EnumWindows@user32.dll stdcall delayload';
function GetWindowThreadProcessId(hWnd: HWND; var dwProcessId: DWORD): DWORD; external 'GetWindowThreadProcessId@user32.dll stdcall delayload';
function GetClassName(hWnd: HWND; lpClassName: String; nMaxCount: Integer): Integer;  external 'GetClassNameW@user32.dll stdcall delayload';

var
  Obj: IUnknown; FTaskbar: ITaskbarList3; loaded:boolean; AppHandle:HWND;

function isWin7: boolean;var ver: TWindowsVersion;
begin
  GetWindowsVersionEx(ver);
  if ((ver.Major = 6) and (ver.Minor > 0)) or (ver.Major > 6) then result:=true
    else result:=false;
end;

function EnumWindowsProc(Wd: HWnd; Param: LongInt) : Boolean;
var
  cl:string;i:integer;pid,wfpid:dword;
begin
  result:=true;
  GetWindowThreadProcessId(WizardForm.Handle, wfpid);
  GetWindowThreadProcessId(wd, pid);
  SetLength(cl, 31);
  i:=GetClassName(wd, cl, 31);
  SetLength(cl, i);
  if (pid=wfpid) and (cl='TApplication') then begin
    AppHandle:=Wd;
    result:=false;
  end;
end;

procedure InitWin7TaskBar;
begin
  loaded:=false;
  if isWin7 then begin
    Obj:=CreateComObject(StringToGuid(CLSID_TaskbarList));
    if Obj <> nil then begin
      loaded:=true;
      EnumWindows(CallbackAddr(@EnumWindowsProc, 2), 0);
      FTaskbar:=ITaskbarList3(Obj);
      FTaskbar.HrInit;
    end;
  end;
end;

procedure DeInitWin7TaskBar;
begin
  if isWin7 and loaded then
    CoFreeUnusedLibraries;
end;

procedure SetTaskBarProgressValue(Value:Integer);
begin
  if isWin7 and loaded then
    FTaskbar.SetProgressValue(AppHandle, Value, 100);
end;

procedure SetTaskBarProgressState(Value:Integer);
begin
  if isWin7 and loaded then
    FTaskbar.SetProgressState(AppHandle, Value);
end;