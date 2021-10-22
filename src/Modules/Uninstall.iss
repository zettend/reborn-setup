[code]
Procedure InitializeUninstallProgressForm();
begin
  with UninstallProgressForm do begin
    Position := poScreenCenter;
    OuterNotebook.Hide;
    InnerNotebook.Hide;
    Bevel.Hide;
    BorderIcons := [];
    AutoScroll := False;
    ClientWidth := ScaleX(437);
    ClientHeight := ScaleY(41);
    Caption := 'Удаление — {#GameName}';
    with ProgressBar do begin
      SetBounds(ScaleX(10), ScaleY(11), ScaleX(417), ScaleY(18));
      Parent := UninstallProgressForm;
    end;
  end;
end;

//Удаление папки с игрой, если та, по каким-то причинам, не была удалена автоматически:
Procedure DelDir(Dir : String);
var
  R: Integer;
begin
  Exec('cmd.exe', ' /C RD /S /Q  ' + '"' + Dir + '"', ExpandConstant('{sys}'), SW_HIDE, ewWaitUntilTerminated, R);
end;
//Удаление папки с игрой, если та, по каким-то причинам, не была удалена автоматически.

//Удаление Сохранений
#ifdef DeleteSaved
  Procedure DeleteSaveGames();
  var
    MsgBoxVar: array [1..3] of Integer;

  begin
    #ifdef Save1
      if DirExists({#Save1}) then MsgBoxVar[1]:= 1;
    #endif
    #ifdef Save2
      if DirExists({#Save2}) then MsgBoxVar[2]:= 1;
    #endif
    #ifdef Save3
      if DirExists({#Save3}) then MsgBoxVar[3]:= 1;
    #endif

    #ifdef Save1
      if MsgBoxVar[1] = 1 then if MsgBox(ExpandConstant('{cm:DeleteSave}'), MBConfirmation, MB_YESNO) = IDYES then
        if not DelTree({#Save1}, True, True, True) then MsgBox('Папка не удалена!' + #13 + 'Папки не существует или она задействована...' + #13 + 'Путь: ' + {#Save1}, mbCriticalError, MB_OK);
    #endif
    #ifdef Save2
      if (MsgBoxVar[2] = 1) and (MsgBoxVar[1] = 0) then if MsgBox(ExpandConstant('{cm:DeleteSave}'), MBConfirmation, MB_YESNO) = IDYES then
        if not DelTree({#Save2}, True, True, True) then MsgBox('Папка не удалена!' + #13 + 'Папки не существует или она задействована...' + #13 + 'Путь: ' + {#Save2}, mbCriticalError, MB_OK);
      if (MsgBoxVar[2] = 1) and (MsgBoxVar[1] = 1) then
        if not DelTree({#Save2}, True, True, True) then MsgBox('Папка не удалена!' + #13 + 'Папки не существует или она задействована...' + #13 + 'Путь: ' + {#Save2}, mbCriticalError, MB_OK);
    #endif
    #ifdef Save3
      if (MsgBoxVar[3] = 1) and (MsgBoxVar[1] = 0) and (MsgBoxVar[2] = 0) then if MsgBox(ExpandConstant('{cm:DeleteSave}'), MBConfirmation, MB_YESNO) = IDYES then
        if not DelTree({#Save3}, True, True, True) then MsgBox('Папка не удалена!' + #13 + 'Папки не существует или она задействована...' + #13 + 'Путь: ' + {#Save3}, mbCriticalError, MB_OK);
      if (MsgBoxVar[3] = 1) and (MsgBoxVar[2] = 1) and (MsgBoxVar[2] = 1) or ((MsgBoxVar[2] = 0) and (MsgBoxVar[2] = 1)) or ((MsgBoxVar[2] = 1) and (MsgBoxVar[2] = 0)) then
        if not DelTree({#Save3}, True, True, True) then MsgBox('Папка не удалена!' + #13 + 'Папки не существует или она задействована...' + #13 + 'Путь: ' + {#Save3}, mbCriticalError, MB_OK);
    #endif
  end;
#endif
//Удаление Сохранений

Procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  Case CurUninstallStep of
    usUninstall: begin
      #ifdef DeleteSaved
        DeleteSaveGames();
      #endif
      DelTree(ExpandConstant('{commonprograms}\TimickRePack\{#GameNameFolder}'), True, True, True);
    end;
    usPostUninstall: begin
      if DirExists(ExpandConstant('{app}')) then DelDir(ExpandConstant('{app}'));
    end;
  end;
end;