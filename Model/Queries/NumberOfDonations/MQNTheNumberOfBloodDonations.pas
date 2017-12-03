unit MQNTheNumberOfBloodDonations;

interface

uses
  SysUtils, Variants,
  Dialogs, Data.Win.ADODB, GetDataSoursUnit1;

type
  ITheNumberOfBloodDonations = interface
    function GetValue: string;
    procedure free;
  end;

  TTheNumberOfBloodDonations = class(TInterfacedObject,
    ITheNumberOfBloodDonations)
  private
    NumberOfBD: string;
    TempConnect: IDataBaseTables;
    TempQuery: TADOQuery;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TTheNumberOfBloodDonations.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(TempConnect) then
    TempConnect := TDataBaseTables.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  TempQuery.SQL.Add
    ('SELECT SUM(Blood.���) FROM Blood WHERE (Blood.�����) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#');
  TempQuery.Open;
  NumberOfBD := VarToStr(TempQuery.Fields[0].Value);
  TempQuery.Close;
end;

function TTheNumberOfBloodDonations.GetValue: string;
begin
  result := NumberOfBD;
end;

end.
