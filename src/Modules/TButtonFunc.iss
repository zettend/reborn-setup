[Code]
Function TButtonCreate(WND: TWinControl; L, T, W, H: Integer; FileName: String; Font: Cardinal; Text, BtnMouseEnter, BtnClick: String): HWND;
begin
  Result := BtnCreate(WizardForm.Handle, ScaleX(L), ScaleY(T), ScaleX(W), ScaleY(H), FileName, 1, False);

  BtnSetCursor(Result, GetSysCursorHandle(32649));

  if Font <> -1 then
    BtnSetFont(Result, Font);

  if Text <> '' then
    BtnSetText(Result, Text);

  if BtnMouseEnter <> '' then
    BtnSetEvent(Result, BtnMouseEnterEventID, CallBackAddr(BtnMouseEnter));

  if BtnClick <> '' then
    BtnSetEvent(Result, BtnClickEventID, CallBackAddr(BtnClick));
end;

Procedure StandartBtnHide();
begin
  With WizardForm do begin
    NextButton.Width := 0;
    NextButton.Height := 0;
    BackButton.Width := 0;
    BackButton.Height := 0;
    CancelButton.Width := 0;
    CancelButton.Height := 0;
    DirBrowseButton.Width := 0;
    DirBrowseButton.Height := 0;
  end;
end;
