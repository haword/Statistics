object MyMainForm: TMyMainForm
  Left = 0
  Top = 0
  Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1087#1086' '#1079#1072#1075#1086#1090#1086#1074#1082#1077' '#1082#1088#1086#1074#1080
  ClientHeight = 654
  ClientWidth = 892
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Tag = 4
    Left = 656
    Top = 24
    object N5: TMenuItem
      Caption = #1047#1072#1075#1086#1090#1086#1074#1082#1072' '#1079#1072' '#1076#1077#1085#1100
      object HandlyHarvesting: TMenuItem
        Caption = '"'#1056#1091#1095#1085#1072#1103'" '#1079#1072#1075#1086#1090#1086#1074#1082#1072
        ShortCut = 16465
        OnClick = HandlyHarvestingClick
      end
      object AutoAferez: TMenuItem
        Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1072#1092#1077#1088#1077#1079
        ShortCut = 16449
        OnClick = AutoAferezClick
      end
      object Citoferez: TMenuItem
        Caption = #1062#1080#1090#1086#1092#1077#1088#1077#1079
        OnClick = CitoferezClick
      end
    end
    object N2: TMenuItem
      Caption = '&'#1054#1090#1095#1077#1090#1099
      object DeilyReportToTheZav: TMenuItem
        Caption = #1045#1078#1077#1076#1085#1077#1074#1085#1099#1081' '#1076#1083#1103' '#1079#1072#1074#1077#1076#1091#1102#1097#1077#1081
        OnClick = DeilyReportToTheZavClick
      end
      object KrasnEveryDay: TMenuItem
        Caption = #1045#1078#1077#1076#1085#1077#1074#1085#1099#1081' '#1074' '#1050#1088#1072#1089#1085#1086#1103#1088#1089#1082
        OnClick = KrasnEveryDayClick
      end
      object WeeklyReport: TMenuItem
        Caption = #1053#1077#1076#1077#1083#1100#1085#1099#1081
        OnClick = WeeklyReportClick
      end
    end
    object N6: TMenuItem
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1076#1083#1103' '#1085#1077#1076#1077#1083#1100#1085#1086#1075#1086
      object VIO_OKDK: TMenuItem
        Caption = #1054#1050#1044#1050
        OnClick = VIO_OKDKClick
      end
      object N10: TMenuItem
        Caption = #1069#1082#1089#1087#1077#1076#1080#1094#1080#1103
        object ResultsLPU: TMenuItem
          Caption = #1042#1099#1076#1072#1095#1072' '#1074' '#1051#1055#1059
          OnClick = ResultsLPUClick
        end
        object ResultsInKray: TMenuItem
          Caption = #1042#1099#1076#1072#1095#1072' '#1074' '#1082#1088#1072#1081
          OnClick = ResultsInKrayClick
        end
        object BCancellation: TMenuItem
          Caption = #1057#1087#1080#1089#1072#1085#1080#1077
          OnClick = BCancellationClick
        end
      end
      object N11: TMenuItem
        Caption = #1055#1088#1086#1095#1077#1077
        object AmountUsableErSusp: TMenuItem
          Caption = #1054#1073#1098#1077#1084' '#1075#1086#1076#1085#1099#1093' '#1101#1088'. '#1089#1088#1077#1076
          OnClick = AmountUsableErSuspClick
        end
        object AdviceDoctors: TMenuItem
          Caption = #1050#1086#1085#1089#1091#1083#1100#1090#1072#1094#1080#1080' '#1074#1088#1072#1095#1077#1081
          OnClick = AdviceDoctorsClick
        end
        object BCheckLPU: TMenuItem
          Caption = #1055#1088#1086#1074#1077#1088#1082#1080' '#1051#1055#1059
          OnClick = BCheckLPUClick
        end
      end
      object N7: TMenuItem
        Caption = #1054#1047#1050
        object ConsumptionErythrocyteEnvironments: TMenuItem
          Caption = #1056#1072#1089#1093#1086#1076' '#1101#1088'. '#1089#1088#1077#1076
          OnClick = ConsumptionErythrocyteEnvironmentsClick
        end
        object ConsumptionPlazma: TMenuItem
          Caption = #1056#1072#1089#1093#1086#1076' '#1087#1083#1072#1079#1084#1099
          OnClick = ConsumptionPlazmaClick
        end
        object ConsumptionTrombo: TMenuItem
          Caption = #1056#1072#1089#1093#1086#1076' '#1090#1088#1086#1084#1073#1086#1094#1080#1090#1086#1074
          OnClick = ConsumptionTromboClick
        end
        object FlowRateWholeBlood: TMenuItem
          Caption = #1056#1072#1089#1093#1086#1076' '#1094#1077#1083#1100#1085#1086#1081' '#1082#1088#1086#1074#1080
          OnClick = FlowRateWholeBloodClick
        end
      end
    end
    object N3: TMenuItem
      Caption = '&'#1047#1072#1087#1088#1086#1089#1099
      object QueryNumberOfDonations: TMenuItem
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1086#1085#1072#1094#1080#1081
        OnClick = QueryNumberOfDonationsClick
      end
      object BloodProduction: TMenuItem
        Caption = #1047#1072#1075#1086#1090#1086#1074#1082#1072' '#1082#1088#1086#1074#1080
        OnClick = BloodProductionClick
      end
      object ProcurementOfComponentsTotal: TMenuItem
        Caption = #1047#1072#1075#1086#1090#1086#1074#1082#1072' '#1082#1086#1084#1087#1086#1085#1077#1085#1090#1086#1074' ('#1086#1073#1097#1080#1081')'
        OnClick = ProcurementOfComponentsTotalClick
      end
      object HarvestingBloodComponentsByTypes: TMenuItem
        Caption = #1047#1072#1075#1086#1090#1086#1074#1082#1072' '#1082#1086#1084#1087#1086#1085#1077#1085#1090#1086#1074' ('#1087#1086' '#1074#1080#1076#1072#1084')'
        OnClick = HarvestingBloodComponentsByTypesClick
      end
    end
    object MonthlyPlan: TMenuItem
      Caption = #1052#1077#1089#1103#1095#1085#1099#1077' '#1087#1083#1072#1085#1099
      OnClick = MonthlyPlanClick
    end
    object Help1: TMenuItem
      Caption = '&'#1055#1086#1084#1086#1097#1100
      OnClick = Help1Click
    end
    object CloseButton: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = CloseButtonClick
    end
  end
end
