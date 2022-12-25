[Files]
Source: InstallFiles\DllFiles\MD5\ISMD5.dll; DestDir: {tmp}; Flags: DontCopy

[CustomMessages]
rus.Wait=Проверка хеш-сумм установочных файлов... Ждите...
rus.Check1=Проверка MD5
rus.Check2=Проверка MD5 — «%1» — %2
rus.Close=Вы действительно хотите пропустить проверку MD5?%nЕсли хэш-суммы файлов не совпадут,%nто установка может пройти некорректно.%nПропустить проверку?
rus.Close1=Отмена проверки MD5
rus.ErrorM1=Хеш-сумма файла — «%1» — не совпадает!
rus.Error=Корректность установки не гарантируется! %nВы можете, на свой страх и риск, продолжить ее, но лучше перехешируйте торрент и повторите попытку...
rus.Comparing=Сравнение хеш-суммы файла: «%1» (%2)
rus.Skip=Пропустить
rus.Foundfiles=Проверяется файл: %1 из %2
rus.GSize=Проверено: %1 из %2
rus.Yes=Да
rus.No=Нет
rus.OK=OK

[Code]
Const
  ID_QUESTION = 65579;  //Вопрос
  ID_HAND = 65581;  //Ошибка

Type
  TMD5CallBack = Function (Progress: LongWord): Boolean;

Var
  MainMD5Form, ExitForm, ErrorForm: TSetupForm;
  MD5PB: TNewProgressBar;
  Total, CurN: Integer;
  CloseForm, MD5Error, CanClose, ContinueInstallMD5: Boolean;
  ErrOKButton, OKButton, SkipButton, CancelButton: TButton;
  Ico: TNewIconImage;
  CheckMD5Label, CheckMD5Label2, CheckMD5Label3, CheckMD5Label4: TLabel;
  CurFilename: String;
  CurSize: DWORD;
  TotalProgress: LongWord;
  TSize: Extended;
  Path, MD5Value: Array [1..100] of String;

Procedure MD5();
begin
//-----------------------------------------------------------------------------------------
  Path[1]:= '{src}\Data-1.bin'; //* Путь и название 1 файла  *\\
  MD5Value[1]:= '3247D6214E50C0D2BDCF020898E9C7C9';   //* Хэш-сумма 1 файла *\\
//-----------------------------------------------------------------------------------------
  Path[2]:= '{src}\Soft-1.bin';    //* Путь и название 2 файла  *\\
  MD5Value[2]:= '56DAF8C3968BFA41D0F421683EDC363F';   //* Хэш-сумма 2 файла *\\
//-----------------------------------------------------------------------------------------
  //Path[3]:= '{src}\Data-2.bin';    //* Путь и название 3 файла  *\\
  //MD5Value[3]:= 'FCB10FB85F2E1981828EDB08413BFC0C';   //* Хэш-сумма 3 файла *\\
//-----------------------------------------------------------------------------------------
  //Path[4]:= '{src}\Video-1.bin';   //* Путь и название 4 файла  *\\
  //MD5Value[4]:= '8DC2FE965323A21F586292DAE4751EA1';   //* Хэш-сумма 4 файла *\\
//-----------------------------------------------------------------------------------------
  //Path[5]:= '{src}\Soft-1.bin';    //* Путь и название 5 файла  *\\
  //MD5Value[5]:= '56DAF8C3968BFA41D0F421683EDC363F';   //* Хэш-сумма 5 файла *\\
//-----------------------------------------------------------------------------------------
  //Path[6]:= '{src}\Video-1.bin';    //* Путь и название 6 файла  *\\
  //MD5Value[6]:= '56DAF8C3968BFA41D0F421683EDC363F';   //* Хэш-сумма 6 файла *\\
//-----------------------------------------------------------------------------------------
  //Path[7]:= '{src}\Soft-1.bin';    //* Путь и название 7 файла  *\\
  //MD5Value[7]:= '56DAF8C3968BFA41D0F421683EDC363F';   //* Хэш-сумма 7 файла *\\
//-----------------------------------------------------------------------------------------
  //Path[8]:= '{src}\Soft-1.bin';    //* Путь и название 8 файла  *\\
  //MD5Value[8]:= '56DAF8C3968BFA41D0F421683EDC363F';   //* Хэш-сумма 8 файла *\\
//-----------------------------------------------------------------------------------------
  //Path[9]:= '{src}\Video-1.bin';     //* Путь и название 9 файла  *\\
  //MD5Value[9]:= '29784010AF1A8221818944B60BF2C18A';   //* Хэш-сумма 9 файла *\\
//-----------------------------------------------------------------------------------------
end;

Function CheckMD5(Filename: PAnsiChar; MD5: PAnsiChar; CallBack: TMD5CallBack): Boolean; External 'CheckMD5@files:ISMD5.dll stdcall';

Function Size64(Hi, Lo: Integer): Extended;
begin
  Result:= Lo;
  if Lo<0 then Result:= Result + $7FFFFFFF + $7FFFFFFF + 2;
  For Hi:= Hi-1 DownTo 0 do Result:= Result + $7FFFFFFF + $7FFFFFFF + 2;
end;

Function GetFileSize(const FileName: String): Extended;
var
  FSR: TFindRec;
begin
  Result:= 0;
  if FindFirst(FileName, FSR) then
    Try
      if FSR.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then Result:= Size64(FSR.SizeHigh, FSR.SizeLow) div (1024*1024);
      Finally
      FindClose(FSR);
    end;
end;

Function Exists(const FileName: string): Extended;
var
  Size: Extended;
begin
  if FileExists(FileName) then begin
    Size:= GetFileSize(FileName);
    TSize:= TSize + Size;
    Total:= Total + 1;
  end;
  Result:= Size;
end;

Function MD5Progress(Progress: Longword): Boolean;
begin
  MD5PB.Position:= TotalProgress + (Progress * CurSize div Trunc(TSize)) + 1;
  CheckMD5Label3.Caption:= FmtMessage('%1.%2 %', [IntToStr(MD5PB.Position div 10), chr(48 + MD5PB.Position mod 10)]);
  CheckMD5Label4.Caption:= FmtMessage(ExpandConstant('{cm:GSize}'), [MbOrTb(Trunc(TSize) * MD5PB.Position div 1000), MbOrTb(TSize)]);
  MainMD5Form.Caption:= FmtMessage(ExpandConstant('{cm:Check2}'), [CurFilename, CheckMD5Label3.Caption]);
  Application.ProcessMessages;
  SetTaskBarProgressValue((TotalProgress + (Progress * CurSize div Trunc(TSize)) + 1) div 10);
  if CloseForm then Result:= False else Result:= True;
end;

Function CheckMD(FileName, MD5: String): Boolean;
begin
  TotalProgress:= MD5PB.Position;
  Result:= True;
  if FileExists(FileName) then begin
    CurFilename:= ExtractFilename(FileName);
    CurN:= CurN+1;
    CheckMD5Label2.Caption:= FmtMessage(ExpandConstant('{cm:Foundfiles}'), [IntToStr(CurN), IntToStr(Total)]);
    if GetFileSize(FileName)*(1024*1024) <> 0 then begin
      CurSize:= Trunc(GetFileSize(FileName));
      CheckMD5Label.Caption:= FmtMessage(ExpandConstant('{cm:Comparing}'), [CurFilename, MbOrTb(CurSize)]);
      Result:= CheckMD5(FileName, PAnsiChar(MD5), @MD5Progress);
    end else begin
      MainMD5Form.Free;
      Result:= False;
    end;
  end;
end;

Procedure BtnShow();
begin
  BtnSetEnabled(hNextBtn, True);
  BtnSetEnabled(hMD5Btn, True);
  BtnSetEnabled(Min, True);
  BtnSetEnabled(CloseBtn, True);
end;

Procedure BtnHide();
begin
  BtnSetEnabled(hNextBtn, False);
  BtnSetEnabled(hMD5Btn, False);
  BtnSetEnabled(Min, False);
  BtnSetEnabled(CloseBtn, False);
  BtnSetVisibility(hMD5Btn, False);
  ContinueInstallMD5:= True;
end;

//******************************************************** [Форма Выхода - Начало] ********************************************************\\
Procedure MD5FormClose(Sender: TObject; var CanClose: Boolean);
begin
  MainMD5Form.Hide;
  CanClose:= False;

  ExitForm:= CreateCustomForm();
  with ExitForm do begin
    ClientWidth:= ScaleX(360);
    ClientHeight:= ScaleY(150);
    Caption:= ExpandConstant('{cm:Close1}');
    Ico:= TNewIconImage.Create(ExitForm);

    with Ico do begin
      Parent:= ExitForm;
      Left:= ScaleX(20);
      Top:= ScaleY(40);
      Icon.Handle:= ID_QUESTION;
    end;

    with TBevel.Create(ExitForm) do begin
      SetBounds(ScaleX(0), ScaleY(105), ScaleY(ExitForm.Width), ScaleY(2));
      Parent:= ExitForm;
    end;

    with TNewStaticText.Create(ExitForm) do begin
      SetBounds(ScaleX(65), ScaleY(25), ScaleX(278), ScaleY(60));
      AutoSize:= False;
      WordWrap:= True;
      Caption:= ExpandConstant('{cm:Close}');
      Parent:= ExitForm;
    end;

    CancelButton:= TButton.Create(ExitForm);
    with CancelButton do begin
      SetBounds(ScaleX(MainMD5Form.Width - Width - 15), ScaleY(MainMD5Form.Height - Height * 2 - 13), ScaleX(75), ScaleY(23));
      Caption:= ExpandConstant('{cm:No}');
      ModalResult:= mrCancel;
      Parent:= ExitForm;
      Cursor:= CrHand;
    end;

    OkButton:= TButton.Create(ExitForm);
    with OkButton do begin
      SetBounds(ScaleX(CancelButton.Left - Width - 5), ScaleY(CancelButton.Top), ScaleX(CancelButton.Width), ScaleY(CancelButton.Height));
      Caption:= ExpandConstant('{cm:Yes}');
      ModalResult:= mrOk;
      Parent:= ExitForm;
      Cursor:= CrHand;
    end;

    ActiveControl:= CancelButton;
    Center;
  end;

  if ExitForm.ShowModal() = mrCancel then begin
    CloseForm:= False;
    MainMD5Form.Show;
  end else begin
    CloseForm:= True;
    MainMD5Form.Hide;
    BtnShow();
  end;
end;

Procedure CBClick(Sender: TObject);
begin
  MD5FormClose(Sender, CanClose);
end;
//******************************************************** [Форма "Выход" - Конец] ********************************************************\\

//******************************************************** [Основная Форма - Начало] ********************************************************\\
Procedure MD5Form(Sender: TObject);
begin
  MainMD5Form:= CreateCustomForm();
  with MainMD5Form do begin
    FormStyle := FsStayOnTop;
    ClientWidth:= ScaleX(360);
    ClientHeight:= ScaleY(150);
    OnCloseQuery:= @MD5FormClose;
    Center;

    with TLabel.Create(MainMD5Form) do begin
      SetBounds(ScaleX(5), ScaleY(5), ScaleX(350), ScaleY(15));
      Caption:= ExpandConstant('{cm:Wait}');
      Transparent:= True;
      Parent:= MainMD5Form;
    end;

    CheckMD5Label:= TLabel.Create(MainMD5Form);
    with CheckMD5Label do begin
      SetBounds(ScaleX(5), ScaleY(25), ScaleX(350), ScaleY(15));
      Transparent:= True;
      Parent:= MainMD5Form;
    end;

    CheckMD5Label2:= TLabel.Create(MainMD5Form);
    with CheckMD5Label2 do begin
      SetBounds(ScaleX(5), ScaleY(65), ScaleX(300), ScaleY(15));
      Transparent:= True;
      Parent:= MainMD5Form;
    end;

    CheckMD5Label3:= TLabel.Create(MainMD5Form);
    with CheckMD5Label3 do begin
      SetBounds(ScaleX(240), ScaleY(70), ScaleX(50), ScaleY(15));
      Transparent:= True;
      Font.Name:= 'Arial';
      Font.Size:= 14;
      Parent:= MainMD5Form;
    end;

    CheckMD5Label4:= TLabel.Create(MainMD5Form);
    with CheckMD5Label4 do begin
      SetBounds(ScaleX(5), ScaleY(85), ScaleX(300), ScaleY(15));
      Transparent:= True;
      Parent:= MainMD5Form;
    end;

    MD5PB:= TNewProgressBar.Create(MainMD5Form);
    with MD5PB do begin
      Min:= 0;
      Max:= 1000;
      SetBounds(ScaleX(5), ScaleY(45), ScaleX(350), ScaleY(15));
      Parent:= MainMD5Form;
    end;

    with TBevel.Create(MainMD5Form) do begin
      SetBounds(ScaleX(0), ScaleY(105), ScaleX(MainMD5Form.Width), ScaleY(2));
      Parent:= MainMD5Form;
    end;

    SkipButton:= TButton.Create(MainMD5Form);
    with SkipButton do begin
      SetBounds(ScaleX(MainMD5Form.Width - Width - 15), ScaleY(MainMD5Form.Height - Height * 2 - 13), ScaleX(75), ScaleY(23));
      Caption:= ExpandConstant('{cm:Skip}');
      OnClick:= @CBClick;
      Parent:= MainMD5Form;
      Cursor:= CrHand;
    end;
  end;
  MainMD5Form.Show;
end;
//******************************************************** [Основная Форма - Конец] ********************************************************\\

//******************************************************** [Форма Ошибки - Начало] ********************************************************\\
Procedure MD5FormError(Sender: TObject);
begin
  ErrorForm:= CreateCustomForm();
  with ErrorForm do begin
    ClientWidth:= ScaleX(360);
    ClientHeight:= ScaleY(150);
    Caption:= FmtMessage(ExpandConstant('{cm:ErrorM1}'), [CurFilename]);
    Ico:= TNewIconImage.Create(ErrorForm);

    with Ico do begin
      Parent:= ErrorForm;
      Left:= ScaleX(20);
      Top:= ScaleY(40);
      Icon.Handle:= ID_HAND;
    end;

    with TBevel.Create(ErrorForm) do begin
      SetBounds(ScaleX(0), ScaleY(105), ScaleX(ErrorForm.Width), ScaleY(2));
      Parent:= ErrorForm;
    end;

    with TNewStaticText.Create(ErrorForm) do begin
      SetBounds(ScaleX(65), ScaleY(35), ScaleX(278), ScaleY(60));
      AutoSize:= False;
      WordWrap:= True;
      Caption:= ExpandConstant('{cm:Error}');
      Parent:= ErrorForm;
    end;

    ErrOKButton:= TButton.Create(ErrorForm);
    with ErrOKButton do begin
      SetBounds(ScaleX(MainMD5Form.Width - Width - 15), ScaleY(MainMD5Form.Height - Height * 2 - 13), ScaleX(75), ScaleY(23));
      Caption:= ExpandConstant('{cm:OK}');
      ModalResult:= mrCancel;
      Parent:= ErrorForm;
      Cursor:= CrHand;
    end;

    ActiveControl:= ErrOKButton;
    Center;
  end;

  if ErrorForm.ShowModal() = mrCancel then BtnShow;
end;
//******************************************************** [Форма Ошибки - Конец] ********************************************************\\

//******************************************************** [Проверка MD5 - Начало] ********************************************************\\
Procedure MD5Hash(Sender: TObject);
begin
  MD5();
  BtnHide();
  For i:= 1 to 100 do Exists(ExpandConstant(Path[i]));
  MD5Form(Sender);

  For i:= 1 to Total + 1 do begin
    MD5Error:= True;
    if not CheckMD(ExpandConstant(Path[i]), MD5Value[i]) then Break;
    MD5Error:= False;
  end;

  if not CloseForm and not MD5Error then begin
    MainMD5Form.Hide;
    BtnShow();
  end;

  if not CloseForm and MD5Error then begin
    MainMD5Form.Hide
    MD5FormError(Sender);
  end;
end;
//******************************************************** [Проверка MD5 - Конец] ********************************************************\\