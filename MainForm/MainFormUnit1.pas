unit MainFormUnit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus, Vcl.Grids, Data.DB, Data.Win.ADODB, Vcl.DBGrids,
  Vcl.DBCtrls, Generics.Collections, Contnrs, Bde.DBTables,
  Vcl.ComCtrls, GetDataSoursUnit1, VQNNumberOfDonations;

type
  TMyMainForm = class(TForm)
    Label1: TLabel;
    MainMenu1: TMainMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    Help1: TMenuItem;
    CloseButton: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    HandlyHarvesting: TMenuItem;
    AutoAferez: TMenuItem;
    Citoferez: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N7: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N1: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    QueryNumberOfDonations: TMenuItem;
    Query2: TMenuItem;
    Query3: TMenuItem;
    N26: TMenuItem;
    procedure CloseButtonClick(Sender: TObject);
    procedure QueryNumberOfDonationsClick(Sender: TObject);
  private
    NumberOfDonations: TNumberOfDonations;
  public

    { Public declarations }

  end;

var
  MyMainForm: TMyMainForm;

implementation

{$R *.dfm}
// �������/���������� �������

procedure TMyMainForm.QueryNumberOfDonationsClick(Sender: TObject);
begin
  Label1.Caption := '���������� ������� � ������������� �����';
  Label1.Font.Size := 25;
  if Assigned(NumberOfDonations) then
    NumberOfDonations := nil;
  NumberOfDonations := TNumberOfDonations.Create(self);
end;

procedure TMyMainForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

end.
