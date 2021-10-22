[Types]
Name: Full; Description: "Полная установка"; Flags: ISCustom

[Components]
Name: "GM"; Description: "{#GameName}"; Types: Full; Flags: Fixed
Name: "GM\INT"; Description: "Язык Интерфейса:"; Types: Full; Flags: Fixed
Name: "GM\INT\LG0"; Description: "RUS"; Flags: Exclusive

Name: "GM\VOI"; Description: "Язык Озвучки:"; Types: Full; Flags: Fixed
Name: "GM\VOI\LG1"; Description: "RUS"; Flags: Exclusive

Name: "GM\CR"; Description: "Таблетка:"; Types: Full; Flags: Fixed
Name: "GM\CR\CR1"; Description: "Присутствует"; Flags: Exclusive


[Files]
Source: "InstallFiles\ImageFiles\Components\*.*"; DestDir: "{tmp}"; Flags: DontCopy

[Code]
var
  MainComponentsForm: TSetupForm;
  ShadowImage, CompImage, MoveComp: LongInt;
  hOKButtonComponentsForm, hCloseButtonComponentsForm: HWND;
  MainCompLabel, cEmptyLabel: TLabel;

//================================================= [ Основная Форма ] =================================================\\
Procedure CompFrameMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MainComponentsForm.SetFocus;
  ReleaseCapture;
  SendMessage(MainComponentsForm.Handle, $0112, $F012, 0);
end;

Function MoveFunc(h: HWND; Msg, wParam, lParam: longint): LongInt;
begin
  if Msg = WM_MOVE then begin
    SetWindowPos(WizardForm.Handle, 0, MainComponentsForm.Left - (WizardForm.ClientWidth / 2) + (MainComponentsForm.ClientWidth / 2), MainComponentsForm.Top - (WizardForm.ClientHeight / 2) + (MainComponentsForm.ClientHeight / 2), 0, 0, $415);
  end;
  Result := CallWindowProc(MoveComp, h, Msg, wParam, lParam);
end;

Procedure OKButtonClick();
begin
  SoundClickPlay();
  MainComponentsForm.Close;
end;

Procedure CompenentsFormCreate();
begin
  MainComponentsForm := CreateCustomForm();
  with MainComponentsForm do begin
    BorderStyle := bsNone;
    FormStyle := FsStayOnTop;
    ClientWidth := ScaleX(450);
    ClientHeight := ScaleY(280);
    CenterInsideControl(WizardForm, False);
    Hide;
  end;

  with WizardForm.ComponentsList do begin
    Parent := MainComponentsForm;
    SetBounds(ScaleX(15), ScaleY(35), ScaleX(420), ScaleY(205));
    Color := $FFFFFF;
    BorderStyle := bsNone;
    TreeViewStyle := True;
    Font.Color := $262626;
    Hide;
  end;

//  Кнопки
  hCloseButtonComponentsForm:= BtnCreate(MainComponentsForm.Handle, ScaleX(428), ScaleY(10), ScaleX(12), ScaleY(12), 'CloseComp.png', 1, False);
  BtnSetCursor(hCloseButtonComponentsForm, GetSysCursorHandle(32649));
  BtnSetEvent(hCloseButtonComponentsForm, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(hCloseButtonComponentsForm, BtnClickEventID, CallBackAddr('OKButtonClick'));

  hOKButtonComponentsForm := BtnCreate(MainComponentsForm.Handle, ScaleX(378), ScaleY(253), ScaleX(65), ScaleY(20), 'ButtonComp.png', 1, False);
  BtnSetFont(hOKButtonComponentsForm, BtnFont.Handle);
  BtnSetFontColor(hOKButtonComponentsForm, $262626, $262626, $262626, $262626);
  BtnSetCursor(hOKButtonComponentsForm, GetSysCursorHandle(32649));
  BtnSetEvent(hOKButtonComponentsForm, BtnMouseEnterEventID, CallBackAddr('SoundEnterPlay'));
  BtnSetEvent(hOKButtonComponentsForm, BtnClickEventID, CallBackAddr('OKButtonClick'));
  BtnSetText(hOKButtonComponentsForm, 'ОК');
//  Кнопки

// Лейблы
  MainCompLabel := TLabelCreate(MainComponentsForm, 15, 7, 300, 18, 10, CustomMessage('MainCompLabel'), {#FontName}, $262626, [], False, taLeftJustify, nil, nil);
  TLabelWordWrap(MainCompLabel, False);

  cEmptyLabel := TLabelCreate(MainComponentsForm, 0, 0, 450, 30, 10, '', {#FontName}, $262626, [], False, taLeftJustify, nil, @CompFrameMouseDown);
// Лейблы

// Изображения
  ShadowImage := ImgLoad(WizardForm.Handle, 'ShadowComp.png',  ScaleX(0), ScaleY(0), ScaleX(1000), ScaleY(522), True, False);
  CompImage := ImgLoad(MainComponentsForm.Handle, 'ComponentsForm.png', ScaleX(0), ScaleY(0), ScaleX(450),  ScaleY(280), True, True);
  ImgSetVisibility(ShadowImage, True);
  ImgSetVisibility(CompImage, True);
  ImgApplyChanges(WizardForm.Handle);
  ImgApplyChanges(MainComponentsForm.Handle);
// Изображения

  SetClassLong(MainComponentsForm.Handle, -26, GetClassLong(MainComponentsForm.Handle, -26) or $200);

  MoveComp := SetWindowLong(MainComponentsForm.Handle, GWL_WNDPROC, CallBackAddr('MoveFunc'));

  WizardForm.ComponentsList.Show;
  MainComponentsForm.ShowModal;

  WizardForm.ComponentsList.Checked[0] := False;
  SetWindowlong(MainComponentsForm.Handle, GWL_WNDPROC, MoveComp);
end;
//================================================= [ Основная Форма ] =================================================\\

Procedure ComponentsForm();
begin
  Try
  SoundClickPlay();
  // Выполняем различные действия с WizardForm
    WizardForm.Enabled := False;
  // Выполняем различные действия с WizardForm

  // Создаём форму
    CompenentsFormCreate();
  // Создаём форму
  Finally
  // Выполняем различные действия с WizardForm
    WizardForm.Enabled := True;
    ImgSetVisibility(ShadowImage, False);
    ImgApplyChanges(WizardForm.Handle);
  // Выполняем различные действия с WizardForm

  // Освобождаем все существующие формы
    if MainComponentsForm <> nil then MainComponentsForm.Close;
  // Освобождаем все существующие формы

  // Выгружаем изображения из памяти
    ImgRelease(CompImage);
    ImgRelease(ShadowImage);
  // Выгружаем изображения из памяти
  End;
end;
