[Code]
Function TLabelCreate(WND: TWinControl; L, T, W, H, FontSize: Integer; Text, FontName: String; FontColor: TColor; FontStyle: TFontStyles; VAutoSize: Boolean; VAlignment: TAlignment; ClickEvent: TNotifyEvent; MouseDownEvent: TMouseEvent): TLabel;
begin
  Result := TLabel.Create(WND);
  With Result do begin
    Parent := WND;
    SetBounds(ScaleX(L), ScaleY(T), ScaleX(W), ScaleY(H));
    AutoSize := VAutoSize;
    Alignment := VAlignment;
    Transparent := True;
    WordWrap := True;
    Caption := Text;
    OnClick := ClickEvent;
    OnMouseDown := MouseDownEvent;
    With Font do begin
      Name := FontName;
      Size := FontSize;
      Color := FontColor;
      Style := FontStyle;
    end;
  end;
end;

Procedure TLabelVisible(LabelName: TLabel; Value: Boolean);
begin
  LabelName.Visible := Value;
end;

Procedure TLabelColor(LabelName: TLabel; FontColor: TColor);
begin
  LabelName.Font.Color := FontColor;
end;

Procedure TLabelText(LabelName: TLabel; Text: String);
begin
  LabelName.Caption := Text;
end;

Procedure TLabelWordWrap(LabelName: TLabel; Value: Boolean);
begin
  LabelName.Visible  := False;
  LabelName.WordWrap := Value;
  LabelName.Visible  := True;
end;
