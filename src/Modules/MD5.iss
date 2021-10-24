[Files]
Source: InstallFiles\MD5Files\*.*;  Flags: DontCopy
Source: InstallFiles\MD5Files\ImageMD5\*.*;  Flags: DontCopy

[Code]
Type
  TMD5CallBack = Function (Progress: LongWord): Boolean;

var
  MainMD5Form, ErrorMD5Form, CloseMD5Form: TSetupForm;
  hMD5BreakBtn, hMD5CloseBtn, hErrorMD5YES, hErrorMD5NO, hErrorMD5Close, hCloseMD5YES, hCloseMD5NO, hCloseMD5Close: HWND;
  Total, CurN, MoveMD5, PBPos, MD5MainFromImg, MD5ErrorFormImg, MD5CloseFormImg, MD5ShadowImage: LongInt;
  MD5ProgressBar: TImgPB;
  MD5Error, Close: Boolean;
  TotalProgress, CurSize: LongWord;
  TSize, TempSize: Extended;
  EmptyMD5Label: TLabel;
  MainMD5FormLabel: Array [0..4] of TLabel;
  Path, MD5Value: Array [1..100] of String;

Procedure MD5PathAndValue();
begin
//-----------------------------------------------------------------------------------------
  Path[1] := '{src}\Soft-1.bin'; //* Путь и название 1 файла  *\\
  MD5Value[1] := '56DAF8C3968BFA41D0F421683EDC363F';   //* Хэш-сумма 1 файла *\\
//-----------------------------------------------------------------------------------------
  Path[2] := '{src}\Data-1.bin';    //* Путь и название 2 файла  *\\
  MD5Value[2] := '12402765CF7729A725EF998FEE9C0905';   //* Хэш-сумма 2 файла *\\
//-----------------------------------------------------------------------------------------
  Path[3] := '{src}\Data-2.bin';    //* Путь и название 3 файла  *\\
  MD5Value[3] := '7F96C759A7050EAE8C154EB43EF94F83';   //* Хэш-сумма 3 файла *\\
//-----------------------------------------------------------------------------------------
  //Path[4]:= '{src}\Video-1.bin';   //* Путь и название 4 файла  *\\
  //MD5Value[4]:= 'C1FD455E79E125EA97CAB82298A5923E';   //* Хэш-сумма 4 файла *\\
//-----------------------------------------------------------------------------------------
  //Path[5]:= '{src}\Video-1.bin';    //* Путь и название 5 файла  *\\
 // MD5Value[5]:= 'FD3DBF0AFB165FA7ACCD687E5E4321A5';   //* Хэш-сумма 5 файла *\\
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

//================================================= [ Проверка MD5 ] =================================================\\
Function CheckMD5(Filename: PAnsiChar; MD5: PAnsiChar; CallBack: TMD5CallBack): Boolean; External 'CheckMD5@files:ISMD5.dll StdCall';

Function Size64(Hi, Lo: Integer): Extended;
begin
  Result := Lo;
  if Lo < 0 then Result:= Result + $7FFFFFFF + $7FFFFFFF + 2;
  For Hi := Hi - 1 DownTo 0 do Result := Result + $7FFFFFFF + $7FFFFFFF + 2;
end;

Function GetFileSize(const FileName: String): Extended;
var
  FSR: TFindRec;
begin
  Result := 0;
  if FindFirst(FileName, FSR) then
    Try
      if FSR.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then Result := Size64(FSR.SizeHigh, FSR.SizeLow) DIV (1024 * 1024);
    Finally
      FindClose(FSR);
    end;
end;

Procedure FileCountAndSize(const FileName: String);
var
  Size: Extended;
begin
  if FileExists(FileName) then begin
    Size  := GetFileSize(FileName);
    TSize := TSize + Size;
    Total := Total + 1;
  end;
end;

Function MD5Progress(Progress: LongWord): Boolean;
begin
  PBPos := TotalProgress + (Progress * CurSize DIV Trunc(TSize)) + 1;
  if PBPos > 1000 then PBPos := 1000;
  TempSize := TSize * PBPos DIV 1024;
  if TempSize > TSize then TempSize := TSize;

  TLabelText(MainMD5FormLabel[0], FmtMessage('%1.%2 %', [IntToStr(PBPos DIV 10), CHR(48 + PBPos MOD 10)]));
  TLabelText(MainMD5FormLabel[4], FmtMessage(ExpandConstant('{cm:MainMD5FormLabel4}'), [MbOrTb(TempSize), MbOrTb(TSize)]));

  ImgPBSetPosition(MD5ProgressBar, PBPos);
  SetTaskBarProgressValue(PBPos DIV 10);
  ImgApplyChanges(MainMD5Form.Handle);

  Application.ProcessMessages;
  if not Close then Result := True else Result := False;
end;

Function CheckMD(FileName, MD5: String): Boolean;
var
  FileNameSize: Extended;
begin
  TotalProgress := PBPos;
  Result := True;
  if FileExists(FileName) then begin
    CurN := CurN + 1;
    TLabelText(MainMD5FormLabel[3], FmtMessage(ExpandConstant('{cm:MainMD5FormLabel3}'), [IntToStr(CurN), IntToStr(Total)]));
    FileNameSize := GetFileSize(FileName);
    if FileNameSize <> 0 then begin
      CurSize := Trunc(FileNameSize);
      TLabelText(MainMD5FormLabel[2], FmtMessage(ExpandConstant('{cm:MainMD5FormLabel2}'), [ExtractFileName(FileName), MbOrTb(CurSize)]));
      Result := CheckMD5(FileName, PAnsiChar(MD5), @MD5Progress);
    end else begin
      Result := False;
    end;
  end;
end;

Procedure ClearVars();
begin
  Close := False; MD5Error := True;
  Total := 0; CurN := 0; PBPos := 0; CurSize := 0; TotalProgress := 0; TSize := 0;
end;
//================================================= [ Проверка MD5 ] =================================================\\

//================================================= [ Форма отмены ] =================================================\\
Procedure CloseMD5NOClick();
begin
  SoundClickPlay();
  MainMD5Form.Show;
  CloseMD5Form.Close;
end;

Procedure CloseMD5YESClick();
begin
  SoundClickPlay();
  WizardForm.Enabled := True;
  Close := True;
  CloseMD5Form.Close;
end;

Procedure CloseFormCreate();
begin
  CloseMD5Form := CreateCustomForm();
  with CloseMD5Form do begin
    BorderStyle := bsNone;
    FormStyle := FsStayOnTop;
    ClientWidth := ScaleX(450);
    ClientHeight := ScaleY(136);
    CenterInsideControl(MainMD5Form, False);
    Hide;
  end;

// Кнопки
  hCloseMD5Close := BtnCreate(CloseMD5Form.Handle, ScaleX(422), ScaleY(12), ScaleX(12), ScaleY(12), 'MD5CloseBtn.png', 1, False);
  BtnSetFont(hCloseMD5Close, BtnFont.Handle);
  BtnSetEvent(hCloseMD5Close, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(hCloseMD5Close, BtnClickEventID, CallBackAddr('CloseMD5NOClick'));
  BtnSetCursor(hCloseMD5Close, GetSysCursorHandle(32649));

  hCloseMD5YES := BtnCreate(CloseMD5Form.Handle, ScaleX(278), ScaleY(100), ScaleX(65), ScaleY(20), 'MD5BreakBtn.png', 1, False);
  BtnSetFont(hCloseMD5YES, BtnFont.Handle);
  BtnSetFontColor(hCloseMD5YES, $262626, $262626, $262626, $262626);
  BtnSetEvent(hCloseMD5YES, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(hCloseMD5YES, BtnClickEventID, CallBackAddr('CloseMD5YESClick'));
  BtnSetCursor(hCloseMD5YES, GetSysCursorHandle(32649));
  BtnSetText(hCloseMD5YES, 'Да');

  hCloseMD5NO := BtnCreate(CloseMD5Form.Handle, ScaleX(358), ScaleY(100), ScaleX(65), ScaleY(20), 'MD5BreakBtn.png', 1, False);
  BtnSetFont(hCloseMD5NO, BtnFont.Handle);
  BtnSetFontColor(hCloseMD5NO, $262626, $262626, $262626, $262626);
  BtnSetEvent(hCloseMD5NO, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(hCloseMD5NO, BtnClickEventID, CallBackAddr('CloseMD5NOClick'));
  BtnSetCursor(hCloseMD5NO, GetSysCursorHandle(32649));
  BtnSetText(hCloseMD5NO, 'Нет');
// Кнопки

// Изображение
  MD5CloseFormImg := ImgLoad(CloseMD5Form.Handle, 'MD5CloseForm.png', ScaleX(0), ScaleY(0), ScaleX(450),  ScaleY(136), True, True);
  ImgSetVisibility(MD5CloseFormImg, True);
  ImgApplyChanges(CloseMD5Form.Handle);
// Изображение

  SetClassLong(CloseMD5Form.Handle, -26, GetClassLong(CloseMD5Form.Handle, -26) or $200);
  CloseMD5Form.ShowModal;
end;
//================================================= [ Форма отмены ] =================================================\\

//================================================= [ Основная форма ] =================================================\\
Function MoveMD5Func(h: HWND; Msg, wParam, lParam: longint): LongInt;
begin
  if Msg = WM_MOVE then begin
    SetWindowPos(WizardForm.Handle, 0, MainMD5Form.Left - (WizardForm.ClientWidth / 2) + (MainMD5Form.ClientWidth / 2), MainMD5Form.Top - (WizardForm.ClientHeight / 2) + (MainMD5Form.ClientHeight / 2), 0, 0, $415);
  end;
  Result := CallWindowProc(MoveMD5, h, Msg, wParam, lParam);
end;

Procedure MD5FrameMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MainMD5Form.SetFocus;
  ReleaseCapture;
  SendMessage(MainMD5Form.Handle, $0112, $F012, 0);
end;

Procedure MD5BreakBtnClick();
begin
  SoundClickPlay();
  MainMD5Form.Hide;
  CloseFormCreate();
end;

Procedure MainFormCreate();
begin
  MainMD5Form := CreateCustomForm();
  with MainMD5Form do begin
    BorderStyle := bsNone;
    FormStyle := FsStayOnTop;
    ClientWidth := ScaleX(450);
    ClientHeight := ScaleY(208);
    CenterInsideControl(WizardForm, True);
    Hide;
  end;

// Кнопки
  hMD5CloseBtn := BtnCreate(MainMD5Form.Handle, ScaleX(422), ScaleY(12), ScaleX(12), ScaleY(12), 'MD5CloseBtn.png', 1, False);
  BtnSetFont(hMD5CloseBtn, BtnFont.Handle);
  BtnSetEvent(hMD5CloseBtn, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(hMD5CloseBtn, BtnClickEventID, CallBackAddr('MD5BreakBtnClick'));
  BtnSetCursor(hMD5CloseBtn, GetSysCursorHandle(32649));

  hMD5BreakBtn := BtnCreate(MainMD5Form.Handle, ScaleX(375), ScaleY(177), ScaleX(65), ScaleY(20), 'MD5BreakBtn.png', 1, False);
  BtnSetFont(hMD5BreakBtn, BtnFont.Handle);
  BtnSetFontColor(hMD5BreakBtn, $262626, $262626, $262626, $262626);
  BtnSetEvent(hMD5BreakBtn, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(hMD5BreakBtn, BtnClickEventID, CallBackAddr('MD5BreakBtnClick'));
  BtnSetCursor(hMD5BreakBtn, GetSysCursorHandle(32649));
  BtnSetText(hMD5BreakBtn, 'Отмена');
// Кнопки

// Изображение
  MD5MainFromImg := ImgLoad(MainMD5Form.Handle, 'MD5Form.png', ScaleX(0), ScaleY(0), ScaleX(450),  ScaleY(208), True, True);
  ImgSetVisibility(MD5MainFromImg, True);
  ImgApplyChanges(MainMD5Form.Handle);
// Изображение

// Прогресс бар
  MD5ProgressBar := ImgPBCreate(MainMD5Form.Handle, 'MD5PB0.png', 'MD5PB1.png', ScaleX(0), ScaleY(89), ScaleX(450), ScaleY(30));
  ImgPBVisibility(MD5ProgressBar, True);
// Прогресс бар

// Лейблы
  MainMD5FormLabel[0] := TLabelCreate(MainMD5Form, 212, 96,  348, 16, 11, '', {#FontName}, $ecf0f1, [], False, taLeftJustify, nil, nil);
  MainMD5FormLabel[1] := TLabelCreate(MainMD5Form, 12,  11,  348, 16, 10, '', {#FontName}, $262626, [], False, taLeftJustify, nil, nil);
  MainMD5FormLabel[2] := TLabelCreate(MainMD5Form, 20,  61,  368, 16, 10, '', {#FontName}, $262626, [], False, taLeftJustify, nil, nil);
  MainMD5FormLabel[3] := TLabelCreate(MainMD5Form, 20,  129, 348, 16, 10, '', {#FontName}, $262626, [], False, taLeftJustify, nil, nil);
  MainMD5FormLabel[4] := TLabelCreate(MainMD5Form, 20,  156, 348, 16, 10, '', {#FontName}, $262626, [], False, taLeftJustify, nil, nil);

  TLabelText(MainMD5FormLabel[1], CustomMessage('MainMD5FormLabel1'));
  EmptyMD5Label := TLabelCreate(MainMD5Form, 0, 0, 450, 30, 10, '', {#FontName}, $262626, [], False, taLeftJustify, nil, @MD5FrameMouseDown);
// Лейблы

  SetClassLong(MainMD5Form.Handle, -26, GetClassLong(MainMD5Form.Handle, -26) or $200);
  MoveMD5 := SetWindowLong(MainMD5Form.Handle, GWL_WNDPROC, CallBackAddr('MoveMD5Func'));
  WizardForm.Enabled := False;
  MainMD5Form.Show;
end;
//================================================= [ Основная форма ] =================================================\\

//================================================= [ Форма ошибки ] =================================================\\
Procedure ErrorMD5YESClick();
begin
  SoundClickPlay();
  ErrorMD5Form.Close;
end;

Procedure ErrorMD5NOClick();
begin
  SoundClickPlay();
  ErrorMD5Form.Close;
  Application.Terminate;
end;

Procedure ErrorFormCreate();
begin
  ErrorMD5Form := CreateCustomForm();
  with ErrorMD5Form do begin
    BorderStyle := bsNone;
    FormStyle := FsStayOnTop;
    ClientWidth := ScaleX(450);
    ClientHeight := ScaleY(136);
    CenterInsideControl(WizardForm, False);
    Hide;
  end;

// Кнопки
  hErrorMD5Close := BtnCreate(ErrorMD5Form.Handle, ScaleX(422), ScaleY(12), ScaleX(12), ScaleY(12), 'MD5CloseBtn.png', 1, False);
  BtnSetFont(hErrorMD5Close, BtnFont.Handle);
  BtnSetEvent(hErrorMD5Close, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(hErrorMD5Close, BtnClickEventID, CallBackAddr('ErrorMD5NOClick'));
  BtnSetCursor(hErrorMD5Close, GetSysCursorHandle(32649));

  hErrorMD5YES := BtnCreate(ErrorMD5Form.Handle, ScaleX(278), ScaleY(100), ScaleX(65), ScaleY(20), 'MD5BreakBtn.png', 1, False);
  BtnSetFont(hErrorMD5YES, BtnFont.Handle);
  BtnSetFontColor(hErrorMD5YES, $262626, $262626, $262626, $262626);
  BtnSetEvent(hErrorMD5YES, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(hErrorMD5YES, BtnClickEventID, CallBackAddr('ErrorMD5YESClick'));
  BtnSetCursor(hErrorMD5YES, GetSysCursorHandle(32649));
  BtnSetText(hErrorMD5YES, 'Да');

  hErrorMD5NO := BtnCreate(ErrorMD5Form.Handle, ScaleX(358), ScaleY(100), ScaleX(65), ScaleY(20), 'MD5BreakBtn.png', 1, False);
  BtnSetFont(hErrorMD5NO, BtnFont.Handle);
  BtnSetFontColor(hErrorMD5NO, $262626, $262626, $262626, $262626);
  BtnSetEvent(hErrorMD5NO, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(hErrorMD5NO, BtnClickEventID, CallBackAddr('ErrorMD5NOClick'));
  BtnSetCursor(hErrorMD5NO, GetSysCursorHandle(32649));
  BtnSetText(hErrorMD5NO, 'Нет');
// Кнопки

// Изображение
  MD5ErrorFormImg := ImgLoad(ErrorMD5Form.Handle, 'MD5ErrorForm.png', ScaleX(0), ScaleY(0), ScaleX(450),  ScaleY(136), True, True);
  ImgSetVisibility(MD5ErrorFormImg, True);
  ImgApplyChanges(ErrorMD5Form.Handle);
// Изображение

  SetClassLong(ErrorMD5Form.Handle, -26, GetClassLong(ErrorMD5Form.Handle, -26) or $200);
  ErrorMD5Form.ShowModal;
end;
//================================================= [ Форма ошибки ] =================================================\\

Procedure MD5CheckShow(Sender: TObject);
begin
  try
  // Звук при нажатии
    SoundClickPlay();
  // Звук при нажатии

  // Создаём основную форму
    MainFormCreate();
  // Создаём основную форму

  // Создаём тень
    MD5ShadowImage := ImgLoad(WizardForm.Handle, 'MD5Shadow.png',  ScaleX(0), ScaleY(0), ScaleX(1000), ScaleY(522), True, False);
    ImgSetVisibility(MD5ShadowImage, True);
    ImgApplyChanges(WizardForm.Handle);
  // Создаём тень

  // Запускаем проверку MD5
    MD5PathAndValue();
    For i := 1 to 100 do FileCountAndSize(ExpandConstant(Path[i]));
    For i := 1 to Total + 1 do begin
      MD5Error := True;
      if not CheckMD(ExpandConstant(Path[i]), MD5Value[i]) then Break;
      MD5Error := False;
    end;
  // Запускаем проверку MD5

  // Если произошла ошибка, то создаём форму ошибки
    if MD5Error and not Close then begin
      MainMD5Form.Hide;
      ErrorFormCreate();
    end;
  // Если произошла ошибка, то создаём форму ошибки
  finally
  // Выполняем различные действия с WizardForm
    WizardForm.Enabled := True;
    SetWindowlong(MainMD5Form.Handle, GWL_WNDPROC, MoveMD5);
    SetTaskBarProgressValue(0);
    ImgSetVisibility(MD5ShadowImage, False);
    ImgApplyChanges(WizardForm.Handle);
  // Выполняем различные действия с WizardForm

  // Освобождаем все существующие формы
    if MainMD5Form  <> nil then MainMD5Form.Free;
    if CloseMD5Form <> nil then CloseMD5Form.Free;
    if ErrorMD5Form <> nil then ErrorMD5Form.Free;
  // Освобождаем все существующие формы

  // Выгружаем изображения из памяти
    ImgRelease(MD5MainFromImg);
    ImgRelease(MD5ErrorFormImg);
    ImgRelease(MD5CloseFormImg);
    ImgRelease(MD5ShadowImage);
  // Выгружаем изображения из памяти

  // Очищаем переменные
    ClearVars();
  // Очищаем переменные
  end;
end;