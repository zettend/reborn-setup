[Code]
const
  MAX_PATH              = 260;
  TH32CS_SNAPPROCESS    = $00000002;
  INVALID_HANDLE_VALUE  = -1;
  PROCESS_TERMINATE     = $0001;
  PM_REMOVE             = 1;
  STARTF_USESHOWWINDOW  = 1;
  NORMAL_PRIORITY_CLASS = $00000020;

type
  TProcessEntry32 = record
    dwSize: DWORD;
    cntUsage: DWORD;
    th32ProcessID: DWORD;
    th32DefaultHeapID: DWORD;
    th32ModuleID: DWORD;
    cntThreads: DWORD;
    th32ParentProcessID: DWORD;
    pcPriClassBase: Longint;
    dwFlags: DWORD;
    szExeFile: array[0..MAX_PATH] of Char;
  end;

  _TMsg = record
    hWnd: HWND;
    msg: Word;
    wParam: Word;
    lParam: LongWord;
    Time: TFileTime;
    pt: TPoint;
  end;

  TProcessInformation = record
    hProcess: THandle;
    hThread: THandle;
    dwProcessId: DWORD;
    dwThreadId: DWORD;
  end;

  TStartupInfo = record
    cb: DWORD;
    lpReserved: Longint;
    lpDesktop: Longint;
    lpTitle: PChar;
    dwX: DWORD;
    dwY: DWORD;
    dwXSize: DWORD;
    dwYSize: DWORD;
    dwXCountChars: DWORD;
    dwYCountChars: DWORD;
    dwFillAttribute: DWORD;
    dwFlags: DWORD;
    wShowWindow: Word;
    cbReserved2: Word;
    lpReserved2: Byte;
    hStdInput: THandle;
    hStdOutput: THandle;
    hStdError: THandle;
  end;
var
  _QUIT: Boolean;
  
function _CreateToolhelp32Snapshot(dwFlags, th32ProcessID: DWORD): THandle; external 'CreateToolhelp32Snapshot@kernel32.dll stdcall';
function _Process32First(hSnapshot: THandle; var lppe: TProcessEntry32): BOOL; external 'Process32First@kernel32.dll stdcall';
function _Process32Next(hSnapshot: THandle; var lppe: TProcessEntry32): BOOL; external 'Process32Next@kernel32.dll stdcall';
function _OpenProcess(dwDesiredAccess: DWORD; bInheritHandle: BOOL; dwProcessId: DWORD): THandle; external 'OpenProcess@kernel32.dll stdcall';
function _TerminateProcess(hProcess: THandle; uExitCode: UINT): BOOL; external 'TerminateProcess@kernel32.dll stdcall';
function _CloseHandle(hObject: THandle): BOOL; external 'CloseHandle@kernel32.dll stdcall';
function _PeekMessage(var lpMsg: _TMsg; hWnd: HWND; wMsgFilterMin, wMsgFilterMax, wRemoveMsg: UINT): BOOL; external 'PeekMessageA@user32.dll stdcall';
function _TranslateMessage(const lpMsg: _TMsg): BOOL; external 'TranslateMessage@user32.dll stdcall';
function _DispatchMessage(const lpMsg: _TMsg): Longint; external 'DispatchMessageA@user32.dll stdcall';
function _CreateProcess(lpApplicationName: PChar; lpCommandLine: PChar;
  lpProcessAttributes, lpThreadAttributes: DWORD; bInheritHandles: BOOL; dwCreationFlags: DWORD;
    lpEnvironment: PChar; lpCurrentDirectory: PChar; const lpStartupInfo: TStartupInfo;
      var lpProcessInformation: TProcessInformation): BOOL;
        external 'CreateProcessA@kernel32.dll stdcall';

procedure _Application_ProcessMessages;
var
  Msg: _TMsg;
begin
  if not _PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then Exit;
  _TranslateMessage(Msg);
  _DispatchMessage(Msg);
end;

function _KillProcess(ProcessID: DWORD): Boolean;
var
  hProcess: THandle;
begin
  hProcess:= _OpenProcess(PROCESS_TERMINATE, False, ProcessID);
  Result:= _TerminateProcess(hProcess, 0);
  _CloseHandle(hProcess);
end;

function _ArrayCharToString(ArrayChar: array of Char): string;
var
  i: Integer;
  str: string;
begin
  for i:= 0 to MAX_PATH do
    if (ArrayChar[i]) <> #0 then
      str:= str + ArrayChar[i]
    else Break;
  Result:= str;
end;

function _ProcIsRunning(Process: string; ProcessID: DWORD): Boolean;
var
  Snap: THandle;
  pe32: TProcessEntry32;
begin
  Result:= False;
  if Pos('\', Process) > 0 then Process:= ExtractFileName(Process);
  Snap:= _CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snap = INVALID_HANDLE_VALUE then Exit;
  pe32.dwSize:= SizeOf(pe32);
  if _Process32First(Snap, pe32) then
    while _Process32Next(Snap, pe32) do
      begin
        if pe32.th32ProcessID = ProcessID then
          if (LowerCase(_ArrayCharToString(pe32.szExeFile)) = LowerCase(Process)) then
            begin
              Result:= True;
              Break;
            end;
        if _QUIT then Break;
        _Application_ProcessMessages;
      end;
  _CloseHandle(Snap);
end;

procedure _WizardFormOnCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
 _QUIT:= True;
end;

function _StartProc(const Filename, Params, WorkingDir: string; const ShowCmd: Word; TerminateChild: Boolean): Boolean;
var
  PI: TProcessInformation;
  SI: TStartupInfo;
  ProcessId: DWORD;
  ProcessName: string;
  CmdLine: string;
begin
  _QUIT:= False;
  CmdLine:= '"' + Filename + '" ' + Params;
  SI.cb:= SizeOf(SI);
  SI.dwFlags:= STARTF_USESHOWWINDOW;
  SI.wShowWindow:= ShowCmd;
  try
    Result:= _CreateProcess('', PChar(CmdLine), 0, 0, False, NORMAL_PRIORITY_CLASS, '', PChar(WorkingDir), SI, PI);
  except
    ShowExceptionMessage;
  end;
  if Result then
    begin
      WizardForm.OnCloseQuery:= @_WizardFormOnCloseQuery;
      ProcessName:= ExtractFileName(Filename);
      ProcessId:= PI.dwProcessId;
      _CloseHandle(PI.hProcess);
      _CloseHandle(PI.hThread);
      while _ProcIsRunning(ProcessName, ProcessID) do;
      if _QUIT and TerminateChild then _KillProcess(ProcessID);
    end;
end;
function ExecAndWait(const Filename, Params, WorkingDir: string; const ShowCmd: Word; TerminateChild: Boolean): Boolean;
begin
  Result:= _StartProc(Filename, Params, WorkingDir, ShowCmd, TerminateChild);
end;
