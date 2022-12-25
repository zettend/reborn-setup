[Code]
//������ ��� ������ � ����������� botva2.dll ������  0.9.5
//Created by South.Tver 02.2011

const
  BTN_MAX_PATH = 1024; //�� �������� !!!

  //�������������� ������� ��� ������
  BtnClickEventID      = 1;
  BtnMouseEnterEventID = 2;
  BtnMouseLeaveEventID = 3;
  BtnMouseMoveEventID  = 4;
  BtnMouseDownEventID  = 5;
  BtnMouseUpEventID    = 6;

  //������������ ������ �� �������
  balLeft    = 0;  //������������ ������ �� ������ ����
  balCenter  = 1;  //�������������� ������������ ������ �� ������
  balRight   = 2;  //������������ ������ �� ������� ����
  balVCenter = 4;  //������������ ������������ ������ �� ������

type
  #ifndef UNICODE
  AnsiChar = Char;
  #endif

  TBtnEventProc = procedure(h:HWND);

  TTextBuf      = array [0..BTN_MAX_PATH-1] of AnsiChar; //�� ������ ����������� ������� !!!

//��� ���������� ������� �� ������ ����� innocallback
function WrapBtnCallback(Callback: TBtnEventProc; ParamCount: Integer): Longword; external 'wrapcallbackaddr@{tmp}\CallbackCtrl.dll stdcall delayload';

function LibImgLoad(Wnd :HWND; buf :PAnsiChar; Size: Longint; Left, Top, Width, Height :integer; Stretch, IsBkg :boolean) :Longint; external 'ImgLoad@{tmp}\b2p.dll stdcall delayload';
//��������� ����������� � ������, ��������� ���������� ���������
//Wnd          - ����� ����, � ������� ����� �������� �����������
//FileName     - ���� �����������
//Left,Top     - ���������� �������� ������ ���� ������ ����������� (� ����������� ���������� ������� Wnd)
//Width,Height - ������, ������ �����������
//               ���� Stretch=True, �� ����������� ����� ���������/����� � ������������� �������
//               Rect.Left:=Left;
//               Rect.Top:=Top;
//               Rect.Right:=Left+Width;
//               Rect.Bottom:=Top+Height;
//               ���� Stretch=False, �� ��������� Width,Height ������������ � ����������� ����� ImgLoad, �.�. ����� �������� 0
//Stretch      - �������������� ����������� ��� ���
//IsBkg        - ���� IsBkg=True, ����������� ����� �������� �� ���� �����,
//               ������ ���� ����� ���������� ����������� ������� (TLabel, TBitmapImage � �.�.),
//               ����� ������ ����� ����� �������� ����������� � ������ IsBkg=False
//������������ �������� - ��������� �� ���������, �������� ����������� � ��� ��������, ����������� � ���� Longint
//����������� ����� �������� � ��� ������������������, � ������� ���������� ImgLoad

procedure ImgSetVisiblePart(img:Longint; NewLeft, NewTop, NewWidth, NewHeight : integer); external 'ImgSetVisiblePart@{tmp}\b2p.dll stdcall delayload';
//��������� ����� ���������� ������� ����� �����������, ����� ������ � ������. � ����������� ������������� �����������
//img                - �������� ���������� ��� ������ ImgLoad.
//NewLeft,NewTop     - ����� ����� ������� ���� ������� �������.
//NewWidth,NewHeight - ����� ������, ������ ������� �������.
//PS ���������� (��� ������ ImgLoad) ����������� ��������� ��������� �������.
//   ���� �������� ������������� ���������� ������ ����� ��������, �� ���������� ��� ���������

procedure ImgGetVisiblePart(img:Longint; var Left, Top, Width, Height : integer); external 'ImgGetVisiblePart@{tmp}\b2p.dll stdcall delayload';
//���������� ���������� ������� ����� �����������, ������ � ������
//img                - �������� ���������� ��� ������ ImgLoad
//NewLeft,NewTop     - ����� ������� ���� ������� �������
//NewWidth,NewHeight - ������, ������ ������� �������.

procedure ImgSetPosition(img :Longint; NewLeft, NewTop, NewWidth, NewHeight :integer); external 'ImgSetPosition@{tmp}\b2p.dll stdcall delayload';
//��������� ����� ���������� ��� ������ �����������, ����� ������ � ������. � ����������� ������������� ����
//img                - �������� ���������� ��� ������ ImgLoad
//NewLeft,NewTop     - ����� ����� ������� ����
//NewWidth,NewHeight - ����� ������, ������. ���� � ImgLoad ��� ������� Stretch=False, �� NewWidth,NewHeight ������������

procedure ImgGetPosition(img:Longint; var Left, Top, Width, Height:integer); external 'ImgGetPosition@{tmp}\b2p.dll stdcall delayload';
//���������� ���������� ������ �����������, ������ � ������
//img          - �������� ���������� ��� ������ ImgLoad
//Left,Top     - ����� ������� ����
//Width,Height - ������, ������.

procedure ImgSetVisibility(img :Longint; Visible :boolean); external 'ImgSetVisibility@{tmp}\b2p.dll stdcall delayload';
//��������� �������� ��������� �����������
//img     - �������� ���������� ��� ������ ImgLoad
//Visible - ���������

function ImgGetVisibility(img:Longint):boolean; external 'ImgGetVisibility@{tmp}\b2p.dll stdcall delayload';
//img - �������� ���������� ��� ������ ImgLoad
//������������ �������� - ��������� �����������

procedure ImgSetTransparent(img:Longint; Value:integer); external 'ImgSetTransparent@{tmp}\b2p.dll stdcall delayload';
//������������� ������������ �����������
//img   - �������� ���������� ��� ������ ImgLoad
//Value - ������������ (0-255)

function ImgGetTransparent(img:Longint):integer; external 'ImgGetTransparent@{tmp}\b2p.dll stdcall delayload';
//�������� �������� ������������
//img   - �������� ���������� ��� ������ ImgLoad
//������������ �������� - ������� ������������ �����������

procedure ImgRelease(img :Longint); external 'ImgRelease@{tmp}\b2p.dll stdcall delayload';
//������� ����������� �� ������
//img - �������� ���������� ��� ������ ImgLoad

procedure ImgApplyChanges(h:HWND); external 'ImgApplyChanges@{tmp}\b2p.dll stdcall delayload';
//��������� ������������� ����������� ��� ������ �����,
//�������� ��� ��������� ��������� �������� ImgLoad, ImgSetPosition, ImgSetVisibility, ImgRelease � ��������� ����
//h - ����� ����, ��� �������� ���������� ������������ ����� �����������



function LibBtnCreate(hParent :HWND; Left, Top, Width, Height :integer; Buf :PAnsiChar; Size: longInt; ShadowWidth :integer; IsCheckBtn :boolean) :HWND; external 'BtnCreate@{tmp}\b2p.dll stdcall delayload';
//hParent           - ����� ����-��������, �� ������� ����� ������� ������
//Left,Top,
//Width,Height      - ��� ������������. �� �� ��� � ��� ������� ������
//FileName          - ���� � ������������ ��������� ������
//                    ��� ������� ������ ����� 4 ��������� ������ (�������������� 4 �����������)
//                    ��� ������ � IsCheckBtn=True ����� 8 ����������� (��� ��� ��������)
//                    ����������� ��������� ������ ������������� �����������
//ShadowWidth       - ���-�� �������� �� ���� ������� ������, �� �������� �� ������� �� �������.
//                    ����� ����� ��������� ������ � ������ �� ��� �������� ��� ��������
//IsCheckBtn        - ���� True, �� ����� ������� ������ (������ CheckBox) ������� ���������� � ����������� ���������
//                    ���� False, �� ��������� ������� ������
//������������ �������� - ����� ��������� ������

procedure BtnSetText(h :HWND; Text :PAnsiChar); external 'BtnSetText@{tmp}\b2p.dll stdcall delayload';
//������������� ����� �� ������ (������ Button.Caption:='bla-bla-bla')
//h    - ����� ������ (��������� ������������ BtnCreate)
//Text - �����, ������� �� ����� ������� �� ������

function BtnGetText_(h:HWND; var Text:TTextBuf):integer; external 'BtnGetText@{tmp}\b2p.dll stdcall delayload';
//�������� ����� ������
//h    - ����� ������ (��������� ������������ BtnCreate)
//Text - ����� ����������� ����� ������
//������������ �������� - ����� ������

procedure BtnSetTextAlignment(h :HWND; HorIndent, VertIndent :integer; Alignment :DWORD); external 'BtnSetTextAlignment@{tmp}\b2p.dll stdcall delayload';
//������������� ������������ ������ �� ������
//h          - ����� ������ (��������� ������������ BtnCreate)
//HorIndent  - �������������� ������ ������ �� ���� ������
//VertIndent - ������������ ������ ������ �� ���� ������
//Alignment  - ������������ ������. �������� ����������� balLeft, balCenter, balRight, balVCenter,
//             ��� ����������� balVCenter � ����������. ��������, balVCenter or balRight

procedure BtnSetFont(h :HWND; Font :Cardinal); external 'BtnSetFont@{tmp}\b2p.dll stdcall delayload';
//������������� ����� ��� ������
//h    - ����� ������ (��������� ������������ BtnCreate)
//Font - ���������� ���������������� ������
//       ����� �� �������� � WinAPI-����� ��������� ����� ������� ����� ������������ ���������� ���� � �������� ��� �����
//       ��������,
//       var
//         Font:TFont;
//         . . .
//       begin
//         . . .
//         Font:=TFont.Create;
//         ��� �������� ����� �� �������������, ��� �������� �������� ����������� ���������� �� ���������. ������ ������ �� ��� ��� �����
//         with Font do begin
//           Name:='Tahoma';
//           Size:=10;
//           . . .
//         end;
//         BtnSetFont(hBtn,Font.Handle);
//         . . .
//       end;
//       �� � ��� ������ �� ��������� (��� ����� �� ������ �� �����) �� �������� ���������� ���� ����� Font.Free;

procedure BtnSetFontColor(h :HWND; NormalFontColor, FocusedFontColor, PressedFontColor, DisabledFontColor :Cardinal); external 'BtnSetFontColor@{tmp}\b2p.dll stdcall delayload';
//������������� ���� ������ ��� ������ �� ���������� � ����������� ����������
//h                 - ����� ������ (��������� ������������ BtnCreate)
//NormalFontColor   - ���� ������ �� ����� � ���������� ���������
//FocusedFontColor  - ���� ������ �� ����� � ������������ ���������
//PressedFontColor  - ���� ������ �� ����� � ������� ���������
//DisabledFontColor - ���� ������ �� ����� � ����������� ���������

function BtnGetVisibility(h :HWND) :boolean; external 'BtnGetVisibility@{tmp}\b2p.dll stdcall delayload';
//�������� ��������� ������ (������ f:=Button.Visible)
//h - ����� ������ (��������� ������������ BtnCreate)
//������������ �������� - ��������� ������

procedure BtnSetVisibility(h :HWND; Value :boolean); external 'BtnSetVisibility@{tmp}\b2p.dll stdcall delayload';
//������������� ��������� ������ (������ Button.Visible:=True / Button.Visible:=False)
//h     - ����� ������ (��������� ������������ BtnCreate)
//Value - �������� ���������

function BtnGetEnabled(h :HWND) :boolean; external 'BtnGetEnabled@{tmp}\b2p.dll stdcall delayload';
//�������� ����������� ������ (������ f:=Button.Enabled)
//h - ����� ������ (��������� ������������ BtnCreate)
//������������ �������� - ����������� ������

procedure BtnSetEnabled(h :HWND; Value :boolean); external 'BtnSetEnabled@{tmp}\b2p.dll stdcall delayload';
//������������ ����������� ������ (������ Button.Enabled:=True / Button.Enabled:=False)
//h - ����� ������ (��������� ������������ BtnCreate)
//Value - �������� ����������� ������

function BtnGetChecked(h :HWND) :boolean; external 'BtnGetChecked@{tmp}\b2p.dll stdcall delayload';
//�������� ��������� (��������/���������) ������ (������ f:=Checkbox.Checked)
//h - ����� ������ (��������� ������������ BtnCreate)

procedure BtnSetChecked(h :HWND; Value :boolean); external 'BtnSetChecked@{tmp}\b2p.dll stdcall delayload';
//������������ ��������� (��������/���������) ������ (������ �heckbox.Checked:=True / �heckbox.Checked:=False)
//h - ����� ������ (��������� ������������ BtnCreate)
//Value - �������� ��������� ������

procedure BtnSetEvent(h :HWND; EventID :integer; Event :Longword); external 'BtnSetEvent@{tmp}\b2p.dll stdcall delayload';
//������������� ������� ��� ������
//h       - ����� ������ (��������� ������������ BtnCreate)
//EventID - ������������� �������, �������� �����������   BtnClickEventID, BtnMouseEnterEventID, BtnMouseLeaveEventID, BtnMouseMoveEventID
//Event   - ����� ��������� ����������� ��� ����������� ���������� �������
//������ ������������� - BtnSetEvent(hBtn, BtnClickEventID, WrapBtnCallback(@BtnClick,1));

procedure BtnGetPosition(h:HWND; var Left, Top, Width, Height: integer);  external 'BtnGetPosition@{tmp}\b2p.dll stdcall delayload';
//�������� ���������� ������ �������� ���� � ������ ������
//h             - ����� ������ (��������� ������������ BtnCreate)
//Left, Top     - ���������� �������� ������ ���� (� ����������� ������������� ����)
//Width, Height - ������, ������ ������

procedure BtnSetPosition(h:HWND; NewLeft, NewTop, NewWidth, NewHeight: integer);  external 'BtnSetPosition@{tmp}\b2p.dll stdcall delayload';
//������������� ���������� ������ �������� ���� � ������ ������
//h                   - ����� ������ (��������� ������������ BtnCreate)
//NewLeft, NewTop     - ����� ���������� �������� ������ ���� (� ����������� ������������� ����)
//NewWidth, NewHeight - ����� ������, ������ ������

procedure BtnRefresh(h :HWND); external 'BtnRefresh@{tmp}\b2p.dll stdcall delayload';
//���������� �������������� ������, � ����� ������� ���������. ��������, ���� ������ �� �������� ����������������
//h - ����� ������ (��������� ������������ BtnCreate)

procedure BtnSetCursor(h:HWND; hCur:Cardinal); external 'BtnSetCursor@{tmp}\b2p.dll stdcall delayload';
//������������� ������ ��� ������
//h    - ����� ������ (��������� ������������ BtnCreate)
//hCur - ���������� ���������������� �������
//DestroyCursor �������� �� �����������, �� ����� ��������� ��� ������ gdipShutDown;

function GetSysCursorHandle(id:integer):Cardinal; external 'GetSysCursorHandle@{tmp}\b2p.dll stdcall delayload';
//��������� ����������� ������ �� ��� ��������������
//id - ������������� ������������ �������. �������������� ����������� �������� �������� ����������� OCR_... , �������� ������� ���� � �����
//������������ ��������  - ���������� ������������ �������

procedure gdipShutdown; external 'gdipShutdown@{tmp}\b2p.dll stdcall delayload';
//����������� ������� ��� ���������� ����������



procedure LibCreateFormFromImage(h:HWND; Buf:PAnsiChar; Size: Longint); external 'CreateFormFromImage@{tmp}\b2p.dll stdcall delayload';
//������� ����� �� PNG-������� (� �������� ����� ������������ ������ ������� �����������)
//h        - ����� ����
//FileName - ���� � ����� �����������
//�� ����� ����� �� ����� ����� �������� (������, ��������, ����� � �.�.) !!!

function CreateBitmapRgn(DC: LongWord; Bitmap: HBITMAP; TransClr: DWORD; dX:integer; dY:integer): LongWord; external 'CreateBitmapRgn@{tmp}\b2p.dll stdcall delayload';
//������� ������ �� �������
//DC       - �������� �����
//Bitmap   - ������ �� �������� ����� ������� ������
//TransClr - ���� ��������, ������� �� ����� �������� � ������ (���������� ����)
//dX,dY    - �������� ������� �� �����

procedure SetMinimizeAnimation(Value: Boolean); external 'SetMinimizeAnimation@{tmp}\b2p.dll stdcall delayload';
//��������/��������� �������� ��� ������������ ����

function GetMinimizeAnimation: Boolean; external 'GetMinimizeAnimation@{tmp}\b2p.dll stdcall delayload';
//�������� ������� ��������� �������� ������������ ����



function ArrayOfAnsiCharToAnsiString(a:TTextBuf):AnsiString;
var
  i:integer;
begin
  i:=0;
  Result:='';
  while a[i]<>#0 do begin
    Result:=Result+a[i];
    i:=i+1;
  end;
end;

function BtnGetText(hBtn:HWND):AnsiString;
var
  buf:TTextBuf;
begin
  BtnGetText_(hBtn,buf);
  Result:=ArrayOfAnsiCharToAnsiString(buf); //�������� ��������, ��� �� ������� ������� ��
end;

function ImgLoad(Wnd :HWND; Filename :String; Left, Top, Width, Height :integer; Stretch, IsBkg :boolean): Longint;
var
  buffer: AnsiString;
  FileSize: Longint;
begin
  if Pos(ExpandConstant('{tmp}\'), Filename)>0 then StringChange(Filename, ExpandConstant('{tmp}\'), '');
  if Pos('{tmp}\', Filename)>0 then StringChange(Filename, '{tmp}\', '');
  FileSize:= ExtractTemporaryFileSize(Filename);
  SetLength(Buffer, FileSize);
  #ifdef UNICODE
    ExtractTemporaryFileToBuffer(Filename, CastAnsiStringToInteger(Buffer));
  #else
    ExtractTemporaryFileToBuffer(Filename, CastStringToInteger(Buffer));
  #endif
  Result:= LibImgLoad(Wnd, buffer, FileSize, Left, Top, Width, Height, Stretch, Isbkg)
end;

function BtnCreate(hParent :HWND; Left, Top, Width, Height :integer; Filename :String; ShadowWidth :integer; IsCheckBtn :boolean) :HWND;
var
  buffer: AnsiString;
  FileSize: Longint;
begin
  if Pos(ExpandConstant('{tmp}\'), Filename)>0 then StringChange(Filename, ExpandConstant('{tmp}\'), '');
  if Pos('{tmp}\', Filename)>0 then StringChange(Filename, '{tmp}\', '');
  FileSize:= ExtractTemporaryFileSize(Filename);
  SetLength(Buffer, FileSize);
  #ifdef UNICODE
    ExtractTemporaryFileToBuffer(Filename, CastAnsiStringToInteger(Buffer));
  #else
    ExtractTemporaryFileToBuffer(Filename, CastStringToInteger(Buffer));
  #endif
  Result:= LibBtnCreate(hParent, Left, Top, Width, Height, Buffer, FileSize, ShadowWidth, IsCheckBtn);
end;

procedure CreateFormFromImage(h:HWND; Filename:String);
var
  buffer: AnsiString;
  FileSize: Longint;
begin
  if Pos(ExpandConstant('{tmp}\'), Filename)>0 then StringChange(Filename, ExpandConstant('{tmp}\'), '');
  if Pos('{tmp}\', Filename)>0 then StringChange(Filename, '{tmp}\', '');
  FileSize:= ExtractTemporaryFileSize(Filename);
  SetLength(Buffer, FileSize);
  #ifdef UNICODE
    ExtractTemporaryFileToBuffer(Filename, CastAnsiStringToInteger(Buffer));
  #else
    ExtractTemporaryFileToBuffer(Filename, CastStringToInteger(Buffer));
  #endif
  LibCreateFormFromImage(h, Buffer, FileSize);
end;