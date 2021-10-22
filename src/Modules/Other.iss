[Code]
Type
  #ifdef UNICODE
    PChar = PAnsiChar;
  #endif
  #ifndef UNICODE
    AnsiChar = Char;
  #endif

Function MbOrTb(Float: Extended): String;
begin
  if Float < 1024 then Result := FormatFloat('0', Float) + ExpandConstant(' {cm:MB}') else
   if Float/1024 < 1024 then Result := Format('%.2n', [Float/1024]) + ExpandConstant(' {cm:GB}') else
     Result := Format('%.2n', [Float/(1024*1024)]) + ExpandConstant(' {cm:TB}');
  StringChange(Result, ',', '.');
end;

Function GetDriveType(lpRootPathName: PAnsiChar): Cardinal; external 'GetDriveTypeA@kernel32.dll stdcall';
Function GetLogicalDrives: DWORD; external 'GetLogicalDrives@kernel32.dll stdcall';
Function NoSD(S: String): String;
var
  x, bit: Integer; tp: Cardinal; SD: String;
begin
  SD := ExpandConstant('{sd}');
  Result := SD;
  x := GetLogicalDrives;
  if x <> 0 then for i:= 1 to 64 do begin
    bit := x and 1;
    if bit = 1 then begin
      tp := GetDriveType(PChar(Chr(64 + i) + ':'));
      if tp = 3 then
      if Chr(64 + i) <> Copy(SD, 1, 1) then begin
        Result := Chr(64 + i) + ':';
        Break;
      end;
    end;
    x := x shr 1;
  end;
end;

Function ShouldSkipPage(PageID: Integer): Boolean;
begin
  if (PageID = wpSelectTasks) or (PageID = wpSelectComponents) then Result:= True;
end;

Procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
 Confirm := False;
 Cancel := True;
end;

//Поиск файлов в папке установки:
Function FindFirstNotEmptyFile(FromDir: String; Mask: String): LongWord;
var
  FSR, DSR: TFindRec;
  FindResult: Boolean;
begin
  Result := 0;
  FindResult := FindFirst(AddBackSlash(FromDir) + Mask, FSR);
  While FindResult do begin
    if FSR.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then Result:= FSR.SizeLow + FSR.SizeHigh;
    if Result > 0 then Exit;
    FindResult := FindNext(FSR);
  end;
  if (Result = 0) then begin
    FindResult := FindFirst(AddBackSlash(FromDir)+ '*.*', DSR);
    While FindResult do begin
      if ((DSR.Attributes and FILE_ATTRIBUTE_DIRECTORY) = FILE_ATTRIBUTE_DIRECTORY) and not ((DSR.Name = '.') or (DSR.Name = '..')) then begin
        Result := FindFirstNotEmptyFile(AddBackSlash(FromDir) + DSR.Name, Mask);
        Break;
      end;
      FindResult := FindNext(DSR);
    end;
  end;
end;
//Поиск файлов в папке установки.

//Поиск Русских символов в пути:
Function ISAnsi(S: String): Boolean;
var
  S1, S2: String;
begin
  S1 := AnsiUpperCase(S);
  S2 := UpperCase(S);
  if CompareStr(S1, S2) = 0 then begin
    S1 := Lowercase(S);
    S2 := AnsiLowerCase(S);
    if CompareStr(S1, S2) = 0 then Result := True;
  end;
end;
//Поиск Русских символов в пути.

Function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result:= True;
  if CurPageID = wpSelectDir then begin
  #ifdef RusError
    //Поиск Русских символов в пути:
    if not (ISAnsi(WizardForm.DirEdit.Text)) then begin
      MsgBoxEx(WizardForm.Handle, CustomMessage('NotRus1')   + #13 + CustomMessage('NotMsgBox'), CustomMessage('NotRus2')   + ' | ', MB_ICONERROR, 0, 10);
      Result:= False;
    end;
    //Поиск Русских символов в пути.
  #endif

    //Поиск файлов в папке установки:
    if FindFirstNotEmptyFile(Trim(WizardForm.DirEdit.Text) + '\', '*.*') <> 0 then begin
      MsgBoxEx(WizardForm.Handle, CustomMessage('NotFold1')  + #13 + CustomMessage('NotMsgBox'), CustomMessage('NotFold2')  + ' | ', MB_ICONERROR, 0, 10);
      Result:= False;
    end;
    //Поиск файлов в папке установки.

    //Запрет установки на съемный диск:
    if GetDriveType(ExtractFileDrive(WizardForm.DirEdit.Text)) = 2 then begin
      MsgBoxEx(WizardForm.Handle, CustomMessage('NotFlash1') + #13 + CustomMessage('NotMsgBox'), CustomMessage('NotFlash2') + ' | ', MB_ICONERROR, 0, 10);
      Result:= False;
    end;
    //Запрет установки на съемный диск.
  end;
end;