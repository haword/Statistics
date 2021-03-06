unit MIECCancellation;

interface

uses
  WinProcs, SysUtils, StdCtrls, CodeSiteLogging, Buttons, Vcl.Grids, Data.DB,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Variants,
  USCheckFillStringFields,
  USBlockMainMenu,
  MFLabel,
  MFTitleLabel,
  MFEdit,
  MFDateTimePicker,
  MFBitBtnAdd,
  MFBitBtnDelete,
  MFBitBtnEdit,
  MFBitBtnBlock,
  MFStringGrid,
  MFComboBox,
  BIEChangeRecordCancellation,
  BIECDeleteRecordCancellation,
  BIECAddRecordCancellation,
  BIECCancellation,
  USGlobalVariant;

type

  TMIECCancellation = class(TUSGlobalVariant)
  private
    LabelReportDate: TMFLabel;
    LabelTheNameOfTheEnvironment: TMFLabel;
    LabelVolume: TMFLabel;
    LabelNumberOfDoses: TMFLabel;
    LabelNumberOfPackets: TMFLabel;
    Title: TMFTitleLabel;
    SQL: String;

    StringGrid: TMFStringGrid;
    ContentForStringGrid: IBIECCancellation;
    AddRecord: IBIECAddRecordCancellation;
    DeleteRecord: IBIECDeleteRecordCancellation;
    ChangeRecord: IBIEChangeRecordCancellation;

    EditVolume: TMFEdit;
    EditNumberOfDoses: TMFEdit;
    EditNumberOfPackets: TMFEdit;

    ProductList: TMFComboBox;

    ReportDateCal: TMFDateTimePicker;
    CheckFillStrFields: IUSCheckFillStringFields;
    BlockMainMenu: IUSBlockMainMenu;

    ButtonAdd: TMFBitBtnAdd;
    ButtonDelete: TMFBitBtnDelete;
    ButtonEdit: TMFBitBtnEdit;
    ButtonBlock: TMFBitBtnBlock;
    CurrentForm: TForm;
    function GetLabelReportDate(NameForm: TForm): TLabel;
    function GetLabelTheNameOfTheEnvironment(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelNumberOfDoses(NameForm: TForm): TLabel;
    function GetLabelNumberOfPackets(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;

    function GetEditVolume(NameForm: TForm): TEdit;
    function GetEditNumberOfDoses(NameForm: TForm): TEdit;
    function GetEditNumberOfPackets(NameForm: TForm): TEdit;

    function GetProductList(NameForm: TForm): TComboBox;

    function GetCalendarReportDateCal(NameForm: TForm): TDateTimePicker;

    function GetButtonEdit(NameForm: TForm): TBitBtn;
    procedure ButtonEdited(Sender: TObject);
    function GetButtonAdd(NameForm: TForm): TBitBtn;
    procedure ButtonAdded(Sender: TObject);
    function GetButtonDelete(NameForm: TForm): TBitBtn;
    procedure ButtonDeleted(Sender: TObject);
    function GetButtonBlock(NameForm: TForm): TBitBtn;
    procedure ButtonBlocked(Sender: TObject);
    procedure Show;
  public
    constructor create(form: TForm); override;
    destructor destroy; override;
  end;

implementation

{ TBloodProduct }

constructor TMIECCancellation.create(form: TForm);
begin
  CurrentForm := form;

  GetLabelReportDate(form);
  GetLabelTheNameOfTheEnvironment(form);
  GetLabelVolume(form);
  GetLabelNumberOfDoses(form);
  GetLabelNumberOfPackets(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditVolume(form);
  GetEditNumberOfDoses(form);
  GetEditNumberOfPackets(form);

  GetProductList(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
  Show;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.create ���������');
  inherited;
end;

destructor TMIECCancellation.destroy;
begin
  LabelReportDate.destroy;
  LabelTheNameOfTheEnvironment.destroy;
  LabelVolume.destroy;
  LabelNumberOfDoses.destroy;
  LabelNumberOfPackets.destroy;
  Title.destroy;

  StringGrid.destroy;

  EditVolume.destroy;
  EditNumberOfDoses.destroy;
  EditNumberOfPackets.destroy;

  ProductList.destroy;

  ReportDateCal.destroy;

  ButtonAdd.destroy;
  ButtonDelete.destroy;
  ButtonEdit.destroy;
  ButtonBlock.destroy;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.destroy ���������');
  inherited;
end;

// Button

// ���������� ����� ������

procedure TMIECCancellation.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TUSCheckFillStringFields.create;
  EditVolume.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolume.ReadText));
  EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields
    (EditNumberOfDoses.ReadText));
  EditNumberOfPackets.WriteText(CheckFillStrFields.CheckStringFields
    (EditNumberOfPackets.ReadText));
  if (EditVolume.ReadText = '0') or (EditNumberOfDoses.ReadText = '0') or
    (ProductList.GetItemIndex = -1) then
  begin
    Showmessage('��� ���� ������ ���� ���������!');
    exit;
  End;
  if MessageDlg('��������� ������?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(AddRecord) then
      AddRecord := TBIECAddRecordCancellation.create;
    AddRecord.AddRecord(ReportDateCal.GetDate,
      ProductList.GetItemsValue(ProductList.GetItemIndex), EditVolume.ReadText,
      EditNumberOfDoses.ReadText, EditNumberOfPackets.ReadText);
    Showmessage('������ ������� ���������!');
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
  end;
  EditVolume.WriteText('0');
  EditNumberOfDoses.WriteText('0');
  EditNumberOfPackets.WriteText('0');
  ProductList.WriteItemIndex(-1);
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.ButtonAdded ���������');
end;

// ������������� ������

procedure TMIECCancellation.ButtonBlocked(Sender: TObject);
begin
  if ButtonBlock.GetTag=1 then
  begin
    ButtonEdit.ChangeEnabled(True);
    ButtonAdd.ChangeEnabled(True);
    ButtonDelete.ChangeEnabled(True);
    ButtonBlock.ChangeTag(2);
    ButtonBlock.ChangeGlyph;
  end
  else
  begin
    ButtonEdit.ChangeEnabled(False);
    ButtonAdd.ChangeEnabled(False);
    ButtonDelete.ChangeEnabled(False);
    ButtonBlock.ChangeTag(1);
    ButtonBlock.ChangeGlyph;
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.ButtonBlocked ���������');
end;

// ������ ��������

procedure TMIECCancellation.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('������� ������ ����� ' + VarToStr(StringGrid.GetValue(0,
    StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TBIECDeleteRecordCancellation.create;
    DeleteRecord.DeleteRecord(VarToStr(StringGrid.GetValue(0,
      StringGrid.CurrentRow)));
    GetStringGrid(CurrentForm);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount - 1);
    StringGrid.Visible(True);
    Showmessage('������ ������� �������!');
  end;
  EditVolume.WriteText('0');
  EditNumberOfDoses.WriteText('0');
  EditNumberOfPackets.WriteText('0');
  ProductList.WriteItemIndex(-1);
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.ButtonDeleted ���������');
end;

// �������� ���������

procedure TMIECCancellation.ButtonEdited(Sender: TObject);
var
  i: integer;
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TUSCheckFillStringFields.create;
  if not Assigned(BlockMainMenu) then
    BlockMainMenu := TUSBlockMainMenu.create;
  if ButtonEdit.GetTag = 1 then
  begin
    BlockMainMenu.BlockMainMenu(False, CurrentForm);
    ButtonBlock.ChangeEnabled(False);
    ButtonAdd.ChangeEnabled(False);
    ButtonDelete.ChangeEnabled(False);
    StringGrid.Enabled(False);

    ReportDateCal.WriteDateTime(StrToDate(StringGrid.GetValue(1,
      StringGrid.CurrentRow)));
    for i := 0 to ProductList.GetItemsCount - 1 do
      if VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow))
        = ProductList.GetItemsValue(i) then
        ProductList.WriteItemIndex(i);
    if ProductList.GetItemIndex = -1 then
      Showmessage
        ('�������� ���������� ��������� ��� ������ ������ ������ �� �����!' +
        chr(13) + '���������� � ��������������!');
    EditVolume.WriteText(VarToStr(StringGrid.GetValue(3,
      StringGrid.CurrentRow)));
    EditNumberOfDoses.WriteText(VarToStr(StringGrid.GetValue(4,
      StringGrid.CurrentRow)));
    EditNumberOfPackets.WriteText
      (VarToStr(StringGrid.GetValue(5, StringGrid.CurrentRow)));
  end;
  if ButtonEdit.GetTag = 2 then
  begin
    EditVolume.WriteText(CheckFillStrFields.CheckStringFields
      (EditVolume.ReadText));
    EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields
      (EditNumberOfDoses.ReadText));
    EditNumberOfPackets.WriteText(CheckFillStrFields.CheckStringFields
      (EditNumberOfPackets.ReadText));
    if (EditVolume.ReadText = '0') or (EditNumberOfDoses.ReadText = '0') or
      (ProductList.GetItemIndex = -1) then
    begin
      Showmessage('��� ���� ������ ���� ���������!');
      exit;
    End;
    BlockMainMenu.BlockMainMenu(True, CurrentForm);
    ButtonBlock.ChangeEnabled(True);
    ButtonAdd.ChangeEnabled(True);
    ButtonDelete.ChangeEnabled(True);
    StringGrid.Enabled(True);
    if MessageDlg('��������� ���������?', mtConfirmation, [mbYes, mbNo], 0) = 6
    then
    begin
      if not Assigned(ChangeRecord) then
        ChangeRecord := TBIEChangeRecordCancellation.create;
      ChangeRecord.ChangeRecord(ReportDateCal.GetDate,
        ProductList.GetItemsValue(ProductList.GetItemIndex),
        EditVolume.ReadText, EditNumberOfDoses.ReadText,
        EditNumberOfPackets.ReadText, StringGrid.GetValue(0,
        StringGrid.CurrentRow));
      GetStringGrid(CurrentForm);
      StringGrid.Visible(True);
      Showmessage('������ ������� ��������!');
      EditVolume.WriteText('0');
      EditNumberOfDoses.WriteText('0');
      EditNumberOfPackets.WriteText('0');
      ProductList.WriteItemIndex(-1);
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
      ButtonEdit.ChangeTag(1);
      ButtonEdit.ChangeGlyph;
      exit;
    end
    else
    begin
      EditVolume.WriteText('0');
      EditNumberOfDoses.WriteText('0');
      EditNumberOfPackets.WriteText('0');
      ProductList.WriteItemIndex(-1);
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
      ButtonEdit.ChangeTag(1);
      ButtonEdit.ChangeGlyph;
      exit;
    end;
    EditVolume.WriteText('0');
    EditNumberOfDoses.WriteText('0');
    EditNumberOfPackets.WriteText('0');
    ProductList.WriteItemIndex(-1);
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
    ButtonEdit.ChangeTag(1);
    ButtonEdit.ChangeGlyph;
  end;
  if ButtonEdit.GetTag = 1 then
  begin
    ButtonEdit.ChangeTag(2);
    ButtonEdit.ChangeGlyph;
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.ButtonEdited ���������');
end;

// �������� ������

function TMIECCancellation.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TMFBitBtnAdd.create;
  Result := ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetButtonAdd ���������');
end;

function TMIECCancellation.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TMFBitBtnBlock.create;
  Result := ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetButtonBlock ���������');
end;

function TMIECCancellation.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TMFBitBtnDelete.create;
  Result := ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetButtonDelete ���������');
end;

function TMIECCancellation.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TMFBitBtnEdit.create;
  Result := ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetButtonEdit ���������');
end;

// TDateTimePicker

function TMIECCancellation.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(ReportDateCal) then
    ReportDateCal := TMFDateTimePicker.create;
  Result := ReportDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date) - 7,
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetCalendarReportDateCal ���������');
end;

// Edit

function TMIECCancellation.GetEditVolume(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolume) then
    EditVolume := TMFEdit.create;
  Result := EditVolume.GetEdit(400, 160, 185, 12, False, NameForm);
  EditVolume.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetEditVolume ���������');
end;

function TMIECCancellation.GetEditNumberOfDoses(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDoses) then
    EditNumberOfDoses := TMFEdit.create;
  Result := EditNumberOfDoses.GetEdit(400, 200, 185, 12, False, NameForm);
  EditNumberOfDoses.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetEditNumberOfDoses ���������');
end;

function TMIECCancellation.GetEditNumberOfPackets(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfPackets) then
    EditNumberOfPackets := TMFEdit.create;
  Result := EditNumberOfPackets.GetEdit(400, 240, 185, 12, False, NameForm);
  EditNumberOfPackets.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetEditNumberOfPackets ���������');
end;

// Label

function TMIECCancellation.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(25, '�������� �������������� ���� � ����������',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetLabelTitle ���������');
end;

function TMIECCancellation.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReportDate) then
    LabelReportDate := TMFLabel.create;
  Result := LabelReportDate.GetTempLabel(50, 80, 16, '�������� ������: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetLabelReportDate ���������');
end;

function TMIECCancellation.GetLabelTheNameOfTheEnvironment
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelTheNameOfTheEnvironment) then
    LabelTheNameOfTheEnvironment := TMFLabel.create;
  Result := LabelTheNameOfTheEnvironment.GetTempLabel(50, 120, 14,
    '������������ ���������: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetLabelTheNameOfTheEnvironment ���������');
end;

function TMIECCancellation.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TMFLabel.create;
  Result := LabelVolume.GetTempLabel(50, 160, 14, '����� ���������: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetLabelVolume ���������');
end;

function TMIECCancellation.GetLabelNumberOfDoses(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDoses) then
    LabelNumberOfDoses := TMFLabel.create;
  Result := LabelNumberOfDoses.GetTempLabel(50, 200, 14, '���������� ���: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetLabelNumberOfDoses ���������');
end;

function TMIECCancellation.GetLabelNumberOfPackets(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfPackets) then
    LabelNumberOfPackets := TMFLabel.create;
  Result := LabelNumberOfPackets.GetTempLabel(50, 240, 14,
    '���������� ������� �����������������: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetLabelNumberOfPackets ���������');
end;

// ComboBox

function TMIECCancellation.GetProductList(NameForm: TForm): TComboBox;
begin
  if not Assigned(ProductList) then
    ProductList := TMFComboBox.create;
  Result := ProductList.GetComboBox('ProductList', 285, 120, 300, 14, NameForm);
  SQL := 'SELECT NameProducts.ShortName, NameProducts.id ' +
    'FROM NameProducts ' + 'WHERE (NameProducts.ForExped=True);';
  ProductList.TheContentOfTheList(SQL);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetProductList ���������');
end;

// StringGrid

function TMIECCancellation.GetStringGrid(NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  i := 0;
  j := 0;
  Try
    if not Assigned(StringGrid) then
      StringGrid := TMFStringGrid.create;
    Result := StringGrid.GetStringGrid(40, 330, 820, 190, 6, 2, 12, NameForm);
    StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 2, DT_LEFT, 3, DT_RIGHT, 4,
      DT_RIGHT, 5, DT_RIGHT);
    StringGrid.NumberOfFixedCol(0);
    StringGrid.ColWidth(0, 40);
    StringGrid.ColWidth(1, 90);
    StringGrid.ColWidth(2, 250);
    StringGrid.ColWidth(3, 90);
    StringGrid.ColWidth(4, 90);
    StringGrid.ColWidth(5, 90);
    StringGrid.Visible(True);
    StringGrid.WriteCells(0, 0, '���');
    StringGrid.WriteCells(1, 0, '����');
    StringGrid.WriteCells(2, 0, '������������ ���������');
    StringGrid.WriteCells(3, 0, '�����, ��');
    StringGrid.WriteCells(4, 0, '����, ��');
    StringGrid.WriteCells(5, 0, '������, ��');
    if not Assigned(ContentForStringGrid) then
      ContentForStringGrid := TBIECCancellation.create;
    ContentForStringGrid.GetContent;
    if ContentForStringGrid.GetRowCount > 0 then
      for i := 0 to ContentForStringGrid.GetRowCount - 1 do
      begin
        if StringGrid.GetValue(0, 1) <> '' then
          StringGrid.AddRowCount;
        StringGrid.WriteCells(0, i + 1, ContentForStringGrid.GetKod(j));
        StringGrid.WriteCells(1, i + 1, ContentForStringGrid.GetReportDate(j));
        StringGrid.WriteCells(2, i + 1,
          ContentForStringGrid.GetTheNameOfTheEnvironment(j));
        StringGrid.WriteCells(3, i + 1, ContentForStringGrid.GetVolume(j));
        StringGrid.WriteCells(4, i + 1,
          ContentForStringGrid.GetNumberOfDoses(j));
        StringGrid.WriteCells(5, i + 1,
          ContentForStringGrid.GetNumberOfPackets(j));
        j := j + 1;
      end;
  Except
    Showmessage('������ ��� ������������ �������!');
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.GetStringGrid ���������');
end;

procedure TMIECCancellation.Show;
begin
  LabelReportDate.Visible(True);
  LabelTheNameOfTheEnvironment.Visible(True);
  LabelVolume.Visible(True);
  LabelNumberOfDoses.Visible(True);
  LabelNumberOfPackets.Visible(True);

  StringGrid.Visible(True);

  ReportDateCal.Visible(True);

  EditVolume.Visible(True);
  EditNumberOfDoses.Visible(True);
  EditNumberOfPackets.Visible(True);

  ProductList.Visible(True);

  ButtonEdit.Visible(True);
  ButtonAdd.Visible(True);
  ButtonDelete.Visible(True);
  ButtonBlock.Visible(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation.Show ���������');
end;
end.
