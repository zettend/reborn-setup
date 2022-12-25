[Code]
function SetWindowLong(hWnd: HWND; nIndex: Integer; dwNewLong: Longint): Longint; external 'SetWindowLongA@user32.dll stdcall';
function SetLayeredWindowAttributes(hwnd: hWnd; crKey: TColor; bAlpha: byte; dwFlags: DWORD): Boolean; external 'SetLayeredWindowAttributes@user32.dll stdcall';
function GetWindowLong(Wnd: HWnd; Index: Integer): Longint; external 'GetWindowLongA@user32.dll stdcall';
function SetParent(hWndChild, hWndNewParent: HWND): HWND; external 'SetParent@user32.dll stdcall';
function SetWindowRgn(hWnd: HWND; hRgn: LongWord; bRedraw: BOOL): Integer;  external 'SetWindowRgn@user32.dll stdcall';
function ReleaseCapture: Longint; external 'ReleaseCapture@user32.dll stdcall';
function CreateRoundRectRgn(p1, p2, p3, p4, p5, p6: Integer): THandle; external 'CreateRoundRectRgn@gdi32 stdcall';

function IconDP: Boolean;
 begin
  Result:= BtnGetChecked(IconBtn);
 end;

function IconGroup: Boolean;
 begin
  Result:= BtnGetChecked(IconGroupBtn);
 end;

function Soft1: Boolean;
 begin
  Result:= BtnGetChecked(hSoftBtn1);
 end;

function Soft2: Boolean;
 begin
  Result:= BtnGetChecked(hSoftBtn2);
 end;

function Soft3: Boolean;
 begin
  Result:= BtnGetChecked(hSoftBtn3);
 end;

function Soft4: Boolean;
 begin
  Result:= BtnGetChecked(hSoftBtn4);
 end;

procedure IconClick(hBtn:HWND);
 var
  Check:boolean;
 begin
  Check:=BtnGetChecked(hBtn);
 end;

procedure IconGroupClick(hBtn:HWND);
 var
  Check:boolean;
 begin
  Check:=BtnGetChecked(hBtn);
 end;

procedure Soft1Click(hBtn:HWND);
 var
  Check:boolean;
 begin
  Check:=BtnGetChecked(hBtn);
 end;

procedure Soft2Click(hBtn:HWND);
 var
  Check:boolean;
 begin
  Check:=BtnGetChecked(hBtn);
 end;


procedure Soft3Click(hBtn:HWND);
 var
  Check:boolean;
 begin
  Check:=BtnGetChecked(hBtn);
 end;

procedure Soft4Click(hBtn:HWND);
 var
  Check:boolean;
 begin
  Check:=BtnGetChecked(hBtn);
 end;

procedure IconLabelClick(Sender:TObject);
 begin
  BtnSetChecked(IconBtn, not BtnGetChecked(IconBtn));
  IconClick(IconBtn);
 end;

procedure IconGroupLabelClick(Sender:TObject);
 begin
  BtnSetChecked(IconGroupBtn, not BtnGetChecked(IconGroupBtn));
  IconClick(IconGroupBtn);
 end;

procedure Soft1LabelClick(Sender:TObject);
 begin
  BtnSetChecked(hSoftBtn1, not BtnGetChecked(hSoftBtn1));
  Soft1Click(hSoftBtn1);
 end;

procedure Soft2LabelClick(Sender:TObject);
 begin
  BtnSetChecked(hSoftBtn2, not BtnGetChecked(hSoftBtn2));
  Soft2Click(hSoftBtn2);
 end;

procedure Soft3LabelClick(Sender:TObject);
 begin
  BtnSetChecked(hSoftBtn3, not BtnGetChecked(hSoftBtn3));
  Soft1Click(hSoftBtn3);
 end;

procedure Soft4LabelClick(Sender:TObject);
 begin
  BtnSetChecked(hSoftBtn4, not BtnGetChecked(hSoftBtn4));
  Soft2Click(hSoftBtn4);
 end;

procedure Soft1Progress;
 begin
  SetTaskBarProgressState(TBPF_INDETERMINATE);
  StatusLabel.Caption:=ExpandConstant('{cm:DirectXInstall}')
 end;

procedure Soft2Progress;
 begin
  SetTaskBarProgressState(TBPF_INDETERMINATE);
  StatusLabel.Caption:=ExpandConstant('{cm:VCRedistInstall}')
 end;
 
#ifdef Components
function RUSText: Boolean;
 begin
   result:= not IsDoneError and BtnGetChecked(LanguagetextButton[1]);
 end;

function ENGText: Boolean;
 begin
   result:= not IsDoneError and BtnGetChecked(LanguagetextButton[2]);
 end;

procedure SelectLanguagetext(hBtn:HWND);
 begin
  BtnSetChecked(hBtn,True);
  if hBtn=LanguagetextButton[1] then begin
    BtnSetChecked(LanguagetextButton[2],False);
  end else begin
    BtnSetChecked(LanguagetextButton[1],False);
  end;
 end;

function RUSVoice: Boolean;
 begin
   result:= not IsDoneError and BtnGetChecked(LanguagevoiceButton[1]);
 end;

function ENGVoice: Boolean;
 begin
   result:= not IsDoneError and BtnGetChecked(LanguagevoiceButton[2]);
 end;

procedure SelectLanguagevoice(hBtn:HWND);
 begin
  BtnSetChecked(hBtn,True);
  if hBtn=LanguagevoiceButton[1] then begin
    BtnSetChecked(LanguagevoiceButton[2],False);
  end else begin
    BtnSetChecked(LanguagevoiceButton[1],False);
  end;
 end;

procedure Languagetext1LabelClick(Sender:TObject);
 begin
  BtnSetChecked(LanguagetextButton[1], not BtnGetChecked(LanguagetextButton[1]));
  SelectLanguagetext(LanguagetextButton[1]);
 end;

procedure Languagetext2LabelClick(Sender:TObject);
 begin
  BtnSetChecked(LanguagetextButton[2], not BtnGetChecked(LanguagetextButton[2]));
  SelectLanguagetext(LanguagetextButton[2]);
 end;

procedure LanguageVoice1LabelClick(Sender:TObject);
 begin
  BtnSetChecked(LanguagevoiceButton[1], not BtnGetChecked(LanguagevoiceButton[1]));
  SelectLanguagevoice(LanguagevoiceButton[1]);
 end;

procedure LanguageVoice2LabelClick(Sender:TObject);
 begin
  BtnSetChecked(LanguagevoiceButton[2], not BtnGetChecked(LanguagevoiceButton[2]));
  SelectLanguagevoice(LanguagevoiceButton[2]);
 end;
 #endif