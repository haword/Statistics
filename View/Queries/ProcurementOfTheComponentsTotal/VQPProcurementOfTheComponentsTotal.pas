unit VQPProcurementOfTheComponentsTotal;

interface

uses
  SysUtils, StdCtrls, Buttons,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Vcl.ExtCtrls,
  MQPHarvestingOfErSuspensionsValumeTotal,
  MQPHarvestingOfErSuspensionsDosesTotal,
  MQPHarvestingOfPlasmaVolumeTotal,
  MQPHarvestingOfPlasmaDosesTotal,
  MQPHarvestingOfPlasmaBloodVolumeTotal,
  MQPHarvestingOfPlasmaBloodDosesTotal,
  MQPHarvestingOfPlasmaAPAVolumeTotal,
  MQPHarvestingOfPlasmaAPADosesTotal,
  MQPHarvestingOfTromboVolumeTotal,
  MQPHarvestingOfTromboDosesTotal,
  MQPHarvestingOfTromboPacetsTotal,
  MQPHarvestingOfFiltratVolumeTotal,
  MQPHarvestingOfFiltratDosesTotal,
  UVFLabel,
  UVFTitleLabel,
  UVFEdit,
  UVFDateTimePicker,
  UVFBitBtn,
  UVFPanel;

type
  IProcurementOfTheComponentsTotal = interface
  end;

  TProcurementOfTheComponentsTotal = class(TInterfacedObject, IProcurementOfTheComponentsTotal)
  private
    StartDate: ITempLabelTag5;
    EndDate: ITempLabelTag5;
    Volume: ITempLabelTag5;
    Doses: ITempLabelTag5;
    Pacets: ITempLabelTag5;
    NameStat1: ITempLabelTag5;
    NameStat2: ITempLabelTag5;
    NameStat3: ITempLabelTag5;
    NameStat4: ITempLabelTag5;
    NameStat5: ITempLabelTag5;
    NameStat6: ITempLabelTag5;

    Title: ITitleLabelTag5;

    ErSuspVolume: IEditTag5;
    ErSuspDoses: IEditTag5;
    PlasmaTotalVolume: IEditTag5;
    PlasmaTotalDoses: IEditTag5;
    PlasmaBloodVolume: IEditTag5;
    PlasmaBloodDoses: IEditTag5;
    PlasmaAPAVolume: IEditTag5;
    PlasmaAPADoses: IEditTag5;
    TromboVolume: IEditTag5;
    TromboDoses: IEditTag5;
    TromboPacets: IEditTag5;
    FiltratVolume: IEditTag5;
    FiltratDoses: IEditTag5;

    StartDateCal: IDTPickerTag5;
    EndDateCal: IDTPickerTag5;

    PanelVertical: ITempPanelTag5;
    PanelGorizontal: ITempPanelTag5;

    ButtonAction: IBitBtnTag5;

    CurrentForm: TForm;

    HarvestingOfErSuspensionsValumeTotal: IHarvestingOfErSuspensionsValumeTotal;
    HarvestingOfErSuspensionsDosesTotal: IHarvestingOfErSuspensionsDosesTotal;
    HarvestingOfPlasmaVolumeTotal: IHarvestingOfPlasmaVolumeTotal;
    HarvestingOfPlasmaDosesTotal: IHarvestingOfPlasmaDosesTotal;
    HarvestingOfPlasmaBloodVolumeTotal: IHarvestingOfPlasmaBloodVolumeTotal;
    HarvestingOfPlasmaBloodDosesTotal: IHarvestingOfPlasmaBloodDosesTotal;
    HarvestingOfPlasmaAPAVolumeTotal: IHarvestingOfPlasmaAPAVolumeTotal;
    HarvestingOfPlasmaAPADosesTotal: IHarvestingOfPlasmaAPADosesTotal;
    HarvestingOfTromboVolumeTotal: IHarvestingOfTromboVolumeTotal;
    HarvestingOfTromboDosesTotal: IHarvestingOfTromboDosesTotal;
    HarvestingOfTromboPacetsTotal: IHarvestingOfTromboPacetsTotal;
    HarvestingOfFiltratVolumeTotal: IHarvestingOfFiltratVolumeTotal;
    HarvestingOfFiltratDosesTotal: IHarvestingOfFiltratDosesTotal;
    function GetLabelStartDate(NameForm: TForm): TLabel;
    function GetLabelEndDate(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelDoses(NameForm: TForm): TLabel;
    function GetLabelPacets(NameForm: TForm): TLabel;
    function GetLabelNameStat1(NameForm: TForm): TLabel;
    function GetLabelNameStat2(NameForm: TForm): TLabel;
    function GetLabelNameStat3(NameForm: TForm): TLabel;
    function GetLabelNameStat4(NameForm: TForm): TLabel;
    function GetLabelNameStat5(NameForm: TForm): TLabel;
    function GetLabelNameStat6(NameForm: TForm): TLabel;

    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetPanelVertical(NameForm: TForm): TPanel;
    function GetPanelGorizontal(NameForm: TForm): TPanel;

    function GetErSuspVolume(NameForm: TForm): TEdit;
    function GetErSuspDoses(NameForm: TForm): TEdit;
    function GetPlasmaTotalVolume(NameForm: TForm): TEdit;
    function GetPlasmaTotalDoses(NameForm: TForm): TEdit;
    function GetPlasmaBloodVolume(NameForm: TForm): TEdit;
    function GetPlasmaBloodDoses(NameForm: TForm): TEdit;
    function GetPlasmaAPAVolume(NameForm: TForm): TEdit;
    function GetPlasmaAPADoses(NameForm: TForm): TEdit;
    function GetTromboVolume(NameForm: TForm): TEdit;
    function GetTromboDoses(NameForm: TForm): TEdit;
    function GetTromboPacets(NameForm: TForm): TEdit;
    function GetFiltratVolume(NameForm: TForm): TEdit;
    function GetFiltratDoses(NameForm: TForm): TEdit;

    function GetCalendarStartDate(NameForm: TForm): TDateTimePicker;
    function GetCalendarEndDate(NameForm: TForm): TDateTimePicker;

    function GetButtonAction(NameForm: TForm): TBitBtn;
    procedure ButtonAct(Sender: TObject);
  public
    constructor create(form: TForm);
  end;

implementation

{ TProcurementOfTheComponentsTotal }

procedure TProcurementOfTheComponentsTotal.ButtonAct(Sender: TObject);
begin
  if StartDateCal.GetDate > EndDateCal.GetDate then
  begin
    ShowMessage('�������� ���� �� ����� ���� ������ ���������');
    exit;
  end
  else
  begin
    if not Assigned(HarvestingOfErSuspensionsValumeTotal) then
      HarvestingOfErSuspensionsValumeTotal := THarvestingOfErSuspensionsValumeTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ErSuspVolume.WriteText(HarvestingOfErSuspensionsValumeTotal.GetValue);
    HarvestingOfErSuspensionsValumeTotal := nil;

    if not Assigned(HarvestingOfErSuspensionsDosesTotal) then
      HarvestingOfErSuspensionsDosesTotal := THarvestingOfErSuspensionsDosesTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ErSuspDoses.WriteText(HarvestingOfErSuspensionsDosesTotal.GetValue);
    HarvestingOfErSuspensionsDosesTotal := nil;

    if not Assigned(HarvestingOfPlasmaVolumeTotal) then
      HarvestingOfPlasmaVolumeTotal := THarvestingOfPlasmaVolumeTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    PlasmaTotalVolume.WriteText(HarvestingOfPlasmaVolumeTotal.GetValue);
    HarvestingOfPlasmaVolumeTotal := nil;

    if not Assigned(HarvestingOfPlasmaDosesTotal) then
      HarvestingOfPlasmaDosesTotal := THarvestingOfPlasmaDosesTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    PlasmaTotalDoses.WriteText(HarvestingOfPlasmaDosesTotal.GetValue);
    HarvestingOfPlasmaDosesTotal := nil;

    if not Assigned(HarvestingOfPlasmaBloodVolumeTotal) then
      HarvestingOfPlasmaBloodVolumeTotal := THarvestingOfPlasmaBloodVolumeTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    PlasmaBloodVolume.WriteText(HarvestingOfPlasmaBloodVolumeTotal.GetValue);
    HarvestingOfPlasmaBloodVolumeTotal := nil;

    if not Assigned(HarvestingOfPlasmaBloodDosesTotal) then
      HarvestingOfPlasmaBloodDosesTotal := THarvestingOfPlasmaBloodDosesTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    PlasmaBloodDoses.WriteText(HarvestingOfPlasmaBloodDosesTotal.GetValue);
    HarvestingOfPlasmaBloodDosesTotal := nil;

    if not Assigned(HarvestingOfPlasmaAPAVolumeTotal) then
      HarvestingOfPlasmaAPAVolumeTotal := THarvestingOfPlasmaAPAVolumeTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    PlasmaAPAVolume.WriteText(HarvestingOfPlasmaAPAVolumeTotal.GetValue);
    HarvestingOfPlasmaAPAVolumeTotal := nil;

    if not Assigned(HarvestingOfPlasmaAPADosesTotal) then
      HarvestingOfPlasmaAPADosesTotal := THarvestingOfPlasmaAPADosesTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    PlasmaAPADoses.WriteText(HarvestingOfPlasmaAPADosesTotal.GetValue);
    HarvestingOfPlasmaAPADosesTotal := nil;

    if not Assigned(HarvestingOfTromboVolumeTotal) then
      HarvestingOfTromboVolumeTotal := THarvestingOfTromboVolumeTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    TromboVolume.WriteText(HarvestingOfTromboVolumeTotal.GetValue);
    HarvestingOfTromboVolumeTotal := nil;

    if not Assigned(HarvestingOfTromboDosesTotal) then
      HarvestingOfTromboDosesTotal := THarvestingOfTromboDosesTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    TromboDoses.WriteText(HarvestingOfTromboDosesTotal.GetValue);
    HarvestingOfTromboDosesTotal := nil;

    if not Assigned(HarvestingOfTromboPacetsTotal) then
      HarvestingOfTromboPacetsTotal := THarvestingOfTromboPacetsTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    TromboPacets.WriteText(HarvestingOfTromboPacetsTotal.GetValue);
    HarvestingOfTromboPacetsTotal := nil;

    if not Assigned(HarvestingOfFiltratVolumeTotal) then
      HarvestingOfFiltratVolumeTotal := THarvestingOfFiltratVolumeTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    FiltratVolume.WriteText(HarvestingOfFiltratVolumeTotal.GetValue);
    HarvestingOfFiltratVolumeTotal := nil;

    if not Assigned(HarvestingOfFiltratDosesTotal) then
      HarvestingOfFiltratDosesTotal := THarvestingOfFiltratDosesTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    FiltratDoses.WriteText(HarvestingOfFiltratDosesTotal.GetValue);
    HarvestingOfFiltratDosesTotal := nil;

    ShowMessage('������ ��������!');
  end;
end;

constructor TProcurementOfTheComponentsTotal.create(form: TForm);
begin
  CurrentForm := form;

  GetLabelStartDate(CurrentForm);
  GetLabelEndDate(CurrentForm);
  GetLabelVolume(CurrentForm);
  GetLabelDoses(CurrentForm);
  GetLabelPacets(CurrentForm);
  GetLabelNameStat1(CurrentForm);
  GetLabelNameStat2(CurrentForm);
  GetLabelNameStat3(CurrentForm);
  GetLabelNameStat4(CurrentForm);
  GetLabelNameStat5(CurrentForm);
  GetLabelNameStat6(CurrentForm);

  GetLabelTitle(CurrentForm);

  GetCalendarStartDate(CurrentForm);
  GetCalendarEndDate(CurrentForm);

  GetPanelVertical(CurrentForm);
  GetPanelGorizontal(CurrentForm);

  GetErSuspVolume(CurrentForm);
  GetErSuspDoses(CurrentForm);
  GetPlasmaTotalVolume(CurrentForm);
  GetPlasmaTotalDoses(CurrentForm);
  GetPlasmaBloodVolume(CurrentForm);
  GetPlasmaBloodDoses(CurrentForm);
  GetPlasmaAPAVolume(CurrentForm);
  GetPlasmaAPADoses(CurrentForm);
  GetTromboVolume(CurrentForm);
  GetTromboDoses(CurrentForm);
  GetTromboPacets(CurrentForm);
  GetFiltratVolume(CurrentForm);
  GetFiltratDoses(CurrentForm);

  GetButtonAction(CurrentForm);
end;

//Button

function TProcurementOfTheComponentsTotal.GetButtonAction(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAction) then
    ButtonAction := TBitBtnTag5.create;
  Result:=ButtonAction.GetBitBtn(385, 510, '������������', ButtonAct, NameForm);
end;

//DataTimePicker

function TProcurementOfTheComponentsTotal.GetCalendarStartDate(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(StartDateCal) then
    StartDateCal:=TDTPickerTag5.Create;
  result:=StartDateCal.GetDTPicker(250, 80, EncodeDate(YearOf(Now), MonthOf(Now) - 1, 1), NameForm);
end;

function TProcurementOfTheComponentsTotal.GetCalendarEndDate(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(EndDateCal) then
    EndDateCal:=TDTPickerTag5.Create;
  result:=EndDateCal.GetDTPicker(250, 120, EncodeDate(YearOf(Now), MonthOf(Now), 1) - 1, NameForm);
end;

//Edit

function TProcurementOfTheComponentsTotal.GetErSuspDoses(
  NameForm: TForm): TEdit;
begin
  if not Assigned(ErSuspDoses) then
    ErSuspDoses := TEditTag5.create;
  Result:=ErSuspDoses.GetEdit(450, 220, 80, 12, True, NameForm);
end;

function TProcurementOfTheComponentsTotal.GetErSuspVolume(
  NameForm: TForm): TEdit;
begin
  if not Assigned(ErSuspVolume) then
    ErSuspVolume := TEditTag5.create;
  Result:=ErSuspVolume.GetEdit(290, 220, 110, 12, True, NameForm);
end;

function TProcurementOfTheComponentsTotal.GetFiltratDoses(
  NameForm: TForm): TEdit;
begin
  if not Assigned(FiltratDoses) then
    FiltratDoses := TEditTag5.create;
  Result:=FiltratDoses.GetEdit(450, 420, 80, 12, True, NameForm);
end;

function TProcurementOfTheComponentsTotal.GetFiltratVolume(
  NameForm: TForm): TEdit;
begin
  if not Assigned(FiltratVolume) then
    FiltratVolume := TEditTag5.create;
  Result:=FiltratVolume.GetEdit(290, 420, 110, 12, True, NameForm);
end;

function TProcurementOfTheComponentsTotal.GetPlasmaAPADoses(
  NameForm: TForm): TEdit;
begin
  if not Assigned(PlasmaAPADoses) then
    PlasmaAPADoses := TEditTag5.create;
  Result:=PlasmaAPADoses.GetEdit(450, 340, 80, 12, True, NameForm);
end;

function TProcurementOfTheComponentsTotal.GetPlasmaAPAVolume(
  NameForm: TForm): TEdit;
begin
  if not Assigned(PlasmaAPAVolume) then
    PlasmaAPAVolume := TEditTag5.create;
  Result:=PlasmaAPAVolume.GetEdit(290, 340, 110, 12, True, NameForm);
end;

function TProcurementOfTheComponentsTotal.GetPlasmaBloodDoses(
  NameForm: TForm): TEdit;
begin
  if not Assigned(PlasmaBloodDoses) then
    PlasmaBloodDoses := TEditTag5.create;
  Result:=PlasmaBloodDoses.GetEdit(450, 300, 80, 12, True, NameForm);
end;

function TProcurementOfTheComponentsTotal.GetPlasmaBloodVolume(
  NameForm: TForm): TEdit;
begin
  if not Assigned(PlasmaBloodVolume) then
    PlasmaBloodVolume := TEditTag5.create;
  Result:=PlasmaBloodVolume.GetEdit(290, 300, 110, 12, True, NameForm);
end;

function TProcurementOfTheComponentsTotal.GetPlasmaTotalDoses(
  NameForm: TForm): TEdit;
begin
  if not Assigned(PlasmaTotalDoses) then
    PlasmaTotalDoses := TEditTag5.create;
  Result:=PlasmaTotalDoses.GetEdit(450, 260, 80, 12, True, NameForm);
end;

function TProcurementOfTheComponentsTotal.GetPlasmaTotalVolume(
  NameForm: TForm): TEdit;
begin
  if not Assigned(PlasmaTotalVolume) then
    PlasmaTotalVolume := TEditTag5.create;
  Result:=PlasmaTotalVolume.GetEdit(290, 260, 110, 12, True, NameForm);
end;

function TProcurementOfTheComponentsTotal.GetTromboDoses(
  NameForm: TForm): TEdit;
begin
  if not Assigned(TromboDoses) then
    TromboDoses := TEditTag5.create;
  Result:=TromboDoses.GetEdit(450, 380, 80, 12, True, NameForm);
end;

function TProcurementOfTheComponentsTotal.GetTromboPacets(
  NameForm: TForm): TEdit;
begin
  if not Assigned(TromboPacets) then
    TromboPacets := TEditTag5.create;
  Result:=TromboPacets.GetEdit(580, 380, 80, 12, True, NameForm);
end;

function TProcurementOfTheComponentsTotal.GetTromboVolume(
  NameForm: TForm): TEdit;
begin
  if not Assigned(TromboVolume) then
    TromboVolume := TEditTag5.create;
  Result:=TromboVolume.GetEdit(290, 380, 110, 12, True, NameForm);
end;

//Label

function TProcurementOfTheComponentsTotal.GetLabelNameStat1(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat1) then
    NameStat1 := TTempLabelTag5.create;
  Result:=NameStat1.GetTempLabel(50, 220, 16, '��. ������:', NameForm);
end;

function TProcurementOfTheComponentsTotal.GetLabelNameStat2(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat2) then
    NameStat2 := TTempLabelTag5.create;
  Result:=NameStat2.GetTempLabel(50, 260, 16, '������, �����:', NameForm);
end;

function TProcurementOfTheComponentsTotal.GetLabelNameStat3(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat3) then
    NameStat3 := TTempLabelTag5.create;
  Result:=NameStat3.GetTempLabel(50, 300, 16, '������, �����:', NameForm);
end;

function TProcurementOfTheComponentsTotal.GetLabelNameStat4(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat4) then
    NameStat4 := TTempLabelTag5.create;
  Result:=NameStat4.GetTempLabel(50, 340, 16, '������, ���:', NameForm);
end;

function TProcurementOfTheComponentsTotal.GetLabelNameStat5(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat5) then
    NameStat5 := TTempLabelTag5.create;
  Result:=NameStat5.GetTempLabel(50, 380, 16, '����������������:', NameForm);
end;

function TProcurementOfTheComponentsTotal.GetLabelNameStat6(
  NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat6) then
    NameStat6 := TTempLabelTag5.create;
  Result:=NameStat6.GetTempLabel(50, 420, 16, '��������:', NameForm);
end;

function TProcurementOfTheComponentsTotal.GetLabelPacets(
  NameForm: TForm): TLabel;
begin
  if not Assigned(Pacets) then
    Pacets := TTempLabelTag5.create;
  Result:=Pacets.GetTempLabel(575, 180, 16, '������, ��.', NameForm);
end;

function TProcurementOfTheComponentsTotal.GetLabelDoses(
  NameForm: TForm): TLabel;
begin
  if not Assigned(Doses) then
    Doses := TTempLabelTag5.create;
  Result:=Doses.GetTempLabel(450, 180, 16, '����, ��.', NameForm);
end;

function TProcurementOfTheComponentsTotal.GetLabelVolume(
  NameForm: TForm): TLabel;
begin
  if not Assigned(Volume) then
    Volume := TTempLabelTag5.create;
  Result:=Volume.GetTempLabel(300, 180, 16, '�����, ��.', NameForm);
end;

function TProcurementOfTheComponentsTotal.GetLabelStartDate(NameForm: TForm): TLabel;
begin
  if not Assigned(StartDate) then
    StartDate := TTempLabelTag5.create;
  Result:=StartDate.GetTempLabel(50, 80, 20, '��������� ����:', NameForm);
end;

function TProcurementOfTheComponentsTotal.GetLabelEndDate(NameForm: TForm): TLabel;
begin
  if not Assigned(EndDate) then
    EndDate := TTempLabelTag5.create;
  Result:=EndDate.GetTempLabel(50, 120, 20, '�������� ����:', NameForm);
end;

function TProcurementOfTheComponentsTotal.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  Result:=Title.GetTitleLabel(25, '��������� ����������� ����� (�����)', NameForm);
end;

//Panel

function TProcurementOfTheComponentsTotal.GetPanelGorizontal(
  NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGorizontal) then
    PanelGorizontal := TTempPanelTag5.create;
  Result:=PanelGorizontal.GetTempPanel(50, 210, 1, 670, 0, NameForm);
end;

function TProcurementOfTheComponentsTotal.GetPanelVertical(
  NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertical) then
    PanelVertical := TTempPanelTag5.create;
  Result:=PanelVertical.GetTempPanel(260, 180, 300, 1, 0, NameForm);
end;

end.




