[Code]
Procedure IconClick();
begin
  SoundClickPlay();
end;



Function IconDP: Boolean;
begin
  Result := BtnGetChecked(hIconDPCheckBox);
end;

Function IconGroup: Boolean;
begin
  Result := BtnGetChecked(hIconGroupCheckBox);
end;

Function Soft: Boolean;
begin
  Result := BtnGetChecked(hSoftCheckBox);
end;



Procedure IconLabelClick(Sender: TObject);
begin
  BtnSetChecked(hIconDPCheckBox, not BtnGetChecked(hIconDPCheckBox));
  SoundClickPlay();
end;

Procedure IconGroupLabelClick(Sender: TObject);
begin
  BtnSetChecked(hIconGroupCheckBox, not BtnGetChecked(hIconGroupCheckBox));
  SoundClickPlay();
end;

Procedure SoftLabelClick(Sender: TObject);
begin
  BtnSetChecked(hSoftCheckBox, not BtnGetChecked(hSoftCheckBox));
  SoundClickPlay();
end;