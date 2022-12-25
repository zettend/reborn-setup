[Code]
//===== [��������� �� ������� ����] =====\\:
function GetDriveType(lpRootPathName: PAnsiChar): Cardinal; external 'GetDriveTypeA@kernel32.dll stdcall';
function GetLogicalDrives: DWORD; external 'GetLogicalDrives@kernel32.dll stdcall'; 
 
const 
  DRIVE_UNKNOWN = 0; // ���� �� ���������
  DRIVE_NO_ROOT_DIR = 1; // �������� ���� ���������� 
  DRIVE_REMOVEABLE = 2; // ������� ����
  DRIVE_FIXED = 3; // ������� ����
  DRIVE_REMOTE = 4; // ������� ����
  DRIVE_CDROM = 5; // CD-ROM
  DRIVE_RAMDISK = 6; // RAM DISK
var 
  DriveBits: DWORD; 
  DriveIndex: integer; 
  DriveLetter: string; 
  DriveType: DWORD; 
 
function NoSD(Param: string): string; 
begin 
  Result := ExpandConstant('{sd}'); // �������� ��������� ��� 
  DriveBits := GetLogicalDrives; 
  for DriveIndex := 0 to 25 do // ����������� �� 26 ��������� ����� �� ����� ���������� (���������� ���� ����������� �������� ��� ���������� ������)
  begin
  if (DriveBits and (1 shl DriveIndex)) <> 0 then // ..������������ � �������
  begin
    DriveLetter := Chr(Ord('A') + DriveIndex) + ':';
  if CompareText(DriveLetter, Result) <> 0 then // ..�� ���������
  begin
    DriveType := GetDriveType(DriveLetter);
  if DriveType = DRIVE_FIXED then // ..��������� �� ������� �����
  begin
    Result:=DriveLetter;
    Break;
  end;
 end;
end; 
end; 
end;
//===== [��������� �� ������� ����] =====\\;