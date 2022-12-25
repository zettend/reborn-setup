[Code]
Type
  TImgPB = Record
    h: HWND;
    Left, Top, Width, Height, MaxWidth: Integer;
    img1, img2: LongInt;
  end;

Function ImgPBCreate(hParent: HWND; bk, pb: AnsiString; Left, Top, Width, Height: Integer): TImgPB;
begin
  Result.Left:= Left;
  Result.Top:= Top;
  Result.Width:= 0;
  Result.Height:= Height;
  Result.MaxWidth:= Width;
  Result.h:= hParent;
  if Length(pb)>0 then Result.img1:= ImgLoad(hParent, pb, Result.Left, Result.Top, 0, Result.Height, True, False) else Result.img1:= 0;
  if Length(bk)>0 then Result.img2:= ImgLoad(hParent, bk, Left, Top, Width, Height, True, True) else Result.img2:= 0;
  ImgApplyChanges(Result.h);
end;

Procedure ImgPBSetPosition(PB: TImgPB; Percent: Extended);
var
  NewWidth: Integer;
begin
  if PB.img1 <> 0 then begin
    NewWidth:= Round(PB.MaxWidth * Percent / 1000);
    if PB.Width <> NewWidth then begin
      PB.Width:= NewWidth;
      ImgSetPosition(PB.img1, PB.Left, PB.Top, PB.Width, PB.Height);
      ImgSetVisiblePart(PB.img1, ScaleX(0), ScaleY(0), ScaleX(PB.Width), ScaleY(PB.Height));
      ImgApplyChanges(PB.h);
    end;
  end;
end;

Procedure ImgPBDelete(PB: TImgPB);
begin
  if PB.img1<>0 then ImgRelease(PB.img1);
  if PB.img2<>0 then ImgRelease(PB.img2);
  PB.img1:= 0;
  PB.img2:= 0;
  ImgApplyChanges(PB.h);
end;

Procedure ImgPBVisibility(var PB :TImgPB;Visible :boolean);
begin
  ImgSetVisibility(PB.img1, Visible);
  ImgSetVisibility(PB.img2, Visible);
end;