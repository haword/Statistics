unit MFPanel;

interface

uses
  Graphics, Controls, SysUtils, CodeSiteLogging,
  Forms, Vcl.ExtCtrls;

type
  IMFPanel = interface
    function GetTempPanel(CLeft, CTop, CHeight, CWidth, CColor: integer;
      CurrentForm: TForm): TPanel;
    procedure Visible(i: boolean);
    procedure destroy;
  end;

  TMFPanel = class(TInterfacedObject, IMFPanel)
  private
    TempPanel: TPanel;
  public
    function GetTempPanel(CLeft, CTop, CHeight, CWidth, CColor: integer;
      CurrentForm: TForm): TPanel;
    procedure Visible(i: boolean);
    procedure destroy;
  end;

implementation

{ TTempPanelTag5 }

procedure TMFPanel.destroy;
begin
  if Assigned(TempPanel) then
    FreeAndNil(TempPanel);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFPanel.destroy выполнена');
end;

function TMFPanel.GetTempPanel(CLeft, CTop, CHeight, CWidth, CColor: integer;
  CurrentForm: TForm): TPanel;
begin
  if not Assigned(TempPanel) then
    TempPanel := TPanel.create(CurrentForm);
  TempPanel.parent := CurrentForm;
  with TempPanel do
  begin
    left := CLeft;
    top := CTop;
    height := CHeight;
    width := CWidth;
    color := clBlack;
    Tag := 5;
    BevelOuter := bvNone;
    Visible := False;
  end;
  result := TempPanel;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFPanel.GetTempPanel выполнена');
end;

procedure TMFPanel.Visible(i: boolean);
begin
  TempPanel.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFPanel.Visible выполнена', i);
end;

end.
