unit VQBBloodProduct;

interface

uses
  SysUtils, StdCtrls, Buttons,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs,
  MQBTheNumberOfConservedBlood,
  MQBTheNumberOfWholeBlood,
  UVFLabel,
  UVFTitleLabel,
  UVFEdit,
  UVFDateTimePicker,
  UVFBitBtn;

type
  TBloodProduct = class(TObject)
  private
    StartDate: ITempLabelTag5;
    EndDate: ITempLabelTag5;
    NameStat1: ITempLabelTag5;
    NameStat2: ITempLabelTag5;
    Title: ITitleLabelTag5;

    ResultEdit1: IEditTag5;
    ResultEdit2: IEditTag5;

    StartDateCal: IDTPickerTag5;
    EndDateCal: IDTPickerTag5;

    ButtonAction: IBitBtnTag5;

    CurrentForm: TForm;

    { NameStat3: TLabel;
      ResultEdit3: TEdit; }

    TheNumberOfConservedBlood: ITheNumberOfConservedBlood;
    TheNumberOfWholeBlood: ITheNumberOfWholeBlood;

  public
    function GetLabelStartDate(NameForm: TForm): TLabel;
    function GetLabelEndDate(NameForm: TForm): TLabel;
    function GetLabelNameStat1(NameForm: TForm): TLabel;
    function GetLabelNameStat2(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetEdit1(NameForm: TForm): TEdit;
    function GetEdit2(NameForm: TForm): TEdit;

    function GetCalendarStartDate(NameForm: TForm): TDateTimePicker;
    function GetCalendarEndDate(NameForm: TForm): TDateTimePicker;

    function GetButtonAction(NameForm: TForm): TBitBtn;
    procedure ButtonAct(Sender: TObject);
    constructor create(form: TForm);

    { function GetLabelNameStat3(NameForm: TwinControl): TLabel;
      function GetEdit3(NameForm: TwinControl): TEdit;
      ; }

  end;

implementation

{ TNumberOfDonations }

{
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


}

{ TBloodProduct }

procedure TBloodProduct.ButtonAct(Sender: TObject);
begin
  if StartDateCal.GetData > GetCalendarEndDate(CurrentForm).Date
  then
  begin
    ShowMessage('�������� ���� �� ����� ���� ������ ���������');
    exit;
  end
  else
  begin
    if not Assigned(TheNumberOfConservedBlood) then
      TheNumberOfConservedBlood := TTheNumberOfConservedBlood.create
        (StartDateCal.GetData, EndDateCal.GetData);
    ResultEdit1.WriteText(TheNumberOfConservedBlood.GetValue);
    TheNumberOfConservedBlood := nil;
    if not Assigned(TheNumberOfWholeBlood) then
      TheNumberOfWholeBlood := TTheNumberOfWholeBlood.create
        (StartDateCal.GetData, EndDateCal.GetData);
    ResultEdit2.WriteText(TheNumberOfWholeBlood.GetValue);
    TheNumberOfWholeBlood := nil;
    { if not Assigned(TheNumberOfTromboDonations) then
      TheNumberOfTromboDonations := TTheNumberOfTromboDonations.create
      (GetCalendarStartDate(form1).Date, GetCalendarEndDate(form1).Date);
      ResultEdit3.Text := TheNumberOfTromboDonations.GetValue;
      TheNumberOfTromboDonations := nil; }
    ShowMessage('������ ��������!');
  end;

end;

constructor TBloodProduct.create(form: TForm);
begin
  CurrentForm:=Form;

  GetLabelStartDate(form);
  GetLabelEndDate(form);
  GetLabelNameStat1(form);
  GetLabelNameStat2(form);
  GetLabelTitle(form);


  GetCalendarStartDate(form);
  GetCalendarEndDate(form);

  GetEdit1(form);
  GetEdit2(form);

  GetButtonAction(form);

  { GetLabelNameStat3(form1);
    GetEdit3(form1); }
end;

function TBloodProduct.GetEdit1(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit1) then
    ResultEdit1 := TEditTag5.create;
  Result:=ResultEdit1.GetEdit(520, 180, 100, 12, NameForm);
end;

function TBloodProduct.GetEdit2(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit2) then
    ResultEdit2 := TEditTag5.create;
  Result:=ResultEdit2.GetEdit(520, 220, 100, 12, NameForm);
end;

function TBloodProduct.GetButtonAction(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAction) then
    ButtonAction := TBitBtnTag5.create;
  Result:=ButtonAction.GetBitBtn(ButtonAct, NameForm);
end;

function TBloodProduct.GetCalendarStartDate(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(StartDateCal) then
    StartDateCal:=TDTPickerTag5.Create;
  result:=StartDateCal.GetDTPicker(250, 80, EncodeDate(YearOf(Now), MonthOf(Now) - 1, 1), NameForm);
end;

function TBloodProduct.GetCalendarEndDate(NameForm: TForm): TDateTimePicker;
begin
  if not Assigned(EndDateCal) then
    EndDateCal:=TDTPickerTag5.Create;
  result:=EndDateCal.GetDTPicker(250, 120, EncodeDate(YearOf(Now), MonthOf(Now), 1) - 1, NameForm);
end;

function TBloodProduct.GetLabelEndDate(NameForm: TForm): TLabel;
begin
  if not Assigned(EndDate) then
    EndDate := TTempLabelTag5.create;
  result := EndDate.GetTempLabel(50, 120, 20, '�������� ����:',
    NameForm);
end;

function TBloodProduct.GetLabelNameStat1(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat1) then
    NameStat1 := TTempLabelTag5.create;
  result := NameStat1.GetTempLabel(50, 180, 20, '���������� ����� �� ���������������:',
    NameForm);
end;

function TBloodProduct.GetLabelNameStat2(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat2) then
    NameStat2 := TTempLabelTag5.create;
  result := NameStat2.GetTempLabel(50, 220, 20, '���������� ������� �����:',
    NameForm);
end;

function TBloodProduct.GetLabelStartDate(NameForm: TForm): TLabel;
begin
  if not Assigned(StartDate) then
    StartDate := TTempLabelTag5.create;
  result := StartDate.GetTempLabel(50, 80, 20, '��������� ����:', NameForm);
end;

function TBloodProduct.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(25, '��������� �����', NameForm);
end;

end.
