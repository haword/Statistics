unit BQPHarvestingOfPlasmaDosesTotal;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Data.Win.ADODB,
  GetAdoConnect,
  USCheckNull;

type
  IBQPHarvestingOfPlasmaDosesTotal = interface
    function GetValue: string;
  end;

  TBQPHarvestingOfPlasmaDosesTotal = class(TInterfacedObject,
    IBQPHarvestingOfPlasmaDosesTotal)
  private
    TempValue: Integer;
    PlasmaDosesTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQPHarvestingOfPlasmaDosesTotal.create(DateStart, DateEnd: TDate);
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
  TempQuery.SQL.Add('SELECT Sum(BloodPlasma.���) ' +
    'FROM ((Blood INNER JOIN BloodDoza ON Blood.����� = BloodDoza.�����) ' +
    'INNER JOIN BloodErSusp ON BloodDoza.���� = BloodErSusp.���) ' +
    'INNER JOIN BloodPlasma ON BloodErSusp.��� = BloodPlasma.���� ' +
    'WHERE (Blood.�����) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#;');
  TempQuery.Open;
  TempValue := StrToInt
    (VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value)));
  TempQuery.Close;

  TempQuery.SQL.Clear;
  TempQuery.SQL.Add('SELECT Sum(PlasmaComponents.����) ' +
    'FROM (Plasma INNER JOIN PlazmaDoza ON Plasma.����� = PlazmaDoza.�����) ' +
    'INNER JOIN PlasmaComponents ON PlazmaDoza.����� = PlasmaComponents.����� '
    + 'WHERE (Plasma.�����) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#;');
  TempQuery.Open;
  PlasmaDosesTotal :=
    IntToStr(TempValue +
    StrToInt(VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value))));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfPlasmaDosesTotal.create ���������');
end;

function TBQPHarvestingOfPlasmaDosesTotal.GetValue: string;
begin
  result := PlasmaDosesTotal;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfPlasmaDosesTotal.GetValue ���������');
end;

end.
