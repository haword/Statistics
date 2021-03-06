unit VQBBloodProduct;

interface

uses
  SysUtils, StdCtrls, Buttons,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs,
  MQBTheAmountOfBloodOnPreserving,
  MQBTheNumberOfWholeBlood,
  MQBTheNumberOfConservedBlood,
  MQBTheAmountOfReinfusionWithAPA,
  MQBTheAmountOfReinfusionWithTrombo,
  UVFLabel,
  UVFTitleLabel,
  UVFEdit,
  UVFDateTimePicker,
  UVFBitBtn,
  UMSGlobalVariant;

type
  IBloodProduct = interface
  end;

  TBloodProduct = class(TGlobalVariant)
  private
    StartDate: TTempLabelTag5;
    EndDate: TTempLabelTag5;
    NameStat1: TTempLabelTag5;
    NameStat2: TTempLabelTag5;
    NameStat3: TTempLabelTag5;
    NameStat4: TTempLabelTag5;
    NameStat5: TTempLabelTag5;
    Title: TTitleLabelTag5;
    ResultEdit1: TEditTag5;
    ResultEdit2: TEditTag5;
    ResultEdit3: TEditTag5;
    ResultEdit4: TEditTag5;
    ResultEdit5: TEditTag5;
    StartDateCal: TDTPickerTag5;
    EndDateCal: TDTPickerTag5;
    ButtonAction: TBitBtnTag5;
    CurrentForm: TForm;
    TheAmountOfBloodOnPreserving: ITheAmountOfBloodOnPreserving;
    TheNumberOfWholeBlood: ITheNumberOfWholeBlood;
    TheNumberOfConservedBlood: ITheNumberOfConservedBlood;
    TheAmountOfReinfusionWithAPA: ITheAmountOfReinfusionWithAPA;
    TheAmountOfReinfusionWithTrombo: ITheAmountOfReinfusionWithTrombo;
    function GetLabelStartDate(NameForm: TForm): TLabel;
    function GetLabelEndDate(NameForm: TForm): TLabel;
    function GetLabelNameStat1(NameForm: TForm): TLabel;
    function GetLabelNameStat2(NameForm: TForm): TLabel;
    function GetLabelNameStat3(NameForm: TForm): TLabel;
    function GetLabelNameStat4(NameForm: TForm): TLabel;
    function GetLabelNameStat5(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;
    function GetEdit1(NameForm: TForm): TEdit;
    function GetEdit2(NameForm: TForm): TEdit;
    function GetEdit3(NameForm: TForm): TEdit;
    function GetEdit4(NameForm: TForm): TEdit;
    function GetEdit5(NameForm: TForm): TEdit;
    function GetCalendarStartDate(NameForm: TForm): TDateTimePicker;
    function GetCalendarEndDate(NameForm: TForm): TDateTimePicker;
    function GetButtonAction(NameForm: TForm): TBitBtn;
    procedure ButtonAct(Sender: TObject);
    procedure Show;
  public
    constructor create(form: TForm);  override;
    destructor destroy;  override;
  end;

implementation

{ TBloodProduct }
constructor TBloodProduct.create(form: TForm);
begin
  CurrentForm:=Form;

  GetLabelStartDate(form);
  GetLabelEndDate(form);
  GetLabelNameStat1(form);
  GetLabelNameStat2(form);
  GetLabelNameStat3(form);
  GetLabelNameStat4(form);
  GetLabelNameStat5(form);
  GetLabelTitle(form);


  GetCalendarStartDate(form);
  GetCalendarEndDate(form);

  GetEdit1(form);
  GetEdit2(form);
  GetEdit3(form);
  GetEdit4(form);
  GetEdit5(form);

  GetButtonAction(form);
  Show;
  inherited;
end;

destructor TBloodProduct.destroy;
begin
  StartDate.destroy;
  EndDate.destroy;
  NameStat1.destroy;
  NameStat2.destroy;
  NameStat3.destroy;
  NameStat4.destroy;
  NameStat5.destroy;
  Title.destroy;

  EndDateCal.destroy;
  StartDateCal.destroy;

  ResultEdit1.destroy;
  ResultEdit2.destroy;
  ResultEdit3.destroy;
  ResultEdit4.destroy;
  ResultEdit5.destroy;

  ButtonAction.destroy;
  inherited;
end;

procedure TBloodProduct.ButtonAct(Sender: TObject);
begin
  if StartDateCal.GetDate > GetCalendarEndDate(CurrentForm).Date
  then
  begin
    ShowMessage('�������� ���� �� ����� ���� ������ ���������');
    exit;
  end
  else
  begin
    if not Assigned(TheNumberOfConservedBlood) then
      TheAmountOfBloodOnPreserving := TTheAmountOfBloodOnPreserving.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit1.WriteText(TheAmountOfBloodOnPreserving.GetValue);
    TheAmountOfBloodOnPreserving := nil;

    if not Assigned(TheNumberOfWholeBlood) then
      TheNumberOfWholeBlood := TTheNumberOfWholeBlood.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit2.WriteText(TheNumberOfWholeBlood.GetValue);
    TheNumberOfWholeBlood := nil;

    if not Assigned(TheNumberOfConservedBlood) then
      TheNumberOfConservedBlood := TTheNumberOfConservedBlood.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit3.WriteText(TheNumberOfConservedBlood.GetValue);
    TheNumberOfConservedBlood := nil;

    if not Assigned(TheAmountOfReinfusionWithAPA) then
      TheAmountOfReinfusionWithAPA := TTheAmountOfReinfusionWithAPA.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit4.WriteText(TheAmountOfReinfusionWithAPA.GetValue);
    TheAmountOfReinfusionWithAPA := nil;

    if not Assigned(TheAmountOfReinfusionWithTrombo) then
      TheAmountOfReinfusionWithTrombo := TTheAmountOfReinfusionWithTrombo.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit5.WriteText(TheAmountOfReinfusionWithTrombo.GetValue);
    TheAmountOfReinfusionWithTrombo := nil;

    ShowMessage('������ ��������!');
  end;

end;

function TBloodProduct.GetEdit1(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit1) then
    ResultEdit1 := TEditTag5.create;
  Result:=ResultEdit1.GetEdit(520, 180, 100, 12, True, NameForm);
end;

function TBloodProduct.GetEdit2(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit2) then
    ResultEdit2 := TEditTag5.create;
  Result:=ResultEdit2.GetEdit(520, 220, 100, 12, True, NameForm);
end;

function TBloodProduct.GetEdit3(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit3) then
    ResultEdit3 := TEditTag5.create;
  Result:=ResultEdit3.GetEdit(520, 260, 100, 12, True, NameForm);
end;

function TBloodProduct.GetEdit4(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit4) then
    ResultEdit4 := TEditTag5.create;
  Result:=ResultEdit4.GetEdit(520, 300, 100, 12, True, NameForm);
end;

function TBloodProduct.GetEdit5(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit5) then
    ResultEdit5 := TEditTag5.create;
  Result:=ResultEdit5.GetEdit(520, 340, 100, 12, True, NameForm);
end;

function TBloodProduct.GetButtonAction(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAction) then
    ButtonAction := TBitBtnTag5.create;
  Result:=ButtonAction.GetBitBtn(360, 590, '������������', ButtonAct, NameForm);
end;

function TBloodProduct.GetCalendarStartDate(NameForm: TForm)
  : TDateTimePicker;
var
  CYear, CMonth: Word;
begin
  if MonthOf(Now)=1 then CMonth:=12 else CMonth:=MonthOf(Now) - 1;
  if CMonth=12 then CYear:=YearOf(Now)-1 else CYear:=YearOf(Now);
  if not Assigned(StartDateCal) then
    StartDateCal:=TDTPickerTag5.Create;
  result:=StartDateCal.GetDTPicker(250, 80, EncodeDate(CYear, CMonth, 1), NameForm);
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

function TBloodProduct.GetLabelNameStat3(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat3) then
    NameStat3 := TTempLabelTag5.create;
  result := NameStat3.GetTempLabel(50, 260, 20, '���������� ���������������� �����:',
    NameForm);
end;

function TBloodProduct.GetLabelNameStat4(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat4) then
    NameStat4 := TTempLabelTag5.create;
  result := NameStat4.GetTempLabel(50, 300, 20, '����� ��������� � ���:',
    NameForm);
end;

function TBloodProduct.GetLabelNameStat5(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat5) then
    NameStat5 := TTempLabelTag5.create;
  result := NameStat5.GetTempLabel(50, 340, 20, '����� ��������� � ����������:',
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

procedure TBloodProduct.Show;
begin
  StartDate.Visible(True);
  EndDate.Visible(True);
  NameStat1.Visible(True);
  NameStat2.Visible(True);
  NameStat3.Visible(True);
  NameStat4.Visible(True);
  NameStat5.Visible(True);

  StartDateCal.Visible(True);
  EndDateCal.Visible(True);

  ResultEdit1.Visible(True);
  ResultEdit2.Visible(True);
  ResultEdit3.Visible(True);
  ResultEdit4.Visible(True);
  ResultEdit5.Visible(True);

  ButtonAction.Visible(True);
end;
end.
