[Code]
Function IconDP: Boolean; begin Result:= BtnGetChecked(IconBtn); end;
Function IconGroup: Boolean; begin Result:= BtnGetChecked(IconGroupBtn); end;
Procedure IconClick(hBtn:HWND); var Check: Boolean; begin Check:= BtnGetChecked(hBtn); end;
Procedure IconGroupClick(hBtn:HWND); var Check: Boolean; begin Check:= BtnGetChecked(hBtn); end;
Procedure IconLabelClick(Sender:TObject); begin BtnSetChecked(IconBtn, not BtnGetChecked(IconBtn)); IconClick(IconBtn); end;
Procedure IconGroupLabelClick(Sender:TObject); begin BtnSetChecked(IconGroupBtn, not BtnGetChecked(IconGroupBtn)); IconClick(IconGroupBtn); end;

Function Soft: Boolean; begin Result:= BtnGetChecked(hSoftBtn); end;
Procedure SoftClick(hBtn:HWND); var Check: Boolean; begin Check:= BtnGetChecked(hBtn); end;
Procedure SoftLabelClick(Sender:TObject); begin BtnSetChecked(hSoftBtn, not BtnGetChecked(hSoftBtn)); SoftClick(hSoftBtn); end;