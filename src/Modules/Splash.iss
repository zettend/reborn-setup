#define SplashCount "1" ;���������� Splash ��������

#define SplS "1000" ;����� ���������� �������� Splash (1000�� = 1 ���).
#define SplR "2000" ;����� ������ �������� Splash (1000�� = 1 ���).
#define SplE "1000" ;����� ��������� �������� Splash (1000�� = 1 ���).

[Files]
Source: InstallFiles\SplashFiles\*.*; Flags: DontCopy

[code]
var
  SplashForm: TSetupForm;

//============================================== [Splash - ������] ==============================================\\
Procedure ShowSplashScreen(P1: HWND; P2: PAnsiChar; P3, P4, P5, P6, P7: Integer; P8: Boolean; P9: Cardinal; P10: Integer); external 'ShowSplashScreen@files:ISGSG.dll stdcall delayload';

Function RunSplash(): Boolean; // ������ ������ Splash
begin
  SplashForm:= CreateCustomForm;
  For i:=1 to {#SplashCount} do begin
    ExtractTemporaryFile('Splash-' + IntToStr(i) + '.png');
    ShowSplashScreen(SplashForm.Handle, ExpandConstant('{tmp}')+'\Splash-' + IntToStr(i) + '.png', {#SplS}, {#SplR}, {#SplE}, 0, 255, False, $FFFFFF, 10);
  end;
  SplashForm.Free;
  Result:= True;
end;
//============================================== [Splash - �����] ==============================================\\