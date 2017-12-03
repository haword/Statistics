unit MQNTheNumberOfPlasmaDonations;

interface

uses
  SysUtils, Variants,
  Data.Win.ADODB, GetDataSoursUnit1;

type
  ITheNumberOfPlasmaDonations = interface
    function GetValue: string;
    procedure Free;
  end;

  TTheNumberOfPlasmaDonations = class(TInterfacedObject,
    ITheNumberOfPlasmaDonations)
  private
    NumberOfPD: string;
    TempConnect: IDataBaseTables;
    TempQuery: TADOQuery;
  public
    function GetValue: string;
    // procedure Free;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfPlasmaDonations }

constructor TTheNumberOfPlasmaDonations.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(TempConnect) then
    TempConnect := TDataBaseTables.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  TempQuery.SQL.Add
    ('SELECT SUM(Plasma.���) FROM Plasma WHERE (Plasma.�����) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#');
  TempQuery.Open;
  NumberOfPD := VarToStr(TempQuery.Fields[0].Value);
  TempQuery.Close;
end;

{ procedure TTheNumberOfPlasmaDonations.Free;
  begin
  self.Free;
  end; }

function TTheNumberOfPlasmaDonations.GetValue: string;
begin
  result := NumberOfPD;
end;

end.
