unit BQPHarvestingOfTromboPacetsTotal;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Data.Win.ADODB,
  GetAdoConnect,
  USCheckNull;

type
  IBQPHarvestingOfTromboPacetsTotal = interface
    function GetValue: string;
  end;

  TBQPHarvestingOfTromboPacetsTotal = class(TInterfacedObject,
    IBQPHarvestingOfTromboPacetsTotal)
  private
    TromboPacetsTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQPHarvestingOfTromboPacetsTotal.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  TempQuery.SQL.Add('SELECT Sum(TrombComponents.����) ' +
    'FROM Tromb INNER JOIN (TrombDoza INNER JOIN TrombComponents ' +
    'ON TrombDoza.���� = TrombComponents.�����) ON Tromb.����� = TrombDoza.����� '
    + 'WHERE (Tromb.�����) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#;');
  TempQuery.Open;
  TromboPacetsTotal :=
    VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfTromboPacetsTotal.create ���������');
end;

function TBQPHarvestingOfTromboPacetsTotal.GetValue: string;
begin
  result := TromboPacetsTotal;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfTromboPacetsTotal.GetValue ���������');
end;

end.
