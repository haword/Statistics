unit MMListOfDate;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  UCheckNull,
  GetAdoQuery;

type
  IMMListOfDate = interface
    function GetRowCount: integer;
    procedure GetContent(Month, Year: Integer);
    function GetList(i: integer): String;
  end;

  TMMListOfDate = class(TInterfacedObject,
    IMMListOfDate)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ListMass: array of String;
  public
    function GetRowCount: integer;
    procedure GetContent(Month, Year: Integer);
    function GetList(i: integer): String;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMMListOfDate.GetContent(Month, Year: Integer);
var i: integer;
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
  SQL:='SELECT FactoryCal.���� ' +
  'FROM FactoryCal ' +
  'WHERE ((Month([FactoryCal].[��������])=' + IntToStr(Month) + ') ' +
  'AND (Year([FactoryCal].[��������])=' + IntToStr(Year) + '));';
  try
    TempQuery.SQL.Add(SQL);
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  end;
  try
    TempQuery.Open;
  Except
    ShowMessage('��� ����������� � ���� ������ (MMListOfDate)!' + chr(13) + '���������� � ��������������!');
  end;
  Try
  if not TempQuery.IsEmpty then
  begin
    SetLength(ListMass, TempQuery.RecordCount);
    TempQuery.First;
    for i:=0 to TempQuery.RecordCount-1 do
    begin
      ListMass[i]:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      TempQuery.Next;
    end;
  end;
  Except
    ShowMessage('�� ���� ����� ������ � ���� ������ ��� ���������� ������� (MHAAutomaticApheresis)!' + chr(13) + '���������� � ��������������!');
  End;
  TempQuery.Close;
end;

function TMMListOfDate.GetList(i: integer): String;
begin
  result:=ListMass[i];
end;

function TMMListOfDate.GetRowCount: integer;
begin
  result:=Length(ListMass);
end;
end.
