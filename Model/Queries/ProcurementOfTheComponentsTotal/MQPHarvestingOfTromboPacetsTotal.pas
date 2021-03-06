unit MQPHarvestingOfTromboPacetsTotal;

interface

uses
  SysUtils, Variants, Data.Win.ADODB,
  GetAdoQuery,
  UCheckNull;

type
  IHarvestingOfTromboPacetsTotal = interface
    function GetValue: string;
  end;

  THarvestingOfTromboPacetsTotal = class(TInterfacedObject,
    IHarvestingOfTromboPacetsTotal)
  private
    TromboPacetsTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor THarvestingOfTromboPacetsTotal.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  TempQuery.SQL.Add('SELECT Sum(TrombComponents.����) ' +
    'FROM Tromb INNER JOIN (TrombDoza INNER JOIN TrombComponents ' +
    'ON TrombDoza.���� = TrombComponents.�����) ON Tromb.����� = TrombDoza.����� ' +
    'WHERE (Tromb.�����) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#;');
  TempQuery.Open;
  TromboPacetsTotal :=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;
end;

function THarvestingOfTromboPacetsTotal.GetValue: string;
begin
  result := TromboPacetsTotal;
end;

end.
