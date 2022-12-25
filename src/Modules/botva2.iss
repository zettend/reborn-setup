[Code]
#ifdef UNICODE
    #define A "W"
#else
    #define A "A"
#endif

const
  BTN_MAX_PATH = 1024;

  //идентификаторы событий для кнопок
  BtnClickEventID      = 1;
  BtnMouseEnterEventID = 2;
  BtnMouseLeaveEventID = 3;
  BtnMouseMoveEventID  = 4;
  BtnMouseDownEventID  = 5;
  BtnMouseUpEventID    = 6;

  //выравнивание текста на кнопках
  balLeft    = 0;  //выравнивание текста по левому краю
  balCenter  = 1;  //горизонтальное выравнивание текста по центру
  balRight   = 2;  //выравнивание текста по правому краю
  balVCenter = 4;  //вертикальное выравнивание текста по центру

type
  #ifdef UNICODE
    PChar = PAnsiChar;
  #endif
  #ifndef UNICODE
    AnsiChar = Char;
  #endif
  TBtnEventProc = Procedure(h:HWND);
  TTextBuf      = array [0..BTN_MAX_PATH-1] of AnsiChar; //не менять размерность массива !!!

Function LibImgLoad(Wnd :HWND; buf :PAnsiChar; Size: Longint; Left, Top, Width, Height :integer; Stretch, IsBkg :boolean) :Longint; external 'ImgLoad@{tmp}\b2p.dll stdcall delayload';
//загружает изображение в память, сохраняет переданные параметры
//Wnd          - хэндл окна, в котором будет выведено изображение
//FileName     - файл изображения
//Left,Top     - координаты верхнего левого угла вывода изображения (в координатах клиентской области Wnd)
//Width,Height - ширина, высота изображения
//               если Stretch=True, то изображение будет растянуто/сжато в прямоугольной области
//               Rect.Left:=Left;
//               Rect.Top:=Top;
//               Rect.Right:=Left+Width;
//               Rect.Bottom:=Top+Height;
//               если Stretch=False, то параметры Width,Height игнорируются и вычисляются самой ImgLoad, т.е. можно передать 0
//Stretch      - масштабировать изображение или нет
//IsBkg        - если IsBkg=True, изображение будет выведено на фоне формы,
//               поверх него будут отрисованы графические объекты (TLabel, TBitmapImage и т.д.),
//               затем поверх всего будут выведены изображения с флагом IsBkg=False
//возвращаемое значение - указатель на структуру, хранящей изображение и его парметры, приведенный к типу Longint
//изображения будут выведены в той последовательности, в которой вызывается ImgLoad

Procedure ImgSetVisiblePart(img:Longint; NewLeft, NewTop, NewWidth, NewHeight : integer); external 'ImgSetVisiblePart@{tmp}\b2p.dll stdcall delayload';
//сохраняет новые координаты видимой части изображения, новую ширину и высоту. в координатах оригинального изображения
//img                - значение полученное при вызове ImgLoad.
//NewLeft,NewTop     - новый левый верхний угол видимой области.
//NewWidth,NewHeight - новая ширина, высота видимой области.
//PS изначально (при вызове ImgLoad) изображение считается полностью видимым.
//   если возникла необходимость отображать только часть картинки, то используем эту процедуру

Procedure ImgGetVisiblePart(img:Longint; var Left, Top, Width, Height : integer); external 'ImgGetVisiblePart@{tmp}\b2p.dll stdcall delayload';
//возвращает координаты видимой части изображения, ширину и высоту
//img                - значение полученное при вызове ImgLoad
//NewLeft,NewTop     - левый верхний угол видимой области
//NewWidth,NewHeight - ширина, высота видимой области.

Procedure ImgSetPosition(img :Longint; NewLeft, NewTop, NewWidth, NewHeight :integer); external 'ImgSetPosition@{tmp}\b2p.dll stdcall delayload';
//сохраняет новые координаты для вывода изображения, новую ширину и высоту. в координатах родительского окна
//img                - значение полученное при вызове ImgLoad
//NewLeft,NewTop     - новый левый верхний угол
//NewWidth,NewHeight - новая ширина, высота. если в ImgLoad был передан Stretch=False, то NewWidth,NewHeight игнорируются

Procedure ImgGetPosition(img:Longint; var Left, Top, Width, Height:integer); external 'ImgGetPosition@{tmp}\b2p.dll stdcall delayload';
//возвращает координаты вывода изображения, ширину и высоту
//img          - значение полученное при вызове ImgLoad
//Left,Top     - левый верхний угол
//Width,Height - ширина, высота.

Procedure ImgSetVisibility(img :Longint; Visible :boolean); external 'ImgSetVisibility@{tmp}\b2p.dll stdcall delayload';
//сохраняет параметр видимости изображения
//img     - значение полученное при вызове ImgLoad
//Visible - видимость

Function ImgGetVisibility(img:Longint):boolean; external 'ImgGetVisibility@{tmp}\b2p.dll stdcall delayload';
//img - значение полученное при вызове ImgLoad
//возвращаемое значение - видимость изображения

Procedure ImgSetTransparent(img:Longint; Value:integer); external 'ImgSetTransparent@{tmp}\b2p.dll stdcall delayload';
//устанавливает прозрачность изображения
//img   - значение полученное при вызове ImgLoad
//Value - прозрачность (0-255)

Function ImgGetTransparent(img:Longint):integer; external 'ImgGetTransparent@{tmp}\b2p.dll stdcall delayload';
//получить значение прозрачности
//img   - значение полученное при вызове ImgLoad
//возвращаемое значение - текущая прозрачность изображения

Procedure ImgRelease(img :Longint); external 'ImgRelease@{tmp}\b2p.dll stdcall delayload';
//удаляет изображение из памяти
//img - значение полученное при вызове ImgLoad

Procedure ImgApplyChanges(h:HWND); external 'ImgApplyChanges@{tmp}\b2p.dll stdcall delayload';
//формирует окончательное изображение для вывода экран,
//учитывая все изменения внесенные вызовами ImgLoad, ImgSetPosition, ImgSetVisibility, ImgRelease и обновляет окно
//h - хэндл окна, для которого необходимо сформировать новое изображение

Function LibBtnCreate(hParent :HWND; Left, Top, Width, Height :integer; Buf :PAnsiChar; Size: longInt; ShadowWidth :integer; IsCheckBtn :boolean) :HWND; external 'BtnCreate@{tmp}\b2p.dll stdcall delayload';
//hParent           - хэндл окна-родителя, на котором будет создана кнопка
//Left,Top,
//Width,Height      - без комментариев. то же что и для обычных кнопок
//FileName          - файл с изображением состояний кнопки
//                    для обычной кнопки нужно 4 состояния кнопки (соответственно 4 изображения)
//                    для кнопки с IsCheckBtn=True нужно 8 изображений (как для чекбокса)
//                    изображения состояний должны располагаться вертикально
//ShadowWidth       - кол-во пикселей от края рисунка кнопки, до реальной ее границы на рисунке.
//                    нужно чтобы состояние кнопки и курсор на ней менялись как положено
//IsCheckBtn        - если True, то будет создана кнопка (аналог CheckBox) имеющая включенное и выключенное состояние
//                    если False, то создастся обычная кнопка
//возвращаемое значение - хэндл созданной кнопки

Procedure BtnSetText(h :HWND; Text :PAnsiChar); external 'BtnSetText@{tmp}\b2p.dll stdcall delayload';
//устанавливает текст на кнопке (аналог Button.Caption:='bla-bla-bla')
//h    - хэндл кнопки (результат возвращенный BtnCreate)
//Text - текст, который мы хотим увидеть на кнопке

Function BtnGetText_(h:HWND; var Text:TTextBuf):integer; external 'BtnGetText@{tmp}\b2p.dll stdcall delayload';
//получает текст кнопки
//h    - хэндл кнопки (результат возвращенный BtnCreate)
//Text - буфер принимающий текст кнопки
//возвращаемое значение - длина текста

Procedure BtnSetTextAlignment(h :HWND; HorIndent, VertIndent :integer; Alignment :DWORD); external 'BtnSetTextAlignment@{tmp}\b2p.dll stdcall delayload';
//устанавливает выравнивание текста на кнопке
//h          - хэндл кнопки (результат возвращенный BtnCreate)
//HorIndent  - горизонтальный отступ текста от края кнопки
//VertIndent - вертикальный отступ текста от края кнопки
//Alignment  - выравнивание текста. задается константами balLeft, balCenter, balRight, balVCenter,
//             или комбинацией balVCenter с остальными. например, balVCenter or balRight

Procedure BtnSetFont(h :HWND; Font :Cardinal); external 'BtnSetFont@{tmp}\b2p.dll stdcall delayload';
//устанавливает шрифт для кнопки
//h    - хэндл кнопки (результат возвращенный BtnCreate)
//Font - дескриптор устанавливаемого шрифта
//       чтобы не мучаться с WinAPI-шными функциями можно создать шрифт стандартными средствами инно и передать его хэндл
//       например,
//       var
//         Font:TFont;
//         . . .
//       begin
//         . . .
//         Font:=TFont.Create;
//         все свойства можно не устанавливать, при создании свойства заполняются значениями по умолчанию. меняем только то что нам нужно
//         with Font do begin
//           Name:='Tahoma';
//           Size:=10;
//           . . .
//         end;
//         BtnSetFont(hBtn,Font.Handle);
//         . . .
//       end;
//       ну и при выходе из программы (или когда он станет не нужен) не забываем уничтожить свой шрифт Font.Free;

Procedure BtnSetFontColor(h :HWND; NormalFontColor, FocusedFontColor, PressedFontColor, DisabledFontColor :Cardinal); external 'BtnSetFontColor@{tmp}\b2p.dll stdcall delayload';
//устанавливает цвет шрифта для кнопки во включенном и выключенном сосотоянии
//h                 - хэндл кнопки (результат возвращенный BtnCreate)
//NormalFontColor   - цвет текста на кнопе в нормальном состоянии
//FocusedFontColor  - цвет текста на кнопе в подсвеченном состоянии
//PressedFontColor  - цвет текста на кнопе в нажатом состоянии
//DisabledFontColor - цвет текста на кнопе в отключенном состоянии

Function BtnGetVisibility(h :HWND) :boolean; external 'BtnGetVisibility@{tmp}\b2p.dll stdcall delayload';
//получает видимость кнопки (аналог f:=Button.Visible)
//h - хэндл кнопки (результат возвращенный BtnCreate)
//возвращаемое значение - видимость кнопки

Procedure BtnSetVisibility(h :HWND; Value :boolean); external 'BtnSetVisibility@{tmp}\b2p.dll stdcall delayload';
//устанавливает видимость кнопки (аналог Button.Visible:=True / Button.Visible:=False)
//h     - хэндл кнопки (результат возвращенный BtnCreate)
//Value - значение видимости

Function BtnGetEnabled(h :HWND) :boolean; external 'BtnGetEnabled@{tmp}\b2p.dll stdcall delayload';
//получает доступность кнопки (аналог f:=Button.Enabled)
//h - хэндл кнопки (результат возвращенный BtnCreate)
//возвращаемое значение - доступность кнопки

Procedure BtnSetEnabled(h :HWND; Value :boolean); external 'BtnSetEnabled@{tmp}\b2p.dll stdcall delayload';
//устанвливает доступность кнопки (аналог Button.Enabled:=True / Button.Enabled:=False)
//h - хэндл кнопки (результат возвращенный BtnCreate)
//Value - значение доступности кнопки

Function BtnGetChecked(h :HWND) :boolean; external 'BtnGetChecked@{tmp}\b2p.dll stdcall delayload';
//получает состояние (включена/выключена) кнопки (аналог f:=Checkbox.Checked)
//h - хэндл кнопки (результат возвращенный BtnCreate)

Procedure BtnSetChecked(h :HWND; Value :boolean); external 'BtnSetChecked@{tmp}\b2p.dll stdcall delayload';
//устанвливает состояние (включена/выключена) кнопки (аналог Сheckbox.Checked:=True / Сheckbox.Checked:=False)
//h - хэндл кнопки (результат возвращенный BtnCreate)
//Value - значение состояния кнопки

Procedure BtnSetEvent(h :HWND; EventID :integer; Event :Longword); external 'BtnSetEvent@{tmp}\b2p.dll stdcall delayload';
//устанавливает событие для кнопки
//h       - хэндл кнопки (результат возвращенный BtnCreate)
//EventID - идентификатор события, заданный константами   BtnClickEventID, BtnMouseEnterEventID, BtnMouseLeaveEventID, BtnMouseMoveEventID
//Event   - адрес процедуры выполняемой при наступлении указанного события
//пример использования - BtnSetEvent(hBtn, BtnClickEventID, WrapBtnCallback(@BtnClick,1));

Procedure BtnGetPosition(h:HWND; var Left, Top, Width, Height: integer);  external 'BtnGetPosition@{tmp}\b2p.dll stdcall delayload';
//получает координаты левого верхнего угла и размер кнопки
//h             - хэндл кнопки (результат возвращенный BtnCreate)
//Left, Top     - координаты верхнего левого угла (в координатах родительского окна)
//Width, Height - ширина, высота кнопки

Procedure BtnSetPosition(h:HWND; NewLeft, NewTop, NewWidth, NewHeight: integer);  external 'BtnSetPosition@{tmp}\b2p.dll stdcall delayload';
//устанавливает координаты левого верхнего угла и размер кнопки
//h                   - хэндл кнопки (результат возвращенный BtnCreate)
//NewLeft, NewTop     - новые координаты верхнего левого угла (в координатах родительского окна)
//NewWidth, NewHeight - новые ширина, высота кнопки

Procedure BtnRefresh(h :HWND); external 'BtnRefresh@{tmp}\b2p.dll stdcall delayload';
//немедленно перерисовывает кнопку, в обход очереди сообщений. вызывать, если кнопка не успевает перерисовываться
//h - хэндл кнопки (результат возвращенный BtnCreate)

Procedure BtnSetCursor(h:HWND; hCur:Cardinal); external 'BtnSetCursor@{tmp}\b2p.dll stdcall delayload';
//устанавливает курсор для кнопки
//h    - хэндл кнопки (результат возвращенный BtnCreate)
//hCur - дескриптор устанавливаемого курсора
//DestroyCursor вызывать не обязательно, он будет уничтожен при вызове gdipShutDown;

Function GetSysCursorHandle(id:integer):Cardinal; external 'GetSysCursorHandle@{tmp}\b2p.dll stdcall delayload';
//загружает стандартный курсор по его идентификатору
//id - идентификатор стандартного курсора. идентификаторы стандартных курсоров задаются константами OCR_... , значения которых ищем в инете
//возвращаемое значение  - дескриптор загруженного курсора

Procedure gdipShutdown; external 'gdipShutdown@{tmp}\b2p.dll stdcall delayload';
//обязательно вызвать при завершении приложения

Procedure LibCreateFormFromImage(h:HWND; Buf:PAnsiChar; Size: Longint); external 'CreateFormFromImage@{tmp}\b2p.dll stdcall delayload';
//создать форму по PNG-рисунку (в принципе можно использовать другие форматы изображений)
//h        - хэндл окна
//FileName - путь к файлу изображения
//на такой форме не будут видны контролы (кнопки, чекбоксы, эдиты и т.д.) !!!

Function CreateBitmapRgn(DC: LongWord; Bitmap: HBITMAP; TransClr: DWORD; dX:integer; dY:integer): LongWord; external 'CreateBitmapRgn@{tmp}\b2p.dll stdcall delayload';
//создать регион из битмапа
//DC       - контекст формы
//Bitmap   - битмап по которому будем строить регион
//TransClr - цвет пикселей, которые не будут включены в регион (прозрачный цвет)
//dX,dY    - смещение региона на форме

Procedure SetMinimizeAnimation(Value: Boolean); external 'SetMinimizeAnimation@{tmp}\b2p.dll stdcall delayload';
//включить/выклюсить анимацию при сворачивании окон

Function GetMinimizeAnimation: Boolean; external 'GetMinimizeAnimation@{tmp}\b2p.dll stdcall delayload';
//получить текущее состояние анимации сворачивания окон

Function ArrayOfAnsiCharToAnsiString(a:TTextBuf):AnsiString;
var
  i:integer;
begin
  i:=0;
  Result:='';
  while a[i]<>#0 do begin
    Result:=Result+a[i];
    i:=i+1;
  end;
end;

Function BtnGetText(hBtn:HWND):AnsiString;
var
  buf:TTextBuf;
begin
  BtnGetText_(hBtn,buf);
  Result:=ArrayOfAnsiCharToAnsiString(buf); //медленно работает, как по другому сделать хз
end;

Function ImgLoad(Wnd :HWND; Filename :String; Left, Top, Width, Height :integer; Stretch, IsBkg :boolean): Longint;
var
  buffer: AnsiString;
  FileSize: Longint;
begin
  if Pos(ExpandConstant('{tmp}\'), Filename)>0 then StringChange(Filename, ExpandConstant('{tmp}\'), '');
  if Pos('{tmp}\', Filename)>0 then StringChange(Filename, '{tmp}\', '');
  FileSize:= ExtractTemporaryFileSize(Filename);
  SetLength(Buffer, FileSize);
  #ifdef UNICODE
    ExtractTemporaryFileToBuffer(Filename, CastAnsiStringToInteger(Buffer));
  #else
    ExtractTemporaryFileToBuffer(Filename, CastStringToInteger(Buffer));
  #endif
  Result:= LibImgLoad(Wnd, buffer, FileSize, Left, Top, Width, Height, Stretch, Isbkg)
end;

Function BtnCreate(hParent :HWND; Left, Top, Width, Height :integer; Filename :String; ShadowWidth :integer; IsCheckBtn :boolean) :HWND;
var
  buffer: AnsiString;
  FileSize: Longint;
begin
  if Pos(ExpandConstant('{tmp}\'), Filename)>0 then StringChange(Filename, ExpandConstant('{tmp}\'), '');
  if Pos('{tmp}\', Filename)>0 then StringChange(Filename, '{tmp}\', '');
  FileSize:= ExtractTemporaryFileSize(Filename);
  SetLength(Buffer, FileSize);
  #ifdef UNICODE
    ExtractTemporaryFileToBuffer(Filename, CastAnsiStringToInteger(Buffer));
  #else
    ExtractTemporaryFileToBuffer(Filename, CastStringToInteger(Buffer));
  #endif
  Result:= LibBtnCreate(hParent, Left, Top, Width, Height, Buffer, FileSize, ShadowWidth, IsCheckBtn);
end;

Procedure CreateFormFromImage(h:HWND; Filename:String);
var
  buffer: AnsiString;
  FileSize: Longint;
begin
  if Pos(ExpandConstant('{tmp}\'), Filename)>0 then StringChange(Filename, ExpandConstant('{tmp}\'), '');
  if Pos('{tmp}\', Filename)>0 then StringChange(Filename, '{tmp}\', '');
  FileSize:= ExtractTemporaryFileSize(Filename);
  SetLength(Buffer, FileSize);
  #ifdef UNICODE
    ExtractTemporaryFileToBuffer(Filename, CastAnsiStringToInteger(Buffer));
  #else
    ExtractTemporaryFileToBuffer(Filename, CastStringToInteger(Buffer));
  #endif
  LibCreateFormFromImage(h, Buffer, FileSize);
end;