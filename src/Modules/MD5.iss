// Проверка MD5-хеша файлов
// v. 1.2 by shidow
[Code]
var
  MD5: String;
  MD5Error: boolean;

function MD5Check:boolean;
begin
 #ifdef MD5_1
  if MD5Error = False and FileExists(ExpandConstant('{src}\part1.bin')) then MD5 := GetMD5OfFile(ExpandConstant('{src}\part1.bin')) else MD5Error:=True;
  if not MD5Error = True and not (MD5 = '{#MD5_1}') then MD5Error:=True;
 #endif
 #ifdef MD5_2
  if MD5Error = False and FileExists(ExpandConstant('{src}\part2.bin')) then MD5 := GetMD5OfFile(ExpandConstant('{src}\part2.bin')) else MD5Error:=True;
  if not MD5Error = True and not (MD5 = '{#MD5_2}') then MD5Error:=True;
 #endif
 #ifdef MD5_3
  if MD5Error = False and FileExists(ExpandConstant('{src}\part3.bin')) then MD5 := GetMD5OfFile(ExpandConstant('{src}\part3.bin')) else MD5Error:=True;
  if not MD5Error = True and not (MD5 = '{#MD5_3}') then MD5Error:=True;
 #endif
 #ifdef MD5_4
  if MD5Error = False and FileExists(ExpandConstant('{src}\part4.bin')) then MD5 := GetMD5OfFile(ExpandConstant('{src}\part4.bin')) else MD5Error:=True;
  if not MD5Error = True and not (MD5 = '{#MD5_4}') then MD5Error:=True;
 #endif
 #ifdef MD5_5
  if MD5Error = False and FileExists(ExpandConstant('{src}\part5.bin')) then MD5 := GetMD5OfFile(ExpandConstant('{src}\part5.bin')) else MD5Error:=True;
  if not MD5Error = True and not (MD5 = '{#MD5_5}') then MD5Error:=True;
 #endif
 #ifdef MD5_6
  iif MD5Error = False and FileExists(ExpandConstant('{src}\part6.bin')) then MD5 := GetMD5OfFile(ExpandConstant('{src}\part6.bin')) else MD5Error:=True;
  if not MD5Error = True and not (MD5 = '{#MD5_6}') then MD5Error:=True;
 #endif
 #ifdef MD5_7
  if MD5Error = False and FileExists(ExpandConstant('{src}\part7.bin')) then MD5 := GetMD5OfFile(ExpandConstant('{src}\part7.bin')) else MD5Error:=True;
  if not MD5Error = True and not (MD5 = '{#MD5_7}') then MD5Error:=True;
 #endif
 #ifdef MD5_8
  if MD5Error = False and FileExists(ExpandConstant('{src}\part8.bin')) then MD5 := GetMD5OfFile(ExpandConstant('{src}\part8.bin')) else MD5Error:=True;
  if not MD5Error = True and not (MD5 = '{#MD5_8}') then MD5Error:=True;
 #endif
end;