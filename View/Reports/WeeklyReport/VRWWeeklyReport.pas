unit VRWWeeklyReport;

interface
uses
  Winapi.Windows, System.SysUtils, Vcl.Controls, Vcl.Forms, Vcl.Menus, System.Classes,
  frxClass, frxDBSet, frxPreview, frxExportPDF, System.Win.Registry, dialogs, variants,
  MRWTableForDefect,
  MRWWeeklyReportProduction,
  MRWResultsOfTheProducts,
  MRWDonorsAndProcedures,
  MRWDonorsAndProceduresOuting,
  MRWSecondTable,
  UVFMainMenu,
  UMSGlobalVariant;

type
  TVRWWeeklyReport = class(TGlobalVariant)
  private
    TempForm: TForm;
    frxTempReport: TfrxReport;
    frxTempPreview: TfrxPreview;
    frxTempExportPDF:TfrxPDFExport;
    frxDefect: TfrxUserDataSet;

    frxTempMasterData: TfrxMasterData;
    frxTempPage: TfrxReportPage;
    frxTempMemo: TfrxMemoView;

    TableForDefect: IMRWTableForDefect;
    RecNumber: integer;
    ar: array[0..10, 0..1] of string;
    WeeklyReportProduction: IMRWWeeklyReportProduction;
    TestResultsOfTheProducts: IMRWResultsOfTheProducts;
    DonorsAndProcedures: IMRWDonorsAndProcedures;
    DonorsAndProceduresOuting: IMRWDonorsAndProceduresOuting;
    SecondTable: IMRWSecondTable;


    MainMenu: TUVFMainMenu;
    procedure GetReport(CurrentForm: TForm);
    procedure GetMainMenu;
    procedure OnClickMenuClose(Sender: TObject);
    procedure OnClickPrintReport(Sender: TObject);
    procedure OnClickExportPDF(Sender: TObject);
    procedure frxDefectGetValue(const VarName: String; var Value: Variant);
    procedure PreviewMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    function GetDesktopFolderPath: string;
    { Private declarations }
  public
    constructor Create(form: TForm);  override;
    destructor destroy;   override;
    { Public declarations }
  end;

implementation

{ TVRDDailyReportTheKrayVer2 }

constructor TVRWWeeklyReport.Create(form: TForm);
begin
  TempForm:=form;
  GetMainMenu;
  with TempForm do
  begin
    BorderStyle:=bsSingle;
    Position:=poScreenCenter;
    BorderIcons:=BorderIcons-[biSystemMenu];
    Width := 860;
    Height:=750;
    OnMouseWheel:=PreviewMouseWheel;
  end;
  GetReport(TempForm);
  frxTempReport.ShowReport;
  TempForm.ShowModal;
  inherited;
end;

destructor TVRWWeeklyReport.destroy;
begin
  FreeAndNil(frxTempPreview);
  FreeAndNil(frxTempReport);
  MainMenu.destroy;
  inherited;
end;

procedure TVRWWeeklyReport.GetMainMenu;
begin
  if not Assigned(MainMenu) then
    MainMenu := TUVFMainMenu.create;
  MainMenu.GetTempMainMenu(TempForm);
  MainMenu.OnClickCloseForm(OnClickMenuClose);
  MainMenu.OnClickPrintReport(OnClickPrintReport);
  MainMenu.OnClickExportPDF(OnClickExportPDF);
end;

procedure TVRWWeeklyReport.GetReport(CurrentForm: TForm);
var
  CurrentDir: string;
  i: integer;
begin
  if not Assigned(frxTempPreview) then
    frxTempPreview:=TfrxPreview.Create(CurrentForm);
  frxTempPreview.Parent:=CurrentForm;
  frxTempPreview.Align:=alClient;
  if not Assigned(frxTempReport) then
    frxTempReport:=TfrxReport.Create(CurrentForm);
  frxTempReport.Clear;
  frxTempReport.Preview:=frxTempPreview;
  CurrentDir:=ExtractFileDir(ExtractFileDir(ParamStr(0)));
  frxTempReport.LoadFromFile(CurrentDir + '\Model\Reports\WeeklyReport\WeeklyReport.fr3');
  if not Assigned(frxDefect) then
    frxDefect := TfrxUserDataSet.create(CurrentForm);
  frxTempMasterData:=frxTempReport.FindObject('MasterData1') as TfrxMasterData;
  frxTempMasterData.DataSet:=frxDefect;
  frxTempReport.OnGetValue:=frxDefectGetValue;
  if not Assigned(TableForDefect) then
    TableForDefect := TMRWTableForDefect.create;
  TableForDefect.GetContent;
  for i:=0 to TableForDefect.GetRowCount-1 do
  begin
    ar[i,0]:=TableForDefect.GetTypeOfDefect(i)+TableForDefect.GetTypeOfProduct(i);
    ar[i,1]:=TableForDefect.GetVolume(i);
  end;
  frxDefect.RangeEnd:=ReCount;
  frxDefect.RangeEndCount:=TableForDefect.GetRowCount;
  if not Assigned(WeeklyReportProduction) then
    WeeklyReportProduction := TMRWWeeklyReportProduction.create;
  if not Assigned(SecondTable) then
    SecondTable := TMRWSecondTable.create;
// ��������� ����/����
  frxTempReport.Variables.Variables['PlanVolumeWholeBlood']:='''' + WeeklyReportProduction.GetValuePlan(0) + '''';
  frxTempReport.Variables.Variables['VolumeWholeBlood']:='''' + WeeklyReportProduction.GetValueLitr(5) + '''';
  frxTempReport.Variables.Variables['PercentWholeBlood']:='''' + WeeklyReportProduction.GetValuePercent(10) + '''';
  frxTempReport.Variables.Variables['PlanVolumeConsBlood']:='''' + WeeklyReportProduction.GetValuePlan(1) + '''';
  frxTempReport.Variables.Variables['VolumeConsBlood']:='''' + WeeklyReportProduction.GetValueLitr(6) + '''';
  frxTempReport.Variables.Variables['PercentConsBlood']:='''' + WeeklyReportProduction.GetValuePercent(11) + '''';
  frxTempReport.Variables.Variables['PlanVolumePlasmaTotal']:='''' + WeeklyReportProduction.GetValuePlan(2) + '''';
  frxTempReport.Variables.Variables['VolumePlasmaTotal']:='''' + WeeklyReportProduction.GetValueLitr(7) + '''';
  frxTempReport.Variables.Variables['PercentPlasmaTotal']:='''' + WeeklyReportProduction.GetValuePercent(12) + '''';
  frxTempReport.Variables.Variables['PlanVolumePlasmaAPA']:='''' + WeeklyReportProduction.GetValuePlan(3) + '''';
  frxTempReport.Variables.Variables['VolumePlasmaAPA']:='''' + WeeklyReportProduction.GetValueLitr(8) + '''';
  frxTempReport.Variables.Variables['PercentPlasmaAPA']:='''' + WeeklyReportProduction.GetValuePercent(13) + '''';
  frxTempReport.Variables.Variables['PlanVolumeErSusp']:='''' + WeeklyReportProduction.GetValuePlan(4) + '''';
  frxTempReport.Variables.Variables['VolumeErSusp']:='''' + WeeklyReportProduction.GetValueLitr(9) + '''';
  frxTempReport.Variables.Variables['PercentErSusp']:='''' + WeeklyReportProduction.GetValuePercent(14) + '''';
  frxTempReport.Variables.Variables['VolumeTrombo']:='''' + WeeklyReportProduction.GetValueLitr(15) + '''';
  frxTempReport.Variables.Variables['NumberDosesTromb']:='''' + WeeklyReportProduction.GetValueTromboPacketsDoses(16) + '''';
  frxTempReport.Variables.Variables['NumberPacketsTromb']:='''' + WeeklyReportProduction.GetValueTromboPacketsDoses(17) + '''';
//����������� ������
  frxTempReport.Variables.Variables['ProductWholeBlood']:='''' + SecondTable.GetProductWholeBlood + '''';
  frxTempReport.Variables.Variables['VolumeReinfusion']:='''' + SecondTable.GetVolumeReinfusion + '''';
  frxTempReport.Variables.Variables['PreparedFitProductionErSuspFiltr']:='''' + SecondTable.GetPreparedFitProductionErSuspFiltr + '''';
  frxTempReport.Variables.Variables['PreparedFitProductionErSusp']:='''' + SecondTable.GetPreparedFitProductionErSusp + '''';
  frxTempReport.Variables.Variables['PreparedFitProductionSZP']:='''' + SecondTable.GetPreparedFitProductionSZP + '''';
  frxTempReport.Variables.Variables['OutingProductWholeBlood']:='''' + SecondTable.GetOutingProductWholeBlood + '''';
  frxTempReport.Variables.Variables['OutingPreparedFitProductionErSuspFiltr']:='''' + SecondTable.GetOutingPreparedFitProductionErSuspFiltr + '''';
  frxTempReport.Variables.Variables['OutingPreparedFitProductionErSusp']:='''' + SecondTable.GetOutingPreparedFitProductionErSusp + '''';
  frxTempReport.Variables.Variables['OutingPreparedFitProductionSZP']:='''' + SecondTable.GetOutingPreparedFitProductionSZP + '''';
//������ � ���
  if not Assigned(TestResultsOfTheProducts) then
    TestResultsOfTheProducts := TMRWResultsOfTheProducts.create;
  frxTempReport.Variables.Variables['ErSuspWithResuspRastFiltrVolumeCity']:='''' + TestResultsOfTheProducts.GetValueLitr(0) + '''';
  frxTempReport.Variables.Variables['ErSuspWithResuspRastFiltrDosesCity']:='''' + TestResultsOfTheProducts.GetValueDoses(1) + '''';
  frxTempReport.Variables.Variables['ErSuspWithResuspRastFiltrVolumeArea']:='''' + TestResultsOfTheProducts.GetValueLitr(2) + '''';
  frxTempReport.Variables.Variables['ErSuspWithResuspRastFiltrDosesArea']:='''' + TestResultsOfTheProducts.GetValueDoses(3) + '''';
  frxTempReport.Variables.Variables['ErSuspWithResuspRastFiltrPercentCity']:='''' + TestResultsOfTheProducts.GetValuePercent(4) + '''';
  frxTempReport.Variables.Variables['ErSuspWithResuspRastFiltrPercentArea']:='''' + TestResultsOfTheProducts.GetValuePercent(5) + '''';
  frxTempReport.Variables.Variables['ErSuspWithResuspRastVolumeCity']:='''' + TestResultsOfTheProducts.GetValueLitr(6) + '''';
  frxTempReport.Variables.Variables['ErSuspWithResuspRastDosesCity']:='''' + TestResultsOfTheProducts.GetValueDoses(7) + '''';
  frxTempReport.Variables.Variables['ErSuspWithResuspRastVolumeArea']:='''' + TestResultsOfTheProducts.GetValueLitr(8) + '''';
  frxTempReport.Variables.Variables['ErSuspWithResuspRastDosesArea']:='''' + TestResultsOfTheProducts.GetValueDoses(9) + '''';
  frxTempReport.Variables.Variables['ErSuspWithResuspRastPercentCity']:='''' + TestResultsOfTheProducts.GetValuePercent(10) + '''';
  frxTempReport.Variables.Variables['ErSuspWithResuspRastPercentArea']:='''' + TestResultsOfTheProducts.GetValuePercent(11) + '''';
  frxTempReport.Variables.Variables['ErSuspWithFisioRastVolumeCity']:='''' + TestResultsOfTheProducts.GetValueLitr(12) + '''';
  frxTempReport.Variables.Variables['ErSuspWithFisioRastDosesCity']:='''' + TestResultsOfTheProducts.GetValueDoses(13) + '''';
  frxTempReport.Variables.Variables['ErSuspWithFisioRastVolumeArea']:='''' + TestResultsOfTheProducts.GetValueLitr(14) + '''';
  frxTempReport.Variables.Variables['ErSuspWithFisioRastDosesArea']:='''' + TestResultsOfTheProducts.GetValueDoses(15) + '''';
  frxTempReport.Variables.Variables['ErSuspWithFisioRastPercentCity']:='''' + TestResultsOfTheProducts.GetValuePercent(16) + '''';
  frxTempReport.Variables.Variables['ErSuspWithFisioRastPercentArea']:='''' + TestResultsOfTheProducts.GetValuePercent(17) + '''';
  frxTempReport.Variables.Variables['SZPKarantVolumeCity']:='''' + TestResultsOfTheProducts.GetValueLitr(18) + '''';
  frxTempReport.Variables.Variables['SZPKarantDosesCity']:='''' + TestResultsOfTheProducts.GetValueDoses(19) + '''';
  frxTempReport.Variables.Variables['SZPKarantVolumeArea']:='''' + TestResultsOfTheProducts.GetValueLitr(20) + '''';
  frxTempReport.Variables.Variables['SZPKarantDosesArea']:='''' + TestResultsOfTheProducts.GetValueDoses(21) + '''';
  frxTempReport.Variables.Variables['SZPKarantPercentCity']:='''' + TestResultsOfTheProducts.GetValuePercent(22) + '''';
  frxTempReport.Variables.Variables['SZPKarantPercentArea']:='''' + TestResultsOfTheProducts.GetValuePercent(23) + '''';
  frxTempReport.Variables.Variables['SZPVirusInaktVolumeCity']:='''' + TestResultsOfTheProducts.GetValueLitr(24) + '''';
  frxTempReport.Variables.Variables['SZPVirusInaktDosesCity']:='''' + TestResultsOfTheProducts.GetValueDoses(25) + '''';
  frxTempReport.Variables.Variables['SZPVirusInaktVolumeArea']:='''' + TestResultsOfTheProducts.GetValueLitr(26) + '''';
  frxTempReport.Variables.Variables['SZPVirusInaktDosesArea']:='''' + TestResultsOfTheProducts.GetValueDoses(27) + '''';
  frxTempReport.Variables.Variables['SZPVirusInaktPercentCity']:='''' + TestResultsOfTheProducts.GetValuePercent(28) + '''';
  frxTempReport.Variables.Variables['SZPVirusInaktPercentArea']:='''' + TestResultsOfTheProducts.GetValuePercent(29) + '''';
  frxTempReport.Variables.Variables['KriopresipitatVolumeCity']:='''' + TestResultsOfTheProducts.GetValueLitr(30) + '''';
  frxTempReport.Variables.Variables['KriopresipitatDosesCity']:='''' + TestResultsOfTheProducts.GetValueDoses(31) + '''';
  frxTempReport.Variables.Variables['KriopresipitatVolumeArea']:='''' + TestResultsOfTheProducts.GetValueLitr(32) + '''';
  frxTempReport.Variables.Variables['KriopresipitatDosesArea']:='''' + TestResultsOfTheProducts.GetValueDoses(33) + '''';
  frxTempReport.Variables.Variables['KriopresipitatPercentCity']:='''' + TestResultsOfTheProducts.GetValuePercent(34) + '''';
  frxTempReport.Variables.Variables['KriopresipitatPercentArea']:='''' + TestResultsOfTheProducts.GetValuePercent(35) + '''';
  frxTempReport.Variables.Variables['TromboVolumeCity']:='''' + TestResultsOfTheProducts.GetValueLitr(36) + '''';
  frxTempReport.Variables.Variables['TromboDosesCity']:='''' + TestResultsOfTheProducts.GetValueDoses(37) + '''';
  frxTempReport.Variables.Variables['TromboVolumeArea']:='''' + TestResultsOfTheProducts.GetValueLitr(38) + '''';
  frxTempReport.Variables.Variables['TromboDosesArea']:='''' + TestResultsOfTheProducts.GetValueDoses(39) + '''';
  frxTempReport.Variables.Variables['TromboPercentCity']:='''' + TestResultsOfTheProducts.GetValuePercent(40) + '''';
  frxTempReport.Variables.Variables['TromboPercentArea']:='''' + TestResultsOfTheProducts.GetValuePercent(41) + '''';
  frxTempReport.Variables.Variables['PerftoranVolumeCity']:='''' + TestResultsOfTheProducts.GetValueLitr(42) + '''';
  frxTempReport.Variables.Variables['PerftoranDosesCity']:='''' + TestResultsOfTheProducts.GetValueDoses(43) + '''';
  frxTempReport.Variables.Variables['PerftoranVolumeArea']:='''' + TestResultsOfTheProducts.GetValueLitr(44) + '''';
  frxTempReport.Variables.Variables['PerftoranDosesArea']:='''' + TestResultsOfTheProducts.GetValueDoses(45) + '''';
  frxTempReport.Variables.Variables['PerftoranPercentCity']:='''' + TestResultsOfTheProducts.GetValuePercent(46) + '''';
  frxTempReport.Variables.Variables['PerftoranPercentArea']:='''' + TestResultsOfTheProducts.GetValuePercent(47) + '''';
  if not Assigned(DonorsAndProcedures) then
    DonorsAndProcedures := TMRWDonorsAndProcedures.create;
  frxTempReport.Variables.Variables['AddressedJust']:='''' + DonorsAndProcedures.GetValue(0) + '''';
  frxTempReport.Variables.Variables['ExceptionTotal']:='''' + DonorsAndProcedures.GetValue(1) + '''';
  frxTempReport.Variables.Variables['PreliminaryAnalysis']:='''' + DonorsAndProcedures.GetValue(2) + '''';
  frxTempReport.Variables.Variables['AdmittedToDonation']:='''' + DonorsAndProcedures.GetValue(3) + '''';
  frxTempReport.Variables.Variables['ProceduresTotal']:='''' + DonorsAndProcedures.GetValue(4) + '''';
  frxTempReport.Variables.Variables['BloodProcedures']:='''' + DonorsAndProcedures.GetValue(5) + '''';
  frxTempReport.Variables.Variables['PlasmaProceduresTotal']:='''' + DonorsAndProcedures.GetValue(6) + '''';
  frxTempReport.Variables.Variables['APAProcedures']:='''' + DonorsAndProcedures.GetValue(7) + '''';
  frxTempReport.Variables.Variables['TromboProcedures']:='''' + DonorsAndProcedures.GetValue(8) + '''';
  frxTempReport.Variables.Variables['NotTaken']:='''' + DonorsAndProcedures.GetValue(9) + '''';
  if not Assigned(DonorsAndProceduresOuting) then
    DonorsAndProceduresOuting := TMRWDonorsAndProceduresOuting.create;
  frxTempReport.Variables.Variables['AddressedJustOuting']:='''' + DonorsAndProceduresOuting.GetValue(0) + '''';
  frxTempReport.Variables.Variables['ExceptionTotalOuting']:='''' + DonorsAndProceduresOuting.GetValue(1) + '''';
  frxTempReport.Variables.Variables['PreliminaryAnalysisOuting']:='''' + DonorsAndProceduresOuting.GetValue(2) + '''';
  frxTempReport.Variables.Variables['AdmittedToDonationOuting']:='''' + DonorsAndProceduresOuting.GetValue(3) + '''';
  frxTempReport.Variables.Variables['ProceduresTotalOuting']:='''' + DonorsAndProceduresOuting.GetValue(4) + '''';
  frxTempReport.Variables.Variables['BloodProceduresOuting']:='''' + DonorsAndProceduresOuting.GetValue(5) + '''';
  frxTempReport.Variables.Variables['NotTakenOuting']:='''' + DonorsAndProceduresOuting.GetValue(6) + '''';
end;

procedure TVRWWeeklyReport.frxDefectGetValue(const VarName: String; var Value: Variant);
begin
    if CompareText(VarName, 'Name') = 0 then
      Value := ar[frxDefect.RecNo, 0];
    if CompareText(VarName, 'Volume') = 0 then
      Value := ar[frxDefect.RecNo, 1];
end;

procedure TVRWWeeklyReport.OnClickExportPDF(Sender: TObject);
begin
  if not Assigned(frxTempExportPDF) then
    frxTempExportPDF:=TfrxPDFExport.Create(TempForm);
  frxTempExportPDF.FileName:='��������� �����. ����������� ' + DateToStr(date()) + '. ������������� ������.';
  frxTempExportPDF.DefaultPath:=GetDesktopFolderPath + '\';
  frxTempReport.Export(frxTempExportPDF);
  frxTempReport.ShowReport;
end;

procedure TVRWWeeklyReport.OnClickMenuClose(Sender: TObject);
begin
  TempForm.ModalResult:=mrOk;
end;

procedure TVRWWeeklyReport.OnClickPrintReport(Sender: TObject);
begin
  frxTempReport.Print;
end;

procedure TVRWWeeklyReport.PreviewMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  frxTempPreview.MouseWheelScroll(WheelDelta);
end;

function TVRWWeeklyReport.GetDesktopFolderPath: string;
var
  R: TRegistry;
begin
  R:=TRegistry.Create;
  R.RootKey:=HKEY_CURRENT_USER;
  R.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders',False);
  Result:=R.ReadString('Desktop');
  R.CloseKey;
  R.Free;
end;
end.



{var
    Start: Integer;
Start:=GetTickCount;
...
Start:=GetTickCount-Start;}
