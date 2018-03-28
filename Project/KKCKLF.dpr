program KKCKLF;

uses
  Forms,
  BloobStatLF in '..\View\BloobStatLF.pas' {MyMainForm},
  GetAdoConnect in '..\BaseAdapters\Connect\GetAdoConnect.pas',
  MQNNumberOfDonations in '..\Model\Queries\NumberOfDonations\MQNNumberOfDonations.pas',
  BQNTheNumberOfBloodDonations in '..\BaseAdapters\Queries\NumberOfDonations\BQNTheNumberOfBloodDonations.pas',
  BQNTheNumberOfPlasmaDonations in '..\BaseAdapters\Queries\NumberOfDonations\BQNTheNumberOfPlasmaDonations.pas',
  BQNTheNumberOfTromboDonations in '..\BaseAdapters\Queries\NumberOfDonations\BQNTheNumberOfTromboDonations.pas',
  BQBTheAmountOfBloodOnPreserving in '..\BaseAdapters\Queries\BloodProduct\BQBTheAmountOfBloodOnPreserving.pas',
  MQBBloodProduct in '..\Model\Queries\BloodProduct\MQBBloodProduct.pas',
  BQBTheNumberOfWholeBlood in '..\BaseAdapters\Queries\BloodProduct\BQBTheNumberOfWholeBlood.pas',
  MFLabel in '..\Model\FormObjects\MFLabel.pas',
  MFTitleLabel in '..\Model\FormObjects\MFTitleLabel.pas',
  MFEdit in '..\Model\FormObjects\MFEdit.pas',
  MFDateTimePicker in '..\Model\FormObjects\MFDateTimePicker.pas',
  MFBitBtn in '..\Model\FormObjects\MFBitBtn.pas',
  BQBTheNumberOfConservedBlood in '..\BaseAdapters\Queries\BloodProduct\BQBTheNumberOfConservedBlood.pas',
  BQBTheAmountOfReinfusionWithAPA in '..\BaseAdapters\Queries\BloodProduct\BQBTheAmountOfReinfusionWithAPA.pas',
  BQBTheAmountOfReinfusionWithTrombo in '..\BaseAdapters\Queries\BloodProduct\BQBTheAmountOfReinfusionWithTrombo.pas',
  BQPHarvestingOfErSuspensionsValumeTotal in '..\BaseAdapters\Queries\ProcurementOfTheComponentsTotal\BQPHarvestingOfErSuspensionsValumeTotal.pas',
  MQPProcurementOfTheComponentsTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPProcurementOfTheComponentsTotal.pas',
  MFPanel in '..\Model\FormObjects\MFPanel.pas',
  BQPHarvestingOfErSuspensionsDosesTotal in '..\BaseAdapters\Queries\ProcurementOfTheComponentsTotal\BQPHarvestingOfErSuspensionsDosesTotal.pas',
  BQPHarvestingOfPlasmaVolumeTotal in '..\BaseAdapters\Queries\ProcurementOfTheComponentsTotal\BQPHarvestingOfPlasmaVolumeTotal.pas',
  BQPHarvestingOfPlasmaDosesTotal in '..\BaseAdapters\Queries\ProcurementOfTheComponentsTotal\BQPHarvestingOfPlasmaDosesTotal.pas',
  BQPHarvestingOfPlasmaBloodVolumeTotal in '..\BaseAdapters\Queries\ProcurementOfTheComponentsTotal\BQPHarvestingOfPlasmaBloodVolumeTotal.pas',
  BQPHarvestingOfPlasmaBloodDosesTotal in '..\BaseAdapters\Queries\ProcurementOfTheComponentsTotal\BQPHarvestingOfPlasmaBloodDosesTotal.pas',
  BQPHarvestingOfPlasmaAPAVolumeTotal in '..\BaseAdapters\Queries\ProcurementOfTheComponentsTotal\BQPHarvestingOfPlasmaAPAVolumeTotal.pas',
  BQPHarvestingOfPlasmaAPADosesTotal in '..\BaseAdapters\Queries\ProcurementOfTheComponentsTotal\BQPHarvestingOfPlasmaAPADosesTotal.pas',
  BQPHarvestingOfTromboVolumeTotal in '..\BaseAdapters\Queries\ProcurementOfTheComponentsTotal\BQPHarvestingOfTromboVolumeTotal.pas',
  BQPHarvestingOfTromboDosesTotal in '..\BaseAdapters\Queries\ProcurementOfTheComponentsTotal\BQPHarvestingOfTromboDosesTotal.pas',
  BQPHarvestingOfTromboPacetsTotal in '..\BaseAdapters\Queries\ProcurementOfTheComponentsTotal\BQPHarvestingOfTromboPacetsTotal.pas',
  BQPHarvestingOfFiltratVolumeTotal in '..\BaseAdapters\Queries\ProcurementOfTheComponentsTotal\BQPHarvestingOfFiltratVolumeTotal.pas',
  BQPHarvestingOfFiltratDosesTotal in '..\BaseAdapters\Queries\ProcurementOfTheComponentsTotal\BQPHarvestingOfFiltratDosesTotal.pas',
  MQHHarvestingOfBloodComponentsByTypes in '..\Model\Queries\HarvestingOfBloodComponentsByTypes\MQHHarvestingOfBloodComponentsByTypes.pas',
  MFStringGrid in '..\Model\FormObjects\MFStringGrid.pas',
  BQHBloodComponents in '..\BaseAdapters\Queries\HarvestingOfBloodComponentsByTypes\BQHBloodComponents.pas',
  BQHBloodComponentsPlasma in '..\BaseAdapters\Queries\HarvestingOfBloodComponentsByTypes\BQHBloodComponentsPlasma.pas',
  BQHPlasmaAPA in '..\BaseAdapters\Queries\HarvestingOfBloodComponentsByTypes\BQHPlasmaAPA.pas',
  BQHTrombo in '..\BaseAdapters\Queries\HarvestingOfBloodComponentsByTypes\BQHTrombo.pas',
  MFComboBox in '..\Model\FormObjects\MFComboBox.pas',
  MFBitBtnSave in '..\Model\FormObjects\MFBitBtnSave.pas',
  MFBitBtnDelete in '..\Model\FormObjects\MFBitBtnDelete.pas',
  MFBitBtnBlock in '..\Model\FormObjects\MFBitBtnBlock.pas',
  MFBitBtnAdd in '..\Model\FormObjects\MFBitBtnAdd.pas',
  MFBitBtnEdit in '..\Model\FormObjects\MFBitBtnEdit.pas',
  MIOATheAmountOfUsableErSusp in '..\Model\InformationForWeeklyReport\Other\AmountOfUsableErSusp\MIOATheAmountOfUsableErSusp.pas',
  BIOATheAmountOfUsableErSusp in '..\BaseAdapters\InformationForWeeklyReport\Other\AmountOfUsableErSusp\BIOATheAmountOfUsableErSusp.pas',
  BIOAAdviceToDoctors in '..\BaseAdapters\InformationForWeeklyReport\Other\AdviceToDoctors\BIOAAdviceToDoctors.pas',
  MIOAAdviceToDoctors in '..\Model\InformationForWeeklyReport\Other\AdviceToDoctors\MIOAAdviceToDoctors.pas',
  BIOCCheckLPU in '..\BaseAdapters\InformationForWeeklyReport\Other\CheckLPU\BIOCCheckLPU.pas',
  MIOCCheckLPU in '..\Model\InformationForWeeklyReport\Other\CheckLPU\MIOCCheckLPU.pas',
  MIETTheResultsInLPU in '..\Model\InformationForWeeklyReport\Expedition\TheResultsInLPU\MIETTheResultsInLPU.pas',
  BIETTheResultsInLPU in '..\BaseAdapters\InformationForWeeklyReport\Expedition\TheResultsInLPU\BIETTheResultsInLPU.pas',
  MIETTheResultsInKray in '..\Model\InformationForWeeklyReport\Expedition\TheResultsInKray\MIETTheResultsInKray.pas',
  BIETTheResultsInKray in '..\BaseAdapters\InformationForWeeklyReport\Expedition\TheResultsInKray\BIETTheResultsInKray.pas',
  BIECCancellation in '..\BaseAdapters\InformationForWeeklyReport\Expedition\Cancellation\BIECCancellation.pas',
  MIECCancellation in '..\Model\InformationForWeeklyReport\Expedition\Cancellation\MIECCancellation.pas',
  BIOCConsumptionOfErythrocyteEnvironments in '..\BaseAdapters\InformationForWeeklyReport\OZK\ConsumptionOfErythrocyteEnvironments\BIOCConsumptionOfErythrocyteEnvironments.pas',
  MIOCConsumptionOfErythrocyteEnvironments in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfErythrocyteEnvironments\MIOCConsumptionOfErythrocyteEnvironments.pas',
  BIOCConsumptionOfPlazma in '..\BaseAdapters\InformationForWeeklyReport\OZK\ConsumptionOfPlazma\BIOCConsumptionOfPlazma.pas',
  MIOCConsumptionOfPlazma in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfPlazma\MIOCConsumptionOfPlazma.pas',
  BIOCConsumptionOfTrombo in '..\BaseAdapters\InformationForWeeklyReport\OZK\ConsumptionOfTrombo\BIOCConsumptionOfTrombo.pas',
  MIOCConsumptionOfTrombo in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfTrombo\MIOCConsumptionOfTrombo.pas',
  MIOFFlowRateOfWholeBlood in '..\Model\InformationForWeeklyReport\OZK\FlowRateOfWholeBlood\MIOFFlowRateOfWholeBlood.pas',
  BIOFFlowRateOfWholeBlood in '..\BaseAdapters\InformationForWeeklyReport\OZK\FlowRateOfWholeBlood\BIOFFlowRateOfWholeBlood.pas',
  MIOOKDK in '..\Model\InformationForWeeklyReport\OKDK\MIOOKDK.pas',
  BIOOKDK in '..\BaseAdapters\InformationForWeeklyReport\OKDK\BIOOKDK.pas',
  BIOCurrentType in '..\BaseAdapters\InformationForWeeklyReport\OKDK\BIOCurrentType.pas',
  BIOTypeOfSelectRow in '..\BaseAdapters\InformationForWeeklyReport\OKDK\BIOTypeOfSelectRow.pas',
  BIONameTypeOfSelectRow in '..\BaseAdapters\InformationForWeeklyReport\OKDK\BIONameTypeOfSelectRow.pas',
  BIOAddRecord in '..\BaseAdapters\InformationForWeeklyReport\OKDK\BIOAddRecord.pas',
  BIODeleteRecord in '..\BaseAdapters\InformationForWeeklyReport\OKDK\BIODeleteRecord.pas',
  BIOChangeRecord in '..\BaseAdapters\InformationForWeeklyReport\OKDK\BIOChangeRecord.pas',
  BIECAddRecordCancellation in '..\BaseAdapters\InformationForWeeklyReport\Expedition\Cancellation\BIECAddRecordCancellation.pas',
  BIECDeleteRecordCancellation in '..\BaseAdapters\InformationForWeeklyReport\Expedition\Cancellation\BIECDeleteRecordCancellation.pas',
  BIEChangeRecordCancellation in '..\BaseAdapters\InformationForWeeklyReport\Expedition\Cancellation\BIEChangeRecordCancellation.pas',
  BIEChangeRecordResultsInKray in '..\BaseAdapters\InformationForWeeklyReport\Expedition\TheResultsInKray\BIEChangeRecordResultsInKray.pas',
  BIEAddRecordResultsInKray in '..\BaseAdapters\InformationForWeeklyReport\Expedition\TheResultsInKray\BIEAddRecordResultsInKray.pas',
  BIEDeleteRecordResultsInKray in '..\BaseAdapters\InformationForWeeklyReport\Expedition\TheResultsInKray\BIEDeleteRecordResultsInKray.pas',
  BIEAddRecordResultsInLPU in '..\BaseAdapters\InformationForWeeklyReport\Expedition\TheResultsInLPU\BIEAddRecordResultsInLPU.pas',
  BIEChangeRecordResultsInLPU in '..\BaseAdapters\InformationForWeeklyReport\Expedition\TheResultsInLPU\BIEChangeRecordResultsInLPU.pas',
  BIEDeleteRecordResultsInLPU in '..\BaseAdapters\InformationForWeeklyReport\Expedition\TheResultsInLPU\BIEDeleteRecordResultsInLPU.pas',
  BIOAAddRecordResultsInAdviceToDoctor in '..\BaseAdapters\InformationForWeeklyReport\Other\AdviceToDoctors\BIOAAddRecordResultsInAdviceToDoctor.pas',
  BIOAChangeRecordResultsInAdviceToDoctor in '..\BaseAdapters\InformationForWeeklyReport\Other\AdviceToDoctors\BIOAChangeRecordResultsInAdviceToDoctor.pas',
  BIOADeleteRecordResultsInAdviceToDoctor in '..\BaseAdapters\InformationForWeeklyReport\Other\AdviceToDoctors\BIOADeleteRecordResultsInAdviceToDoctor.pas',
  BIOADeleteRecordResultsAmountOfUsableErSusp in '..\BaseAdapters\InformationForWeeklyReport\Other\AmountOfUsableErSusp\BIOADeleteRecordResultsAmountOfUsableErSusp.pas',
  BIOAAddRecordResultsAmountOfUsableErSusp in '..\BaseAdapters\InformationForWeeklyReport\Other\AmountOfUsableErSusp\BIOAAddRecordResultsAmountOfUsableErSusp.pas',
  BIOAChangeRecordResultsAmountOfUsableErSusp in '..\BaseAdapters\InformationForWeeklyReport\Other\AmountOfUsableErSusp\BIOAChangeRecordResultsAmountOfUsableErSusp.pas',
  BIOCAddRecordResultsCheckLPU in '..\BaseAdapters\InformationForWeeklyReport\Other\CheckLPU\BIOCAddRecordResultsCheckLPU.pas',
  BIOCChangeRecordResultsCheckLPU in '..\BaseAdapters\InformationForWeeklyReport\Other\CheckLPU\BIOCChangeRecordResultsCheckLPU.pas',
  BIOCDeleteRecordResultsCheckLPU in '..\BaseAdapters\InformationForWeeklyReport\Other\CheckLPU\BIOCDeleteRecordResultsCheckLPU.pas',
  BIOCAddRecordConsumption in '..\BaseAdapters\InformationForWeeklyReport\OZK\ConsumptionOfErythrocyteEnvironments\BIOCAddRecordConsumption.pas',
  BIOCChangeRecordConsumption in '..\BaseAdapters\InformationForWeeklyReport\OZK\ConsumptionOfErythrocyteEnvironments\BIOCChangeRecordConsumption.pas',
  BIOCDeleteRecordConsumption in '..\BaseAdapters\InformationForWeeklyReport\OZK\ConsumptionOfErythrocyteEnvironments\BIOCDeleteRecordConsumption.pas',
  BIOCAddRecordConsumptionOfPlazma in '..\BaseAdapters\InformationForWeeklyReport\OZK\ConsumptionOfPlazma\BIOCAddRecordConsumptionOfPlazma.pas',
  BIOCChangeRecordConsumptionOfPlazma in '..\BaseAdapters\InformationForWeeklyReport\OZK\ConsumptionOfPlazma\BIOCChangeRecordConsumptionOfPlazma.pas',
  BIOCDeleteRecordConsumptionOfPlazma in '..\BaseAdapters\InformationForWeeklyReport\OZK\ConsumptionOfPlazma\BIOCDeleteRecordConsumptionOfPlazma.pas',
  BIOCAddRecordConsumptionOfTrombo in '..\BaseAdapters\InformationForWeeklyReport\OZK\ConsumptionOfTrombo\BIOCAddRecordConsumptionOfTrombo.pas',
  BIOCChangeRecordConsumptionOfTrombo in '..\BaseAdapters\InformationForWeeklyReport\OZK\ConsumptionOfTrombo\BIOCChangeRecordConsumptionOfTrombo.pas',
  BIOCDeleteRecordConsumptionOfTrombo in '..\BaseAdapters\InformationForWeeklyReport\OZK\ConsumptionOfTrombo\BIOCDeleteRecordConsumptionOfTrombo.pas',
  BIOFAddRecordFlowRateOfWholeBlood in '..\BaseAdapters\InformationForWeeklyReport\OZK\FlowRateOfWholeBlood\BIOFAddRecordFlowRateOfWholeBlood.pas',
  BIOFChangeRecordFlowRateOfWholeBlood in '..\BaseAdapters\InformationForWeeklyReport\OZK\FlowRateOfWholeBlood\BIOFChangeRecordFlowRateOfWholeBlood.pas',
  BIOFDeleteRecordFlowRateOfWholeBlood in '..\BaseAdapters\InformationForWeeklyReport\OZK\FlowRateOfWholeBlood\BIOFDeleteRecordFlowRateOfWholeBlood.pas',
  MHMManualHarvesting in '..\Model\HarvestingOfTheDay\ManualHarvesting\MHMManualHarvesting.pas',
  MFCheckBox in '..\Model\FormObjects\MFCheckBox.pas',
  BHMManualHarvesting in '..\BaseAdapters\HarvestingOfTheDay\ManualHarvesting\BHMManualHarvesting.pas',
  BHMAddRecordManualHarvesting in '..\BaseAdapters\HarvestingOfTheDay\ManualHarvesting\BHMAddRecordManualHarvesting.pas',
  BHMDeleteRecordManualHarvesting in '..\BaseAdapters\HarvestingOfTheDay\ManualHarvesting\BHMDeleteRecordManualHarvesting.pas',
  BHMChangeRecordManualHarvesting in '..\BaseAdapters\HarvestingOfTheDay\ManualHarvesting\BHMChangeRecordManualHarvesting.pas',
  MHAAutomaticApheresis in '..\Model\HarvestingOfTheDay\AutomaticApheresis\MHAAutomaticApheresis.pas',
  BHAAutomaticApheresis in '..\BaseAdapters\HarvestingOfTheDay\AutomaticApheresis\BHAAutomaticApheresis.pas',
  BHADeleteRecordAutomaticApheresis in '..\BaseAdapters\HarvestingOfTheDay\AutomaticApheresis\BHADeleteRecordAutomaticApheresis.pas',
  BHAAddRecordAutomaticApheresis in '..\BaseAdapters\HarvestingOfTheDay\AutomaticApheresis\BHAAddRecordAutomaticApheresis.pas',
  BHAChangeRecordAutomaticApheresis in '..\BaseAdapters\HarvestingOfTheDay\AutomaticApheresis\BHAChangeRecordAutomaticApheresis.pas',
  MHSSitoferez in '..\Model\HarvestingOfTheDay\Sitoferez\MHSSitoferez.pas',
  BHSSitoferez in '..\BaseAdapters\HarvestingOfTheDay\Sitoferez\BHSSitoferez.pas',
  BHSDeleteRecordSitoferez in '..\BaseAdapters\HarvestingOfTheDay\Sitoferez\BHSDeleteRecordSitoferez.pas',
  BHSAddRecordSitoferez in '..\BaseAdapters\HarvestingOfTheDay\Sitoferez\BHSAddRecordSitoferez.pas',
  BHSChangeRecordSitoferez in '..\BaseAdapters\HarvestingOfTheDay\Sitoferez\BHSChangeRecordSitoferez.pas',
  BRDDailyReportToTheKray in '..\BaseAdapters\Reports\DailyReportToTheKray\BRDDailyReportToTheKray.pas',
  MRDDailyReportTheKray in '..\Model\Reports\DailyReportToTheKray\MRDDailyReportTheKray.pas',
  MFMainMenu in '..\Model\FormObjects\MFMainMenu.pas',
  BRDDeilyReportToTheZav in '..\BaseAdapters\Reports\DeilyReportToTheZav\BRDDeilyReportToTheZav.pas',
  MRDDeilyReportToTheZav in '..\Model\Reports\DeilyReportToTheZav\MRDDeilyReportToTheZav.pas',
  BRDPlanDeilyReportToTheZav in '..\BaseAdapters\Reports\DeilyReportToTheZav\BRDPlanDeilyReportToTheZav.pas',
  BRDStatInfoDeilyReportToTheZav in '..\BaseAdapters\Reports\DeilyReportToTheZav\BRDStatInfoDeilyReportToTheZav.pas',
  MRWWeeklyReport in '..\Model\Reports\WeeklyReport\MRWWeeklyReport.pas',
  BRWWeeklyReportProduction in '..\BaseAdapters\Reports\WeeklyReport\BRWWeeklyReportProduction.pas',
  BRWTableForDefect in '..\BaseAdapters\Reports\WeeklyReport\BRWTableForDefect.pas',
  BRWSecondTable in '..\BaseAdapters\Reports\WeeklyReport\BRWSecondTable.pas',
  BRWDonorsAndProcedures in '..\BaseAdapters\Reports\WeeklyReport\BRWDonorsAndProcedures.pas',
  BRWResultsOfTheProducts in '..\BaseAdapters\Reports\WeeklyReport\BRWResultsOfTheProducts.pas',
  BRWDonorsAndProceduresOuting in '..\BaseAdapters\Reports\WeeklyReport\BRWDonorsAndProceduresOuting.pas',
  BRWReasonsForMedicalExemptions in '..\BaseAdapters\Reports\WeeklyReport\BRWReasonsForMedicalExemptions.pas',
  BRWLPUConsultation in '..\BaseAdapters\Reports\WeeklyReport\BRWLPUConsultation.pas',
  BRWCancellation_Kray in '..\BaseAdapters\Reports\WeeklyReport\BRWCancellation_Kray.pas',
  BRWIncompleteWeekFirstTable in '..\BaseAdapters\Reports\WeeklyIncompleteWeek\BRWIncompleteWeekFirstTable.pas',
  MRWWeeklyIncompleteWeek in '..\Model\Reports\WeeklyIncompleteWeek\MRWWeeklyIncompleteWeek.pas',
  BRWTableForDefectIncompleteWeek in '..\BaseAdapters\Reports\WeeklyIncompleteWeek\BRWTableForDefectIncompleteWeek.pas',
  BRWSecondTableIncompleteWeek in '..\BaseAdapters\Reports\WeeklyIncompleteWeek\BRWSecondTableIncompleteWeek.pas',
  BRWResultsOfTheProductsIncompleteWeek in '..\BaseAdapters\Reports\WeeklyIncompleteWeek\BRWResultsOfTheProductsIncompleteWeek.pas',
  BRWDonorsAndProceduresIncompleteWeek in '..\BaseAdapters\Reports\WeeklyIncompleteWeek\BRWDonorsAndProceduresIncompleteWeek.pas',
  BRWDonorsAndProceduresIncompleteWeekOuting in '..\BaseAdapters\Reports\WeeklyIncompleteWeek\BRWDonorsAndProceduresIncompleteWeekOuting.pas',
  BRWMedicalExemptionsIncompleteWeek in '..\BaseAdapters\Reports\WeeklyIncompleteWeek\BRWMedicalExemptionsIncompleteWeek.pas',
  BRWLPUConsultationIncompleteWeek in '..\BaseAdapters\Reports\WeeklyIncompleteWeek\BRWLPUConsultationIncompleteWeek.pas',
  BRWCancellation_KrayIncomlpeteWeek in '..\BaseAdapters\Reports\WeeklyIncompleteWeek\BRWCancellation_KrayIncomlpeteWeek.pas',
  BRWResultsOfTheProductsIncompleteWeek2 in '..\BaseAdapters\Reports\WeeklyIncompleteWeek\BRWResultsOfTheProductsIncompleteWeek2.pas',
  BMMonthlyPlan in '..\BaseAdapters\MonthlyPlan\BMMonthlyPlan.pas',
  MMMonthlyPlan in '..\Model\MonthlyPlan\MMMonthlyPlan.pas',
  BMDeleteRecordMonthlyPlan in '..\BaseAdapters\MonthlyPlan\BMDeleteRecordMonthlyPlan.pas',
  BMChangeRecordMonthlyPlan in '..\BaseAdapters\MonthlyPlan\BMChangeRecordMonthlyPlan.pas',
  BMAddRecoedMonthlyPlan in '..\BaseAdapters\MonthlyPlan\BMAddRecoedMonthlyPlan.pas',
  MFListBox in '..\Model\FormObjects\MFListBox.pas',
  BMListOfDate in '..\BaseAdapters\MonthlyPlan\BMListOfDate.pas',
  UMCGetDataSource in '..\BaseAdapters\Connect\UMCGetDataSource.pas',
  USBlockMainMenu in '..\Systems\USBlockMainMenu.pas',
  USCheckFillStringFields in '..\Systems\USCheckFillStringFields.pas',
  USCheckForExistenceOfRecord in '..\Systems\USCheckForExistenceOfRecord.pas',
  USCheckNull in '..\Systems\USCheckNull.pas',
  USContentOfTheList in '..\Systems\USContentOfTheList.pas',
  USGlobalVariant in '..\Systems\USGlobalVariant.pas',
  USMoldCleaning in '..\Systems\USMoldCleaning.pas',
  USValueChecksOnTheAdequacy in '..\Systems\USValueChecksOnTheAdequacy.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMyMainForm, MyMainForm);
  Application.Run;
end.
