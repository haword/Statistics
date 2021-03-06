unit VRDDailyReportTheKray;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  frxClass, frxDBSet, frxPreview, frxExportPDF, System.Win.Registry,
  MRDDailyReportToTheKray,
  UVFMainMenu,
  UMSGlobalVariant;

type
  TVRDDailyReportTheKray = class(TGlobalVariant)
  private
    TempForm: TForm;
    frxTempReport: TfrxReport;
    frxTempPreview: TfrxPreview;
    frxTepmExportPDF:TfrxPDFExport;
    DailyReportTheKray: IMRDDailyReportToTheKray;
    MainMenu: TUVFMainMenu;
    procedure GetReport(CurrentForm: TForm);
    procedure GetMainMenu;
    procedure OnClickMenuClose(Sender: TObject);
    procedure OnClickPrintReport(Sender: TObject);
    procedure OnClickExportPDF(Sender: TObject);
    function GetDesktopFolderPath: string;
    procedure PreviewMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    { Private declarations }
  public
    constructor Create(form: TForm);  override;
    destructor destroy;   override;
    { Public declarations }
  end;

implementation

{ TVRDDailyReportTheKrayVer2 }

constructor TVRDDailyReportTheKray.Create(form: TForm);
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

destructor TVRDDailyReportTheKray.destroy;
begin
  FreeAndNil(frxTempPreview);
  FreeAndNil(frxTempReport);
  MainMenu.destroy;
  inherited;
end;

procedure TVRDDailyReportTheKray.GetMainMenu;
begin
  if not Assigned(MainMenu) then
    MainMenu := TUVFMainMenu.create;
  MainMenu.GetTempMainMenu(TempForm);
  MainMenu.OnClickCloseForm(OnClickMenuClose);
  MainMenu.OnClickPrintReport(OnClickPrintReport);
  MainMenu.OnClickExportPDF(OnClickExportPDF);
end;

procedure TVRDDailyReportTheKray.GetReport(CurrentForm: TForm);
var
  CurrentDir: string;
begin
  CurrentDir:=ExtractFileDir(ExtractFileDir(ParamStr(0)));
  if not Assigned(DailyReportTheKray) then
    DailyReportTheKray := TMRDDailyReportToTheKray.create;

  if not Assigned(frxTempPreview) then
    frxTempPreview:=TfrxPreview.Create(CurrentForm);
  frxTempPreview.Parent:=CurrentForm;
  frxTempPreview.Align:=alClient;

  if not Assigned(frxTempReport) then
    frxTempReport:=TfrxReport.Create(CurrentForm);
  frxTempReport.Clear;
  frxTempReport.Preview:=frxTempPreview;

  frxTempReport.LoadFromFile(CurrentDir + '\Model\Reports\DailyReportToTheKray\DailyReportToTheKray.fr3');

  frxTempReport.Variables.Variables['VolumeWholeBlood']:='''' + DailyReportTheKray.GetVolumeWholeBlood + '''';
  frxTempReport.Variables.Variables['PercentWholeBlood']:='''' + DailyReportTheKray.GetPercentWholeBlood + '''';
  frxTempReport.Variables.Variables['VolumeConsBlood']:='''' + DailyReportTheKray.GetVolumeConsBlood + '''';
  frxTempReport.Variables.Variables['PercentConsBlood']:='''' + DailyReportTheKray.GetPercentConsBlood + '''';
  frxTempReport.Variables.Variables['VolumePlasmaTotal']:='''' + DailyReportTheKray.GetVolumePlasmaTotal + '''';
  frxTempReport.Variables.Variables['PercentPlasmaTotal']:='''' + DailyReportTheKray.GetPercentPlasmaTotal + '''';
  frxTempReport.Variables.Variables['VolumePlasmaAPA']:='''' + DailyReportTheKray.GetVolumePlasmaAPA + '''';
  frxTempReport.Variables.Variables['PercentPlasmaAPA']:='''' + DailyReportTheKray.GetPercentPlasmaAPA + '''';
  frxTempReport.Variables.Variables['VolumeErSusp']:='''' + DailyReportTheKray.GetVolumeErSusp + '''';
  frxTempReport.Variables.Variables['PercentErSusp']:='''' + DailyReportTheKray.GetPercentErSusp + '''';
  frxTempReport.Variables.Variables['VolumeTrombo']:='''' + DailyReportTheKray.GetVolumeTrombo + '''';
  frxTempReport.Variables.Variables['NumberDosesTromb']:='''' + DailyReportTheKray.GetNumberDosesTromb + '''';
  frxTempReport.Variables.Variables['NumberPacketsTromb']:='''' + DailyReportTheKray.GetNumberPacketsTromb + '''';
end;

procedure TVRDDailyReportTheKray.OnClickExportPDF(Sender: TObject);
begin
  if not Assigned(frxTepmExportPDF) then
    frxTepmExportPDF:=TfrxPDFExport.Create(TempForm);
  frxTepmExportPDF.FileName:='���������� ����� �� ����� �� ' + DateToStr(date()) + '. ������������� ������.pdf';
  frxTepmExportPDF.DefaultPath:=GetDesktopFolderPath + '\';
  frxTempReport.Export(frxTepmExportPDF);
  frxTempReport.ShowReport;
end;

procedure TVRDDailyReportTheKray.OnClickMenuClose(Sender: TObject);
begin
  TempForm.ModalResult:=mrOk;
end;

procedure TVRDDailyReportTheKray.OnClickPrintReport(Sender: TObject);
begin
  frxTempReport.Print;
end;

function TVRDDailyReportTheKray.GetDesktopFolderPath: string;
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

procedure TVRDDailyReportTheKray.PreviewMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  frxTempPreview.MouseWheelScroll(WheelDelta);
end;

end.
