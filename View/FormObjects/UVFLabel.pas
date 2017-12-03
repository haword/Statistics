unit UVFLabel;

interface

uses
  StdCtrls, Forms ;

type
  ITempLabelTag5 = interface
    function GetTempLabel(CLeft, CTop: integer; FontSize: integer;
      CCaption: string; CurrentForm: TForm): TLabel;
  end;


  TTempLabelTag5 = class(TInterfacedObject, ITempLabelTag5)
  private
    TempLabel: TLabel;
  public
    function GetTempLabel(CLeft, CTop: integer; FontSize: integer;
      CCaption: String; CurrentForm: TForm): TLabel;
  end;

implementation

{ TTempLabelTag5 }

function TTempLabelTag5.GetTempLabel(CLeft, CTop, FontSize: integer;
  CCaption: String; CurrentForm: TForm): TLabel;
begin
  if not Assigned(TempLabel) then
    TempLabel := TLabel.create(CurrentForm);
  TempLabel.parent := CurrentForm;
  with TempLabel do
  begin
    left := CLeft;
    top := CTop;
    Font.Size := FontSize;
    Caption := CCaption;
    Font.name := 'Times New Roman';
    Tag := 5;
  end;
  result:=TempLabel;
end;

end.
