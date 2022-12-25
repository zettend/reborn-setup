[code]
//�������� ����� � �����, ���� ��, �� �����-�� ��������, �� ���� ������� �������������:
Procedure DelDir(Dir : String);
var
  R: Integer;
begin
  Exec('cmd.exe', ' /C RD /S /Q  ' + '"'+Dir+'"', ExpandConstant('{sys}'), SW_Hide, ewWaitUntilTerminated, R);
end;
//�������� ����� � �����, ���� ��, �� �����-�� ��������, �� ���� ������� �������������.

//�������� ����������
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
        if not DelTree({#Save1}, True, True, True) then MsgBox('����� �� �������!' + #13 + '����� �� ���������� ��� ��� �������������...' + #13 + '����: ' + {#Save1}, mbCriticalError, MB_OK);
    #endif
    #ifdef Save2
      if (MsgBoxVar[2] = 1) and (MsgBoxVar[1] = 0) then if MsgBox(ExpandConstant('{cm:DeleteSave}'), MBConfirmation, MB_YESNO) = IDYES then
        if not DelTree({#Save2}, True, True, True) then MsgBox('����� �� �������!' + #13 + '����� �� ���������� ��� ��� �������������...' + #13 + '����: ' + {#Save2}, mbCriticalError, MB_OK);
      if (MsgBoxVar[2] = 1) and (MsgBoxVar[1] = 1) then
        if not DelTree({#Save2}, True, True, True) then MsgBox('����� �� �������!' + #13 + '����� �� ���������� ��� ��� �������������...' + #13 + '����: ' + {#Save2}, mbCriticalError, MB_OK);
    #endif
    #ifdef Save3
      if (MsgBoxVar[3] = 1) and (MsgBoxVar[1] = 0) and (MsgBoxVar[2] = 0) then if MsgBox(ExpandConstant('{cm:DeleteSave}'), MBConfirmation, MB_YESNO) = IDYES then
        if not DelTree({#Save3}, True, True, True) then MsgBox('����� �� �������!' + #13 + '����� �� ���������� ��� ��� �������������...' + #13 + '����: ' + {#Save3}, mbCriticalError, MB_OK);
      if (MsgBoxVar[3] = 1) and (MsgBoxVar[2] = 1) and (MsgBoxVar[2] = 1) or ((MsgBoxVar[2] = 0) and (MsgBoxVar[2] = 1)) or ((MsgBoxVar[2] = 1) and (MsgBoxVar[2] = 0)) then
        if not DelTree({#Save3}, True, True, True) then MsgBox('����� �� �������!' + #13 + '����� �� ���������� ��� ��� �������������...' + #13 + '����: ' + {#Save3}, mbCriticalError, MB_OK);
    #endif
  end;
#endif
//�������� ����������

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