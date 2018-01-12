unit MIOATheAmountOfUsableErSusp;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  UCheckNull,
  GetAdoQuery;

type
  IAmountOfUsableErSusp = interface
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

  TResultRecord=Record
  private
    Kod: string;
    Date: String;
    Name: String;
    Volume: String;
  end;

  TAmountOfUsableErSusp = class(TInterfacedObject,
    IAmountOfUsableErSusp)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TAmountOfUsableErSusp.GetContent;
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
  SQL:='SELECT Exped.���, Exped.������, Exped.��, Exped.���� ' +
  'FROM Exped INNER JOIN NameProducts ON Exped.�� = NameProducts.ShortName ' +
  'WHERE (((NameProducts.TypeProduct)="�� ������") AND ((NameProducts.Production)=True)) AND ((Exped.����)>0)' +
  'ORDER BY Exped.������ desc;';
  Try
    TempQuery.SQL.Add(SQL);
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  try
    TempQuery.Open;
  Except
    ShowMessage('��� ����������� � ���� ������!' + chr(13) + '���������� � ��������������!');
  end;
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i:=0 to TempQuery.RecordCount-1 do
    begin
      ResultMass[i].Kod:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].Date:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].Name:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].Volume:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

function TAmountOfUsableErSusp.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TAmountOfUsableErSusp.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

function TAmountOfUsableErSusp.GetName(i: integer): string ;
begin
  result := ResultMass[i].Name;
end;

function TAmountOfUsableErSusp.GetDate(i: integer): string;
begin
  result := ResultMass[i].Date;
end;

function TAmountOfUsableErSusp.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;

end.
