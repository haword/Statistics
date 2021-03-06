unit MFBitBtnDelete;

interface

uses
  SysUtils, Classes, Forms, CodeSiteLogging, Buttons;

type
  IMFBitBtnDelete = interface
    function GetBitBtnDelete(CLeft, CTop: integer;
      ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeEnabled(i: Boolean);
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

  TMFBitBtnDelete = class(TInterfacedObject, IMFBitBtnDelete)
  private
    TempBitBtnDelete: TBitBtn;
  public
    function GetBitBtnDelete(CLeft, CTop: integer;
      ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeEnabled(i: Boolean);
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TMFBitBtnDelete.ChangeEnabled(i: Boolean);
begin
  TempBitBtnDelete.Enabled := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnDelete.ChangeEnabled выполнена', i);
end;

procedure TMFBitBtnDelete.destroy;
begin
  if Assigned(TempBitBtnDelete) then
    FreeAndNil(TempBitBtnDelete);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnDelete.destroy выполнена');
end;

function TMFBitBtnDelete.GetBitBtnDelete(CLeft, CTop: integer;
  ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
var
  CurrentDir: String;
begin
  if not Assigned(TempBitBtnDelete) then
  begin
    TempBitBtnDelete := TBitBtn.create(CurrentForm);
    TempBitBtnDelete.parent := CurrentForm;
    CurrentDir := ExtractFileDir(ExtractFileDir(ParamStr(0)));
    with TempBitBtnDelete do
    begin
      if CLeft = 0 then
        left := 650
      else
        left := CLeft;
      if CTop = 0 then
        Top := 180
      else
        Top := CTop;
      Font.name := 'Times New Roman';
      Font.Size := 14;
      Width := 200;
      Height := 30;
      Tag := 5;
      NumGlyphs:=3;
      Glyph.LoadFromFile(CurrentDir +
        '\Systems\Img\BitBtnDelete.bmp');
      Enabled := false;
      OnClick := ProcedureOnClick;
      Visible := false;
    end;
  end;
  result := TempBitBtnDelete;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnDelete.GetBitBtnDelete выполнена');
end;

procedure TMFBitBtnDelete.Visible(i: Boolean);
begin
  TempBitBtnDelete.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnDelete.Visible выполнена', i);
end;

end.
