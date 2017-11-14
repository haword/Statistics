unit GetDataSoursUnit1;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus, Contnrs, Data.DB, Data.Win.ADODB,
  Generics.Collections, Vcl.DBCtrls, Bde.DBTables;



type

  DataBaseTables = class (TADOQuery) //������� ������, ���������� ��������� �������
  private
    Query: TADOQuery;
  public
    constructor create;
    function GetBlood: TADOQuery;
    function GetPlasma: TADOQuery;
    function GetTrombo: TADOQuery;
  end;
implementation

{ Connecting }

constructor DataBaseTables.create;
begin
  if not Assigned(Query) then
  Query := TADOQuery.create(nil);
  Query.ConnectionString:='Provider=Microsoft.ACE.OLEDB.12.0;' +
  'Data Source=..\AccesBase\Stat_rab_ver.accdb;Persist Security Info=False';
  Query.Close;
end;


function DataBaseTables.GetBlood: TADOQuery;
begin
  Query.SQL.Clear;
  Query.SQL.Add('Select * From Blood');
  result:=Query;
end;

function DataBaseTables.GetPlasma: TADOQuery;
begin
  Query.SQL.Clear;
  Query.SQL.Add('Select * From Plasma');
  result:=Query;
end;

function DataBaseTables.GetTrombo: TADOQuery;
begin
  Query.SQL.Clear;
  Query.SQL.Add('Select * From Tromb');
  result:=Query;
end;

end.