[Code]
//===== [Установка на жесткий диск] =====\\:
function GetDriveType(lpRootPathName: PAnsiChar): Cardinal; external 'GetDriveTypeA@kernel32.dll stdcall';
function GetLogicalDrives: DWORD; external 'GetLogicalDrives@kernel32.dll stdcall'; 
 
const 
  DRIVE_UNKNOWN = 0; // Диск не определен
  DRIVE_NO_ROOT_DIR = 1; // Корневой путь недопустим 
  DRIVE_REMOVEABLE = 2; // Съемный диск
  DRIVE_FIXED = 3; // Жесткий диск
  DRIVE_REMOTE = 4; // Сетевой диск
  DRIVE_CDROM = 5; // CD-ROM
  DRIVE_RAMDISK = 6; // RAM DISK
var 
  DriveBits: DWORD; 
  DriveIndex: integer; 
  DriveLetter: string; 
  DriveType: DWORD; 
 
function NoSD(Param: string): string; 
begin 
  Result := ExpandConstant('{sd}'); // Получили системный том 
  DriveBits := GetLogicalDrives; 
  for DriveIndex := 0 to 25 do // Ограничение на 26 локальных томов на одном компьютере (количество букв английского алфавита для именования дисков)
  begin
  if (DriveBits and (1 shl DriveIndex)) <> 0 then // ..присутствует в системе
  begin
    DriveLetter := Chr(Ord('A') + DriveIndex) + ':';
  if CompareText(DriveLetter, Result) <> 0 then // ..не системный
  begin
    DriveType := GetDriveType(DriveLetter);
  if DriveType = DRIVE_FIXED then // ..находится на жестком диске
  begin
    Result:=DriveLetter;
    Break;
  end;
 end;
end; 
end; 
end;
//===== [Установка на жесткий диск] =====\\;