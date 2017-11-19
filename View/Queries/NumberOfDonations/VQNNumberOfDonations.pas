unit VQNNumberOfDonations;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Buttons,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs,
  MQNTheNumberOfBloodDonations,
  MQNTheNumberOfPlasmaDonations,
  MQNTheNumberOfTromboDonations;

type
  TNumberOfDonations = class(TObject)
  private
    StartDate: TLabel;
    EndDate: TLabel;
    StartDateCal: TDateTimePicker;
    EndDateCal: TDateTimePicker;
    ButtonBack: TBitBtn;
    ButtonAction: TBitBtn;
    NameStat1: TLabel;
    NameStat2: TLabel;
    NameStat3: TLabel;
    ResultEdit1: TEdit;
    ResultEdit2: TEdit;
    ResultEdit3: TEdit;
    form1: TForm;
    TheNumberOfBloodDonations: TTheNumberOfBloodDonations;
    TheNumberOfPlasmaDonations: TTheNumberOfPlasmaDonations;
    TheNumberOfTromboDonations: TTheNumberOfTromboDonations;
  public
    function GetLabelStartDate(NameForm: TwinControl): TLabel;
    function GetLabelEndDate(NameForm: TwinControl): TLabel;
    function GetCalendarStartDate(NameForm: TwinControl): TDateTimePicker;
    function GetCalendarEndDate(NameForm: TwinControl): TDateTimePicker;
    function GetButtonBack(NameForm: TwinControl): TBitBtn;
    function GetLabelNameStat1(NameForm: TwinControl): TLabel;
    function GenEdit1(NameForm: TwinControl): TEdit;
    function GetLabelNameStat2(NameForm: TwinControl): TLabel;
    function GenEdit2(NameForm: TwinControl): TEdit;
    function GetLabelNameStat3(NameForm: TwinControl): TLabel;
    function GenEdit3(NameForm: TwinControl): TEdit;
    function GetButtonAction(NameForm: TwinControl): TBitBtn;
    procedure ButtonAct(Sender: TObject);
    procedure ButtonBackClick(Sender: TObject);
    constructor create(form: TForm);
    destructor destroy;
  end;

implementation

{ TNumberOfDonations }

procedure TNumberOfDonations.ButtonAct(Sender: TObject);
begin
  if GetCalendarStartDate(form1).Date > GetCalendarEndDate(form1).Date then
  begin
    ShowMessage('�������� ���� �� ����� ���� ������ ���������');
    exit;
  end
  else
  begin
    if not Assigned(TheNumberOfBloodDonations) then
      TheNumberOfBloodDonations := TTheNumberOfBloodDonations.create
        (GetCalendarStartDate(form1).Date, GetCalendarEndDate(form1).Date);
    ResultEdit1.Text := TheNumberOfBloodDonations.GetValue;
    TheNumberOfBloodDonations := nil;
    if not Assigned(TheNumberOfPlasmaDonations) then
      TheNumberOfPlasmaDonations := TTheNumberOfPlasmaDonations.create
        (GetCalendarStartDate(form1).Date, GetCalendarEndDate(form1).Date);
    ResultEdit2.Text := TheNumberOfPlasmaDonations.GetValue;
    TheNumberOfPlasmaDonations := nil;
    if not Assigned(TheNumberOfTromboDonations) then
      TheNumberOfTromboDonations := TTheNumberOfTromboDonations.create
        (GetCalendarStartDate(form1).Date, GetCalendarEndDate(form1).Date);
    ResultEdit3.Text := TheNumberOfTromboDonations.GetValue;
    TheNumberOfTromboDonations := nil;
  end;
end;

procedure TNumberOfDonations.ButtonBackClick(Sender: TObject);
begin
  destroy;
end;

constructor TNumberOfDonations.create(form: TForm);
begin
  form1 := form;
  GetLabelStartDate(form1);
  GetLabelEndDate(form1);
  GetCalendarStartDate(form1);
  GetCalendarEndDate(form1);
  GetButtonBack(form1);
  GetLabelNameStat1(form1);
  GenEdit1(form1);
  GetLabelNameStat2(form1);
  GenEdit2(form1);
  GetLabelNameStat3(form1);
  GenEdit3(form1);
  GetButtonAction(form1);
end;

destructor TNumberOfDonations.destroy;
begin
  StartDate.Free;
  EndDate.Free;
  StartDateCal.Free;
  EndDateCal.Free;
  ButtonBack.Free;
  ButtonAction.Free;
  NameStat1.Free;
  NameStat2.Free;
  NameStat3.Free;
  ResultEdit1.Free;
  ResultEdit2.Free;
  ResultEdit3.Free;
  TheNumberOfBloodDonations.Free;
  TheNumberOfPlasmaDonations.Free;
  TheNumberOfTromboDonations.Free;
end;

function TNumberOfDonations.GenEdit1(NameForm: TwinControl): TEdit;
begin
  if not Assigned(ResultEdit1) then
    ResultEdit1 := TEdit.create(NameForm);
  ResultEdit1.parent := NameForm;
  with ResultEdit1 do
  begin
    left := 440;
    top := 180;
    Width := 100;
    Font.name := 'Times New Roman';
    Font.Size := 12;
    Alignment := taRightJustify;
    ReadOnly := true;
    Text := '';
  end;
  result := ResultEdit1;
end;

function TNumberOfDonations.GenEdit2(NameForm: TwinControl): TEdit;
begin
  if not Assigned(ResultEdit2) then
    ResultEdit2 := TEdit.create(NameForm);
  ResultEdit2.parent := NameForm;
  with ResultEdit2 do
  begin
    left := 440;
    top := 220;
    Width := 100;
    Font.name := 'Times New Roman';
    Font.Size := 12;
    Alignment := taRightJustify;
    ReadOnly := true;
    Text := '';
  end;
  result := ResultEdit2;
end;

function TNumberOfDonations.GenEdit3(NameForm: TwinControl): TEdit;
begin
  if not Assigned(ResultEdit3) then
    ResultEdit3 := TEdit.create(NameForm);
  ResultEdit3.parent := NameForm;
  with ResultEdit3 do
  begin
    left := 440;
    top := 260;
    Width := 100;
    Font.name := 'Times New Roman';
    Font.Size := 12;
    Alignment := taRightJustify;
    ReadOnly := true;
    Text := '';
  end;
  result := ResultEdit3;
end;

function TNumberOfDonations.GetButtonAction(NameForm: TwinControl): TBitBtn;
begin
  if not Assigned(ButtonAction) then
    ButtonAction := TBitBtn.create(NameForm);
  ButtonAction.parent := NameForm;
  with ButtonAction do
  begin
    left := 385;
    top := 350;
    Font.name := 'Times New Roman';
    Font.Size := 12;
    Caption := '������������';
    Width := 130;
  end;
  ButtonAction.OnClick := ButtonAct;
  result := ButtonAction;
end;

function TNumberOfDonations.GetButtonBack(NameForm: TwinControl): TBitBtn;
begin
  if not Assigned(ButtonBack) then
    ButtonBack := TBitBtn.create(NameForm);
  ButtonBack.parent := NameForm;
  with ButtonBack do
  begin
    left := 780;
    top := 350;
    Font.name := 'Times New Roman';
    Font.Size := 12;
    Caption := '�����';
    OnClick := ButtonBackClick;
  end;

  result := ButtonBack;
end;

function TNumberOfDonations.GetCalendarEndDate(NameForm: TwinControl)
  : TDateTimePicker;
begin
  if not Assigned(EndDateCal) then
  begin
    EndDateCal := TDateTimePicker.create(NameForm);
    EndDateCal.parent := NameForm;
    with EndDateCal do
    begin
      left := 250;
      top := 120;
      Font.Size := 12;
      Date := EncodeDate(YearOf(Now), MonthOf(Now), 1) - 1;
    end;
  end;
  result := EndDateCal;
end;

function TNumberOfDonations.GetCalendarStartDate(NameForm: TwinControl)
  : TDateTimePicker;
begin
  if not Assigned(StartDateCal) then
  begin
    StartDateCal := TDateTimePicker.create(NameForm);
    StartDateCal.parent := NameForm;
    with StartDateCal do
    begin
      left := 250;
      top := 80;
      Font.Size := 12;
      Date := EncodeDate(YearOf(Now), MonthOf(Now) - 1, 1);
    end;
  end;
  result := StartDateCal;
end;

function TNumberOfDonations.GetLabelEndDate(NameForm: TwinControl): TLabel;
begin
  if not Assigned(EndDate) then
    EndDate := TLabel.create(NameForm);
  EndDate.parent := NameForm;
  with EndDate do
  begin
    left := 50;
    top := 120;
    Font.name := 'Times New Roman';
    Font.Size := 20;
    Caption := '�������� ����:';
  end;
  result := EndDate;
end;

function TNumberOfDonations.GetLabelNameStat1(NameForm: TwinControl): TLabel;
begin
  if not Assigned(NameStat1) then
    NameStat1 := TLabel.create(NameForm);
  NameStat1.parent := NameForm;
  with NameStat1 do
  begin
    left := 50;
    top := 180;
    Font.name := 'Times New Roman';
    Font.Size := 20;
    Caption := '���������� ������� �����:';
  end;
  result := NameStat1;
end;

function TNumberOfDonations.GetLabelNameStat2(NameForm: TwinControl): TLabel;
begin
  if not Assigned(NameStat2) then
    NameStat2 := TLabel.create(NameForm);
  NameStat2.parent := NameForm;
  with NameStat2 do
  begin
    left := 50;
    top := 220;
    Font.name := 'Times New Roman';
    Font.Size := 20;
    Caption := '���������� ������� ������:';
  end;
  result := NameStat2;
end;

function TNumberOfDonations.GetLabelNameStat3(NameForm: TwinControl): TLabel;
begin
  if not Assigned(NameStat3) then
    NameStat3 := TLabel.create(NameForm);
  NameStat3.parent := NameForm;
  with NameStat3 do
  begin
    left := 50;
    top := 260;
    Font.name := 'Times New Roman';
    Font.Size := 20;
    Caption := '���������� ������� ����������:';
  end;
  result := NameStat3;
end;

function TNumberOfDonations.GetLabelStartDate(NameForm: TwinControl): TLabel;
begin
  if not Assigned(StartDate) then
    StartDate := TLabel.create(NameForm);
  StartDate.parent := NameForm;
  with StartDate do
  begin
    left := 50;
    top := 80;
    Font.name := 'Times New Roman';
    Font.Size := 20;
    Caption := '��������� ����:';
  end;
  result := StartDate;
end;

end.