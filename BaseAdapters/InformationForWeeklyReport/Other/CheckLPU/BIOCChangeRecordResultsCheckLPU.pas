unit BIOCChangeRecordResultsCheckLPU;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, CodeSiteLogging, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOCChangeRecordResultsCheckLPU = interface
    procedure ChangeRecord(Date: Extended; CheckLPU: String; Id: String);
  end;

  TBIOCChangeRecordResultsCheckLPU = class(TInterfacedObject,
    IBIOCChangeRecordResultsCheckLPU)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure ChangeRecord(Date: Extended; CheckLPU: String; Id: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOCChangeRecordResultsCheckLPU.ChangeRecord(Date: Extended;
  CheckLPU: String; Id: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('UPDATE Consultations SET Consultations.������� = #' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        'Consultations.����=' + CheckLPU + ' ' +
        'WHERE Consultations.���=' + Id);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOCChangeRecordResultsCheckLPU.ChangeRecord ���������');
end;

end.
