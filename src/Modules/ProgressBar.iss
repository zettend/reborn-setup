[Code]
Type
  TImgPB = Record
    h: HWND;
    Left, Top, Width, Height, MaxWidth: Integer;
    Img1, Img2: LongInt;
  end;

Function ImgPBCreate(hParent: HWND; bk, pb: AnsiString; Left, Top, Width, Height: Integer): TImgPB;
begin
  Result.h        := hParent;
  Result.Left     := Left;
  Result.Top      := Top;
  Result.Width    := 0;
  Result.Height   := Height;
  Result.MaxWidth := Width;

  if Length(bk) > 0 then Result.Img2 := ImgLoad(hParent, bk, Left, Top, Width, Height, True, True) else Result.Img2 := 0;
  if Length(pb) > 0 then Result.Img1 := ImgLoad(hParent, pb, Result.Left, Result.Top, 0, Result.Height, True, True) else Result.Img1 := 0;

  ImgApplyChanges(Result.h);
end;

Procedure ImgPBSetPosition(PB: TImgPB; Percent: Extended);
var
  NewWidth: Integer;
begin
  if PB.Img1 <> 0 then begin
    NewWidth := Round(PB.MaxWidth * Percent / 1000);
    if PB.Width <> NewWidth then begin
      PB.Width := NewWidth;
      ImgSetPosition(PB.Img1, PB.Left, PB.Top, PB.Width, PB.Height);
      ImgSetVisiblePart(PB.Img1, ScaleX(0), ScaleY(0), ScaleX(PB.Width), ScaleY(PB.Height));
      ImgApplyChanges(PB.h);
    end;
  end;
end;

Procedure ImgPBDelete(PB: TImgPB);
begin
  if PB.Img1 <> 0 then ImgRelease(PB.Img1);
  if PB.Img2 <> 0 then ImgRelease(PB.Img2);
  PB.Img1 := 0;
  PB.Img2 := 0;
  ImgApplyChanges(PB.h);
end;

Procedure ImgPBVisibility(PB: TImgPB; Visible: Boolean);
begin
  ImgSetVisibility(PB.Img1, Visible);
  ImgSetVisibility(PB.Img2, Visible);
end;