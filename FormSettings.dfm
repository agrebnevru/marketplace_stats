object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 347
  ClientWidth = 674
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TCSettings: TTabControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 668
    Height = 298
    Align = alClient
    BiDiMode = bdLeftToRight
    MultiLine = True
    ParentBiDiMode = False
    TabOrder = 0
    Tabs.Strings = (
      #1054#1073#1097#1080#1077)
    TabIndex = 0
    object Label1: TLabel
      Left = 16
      Top = 80
      Width = 150
      Height = 13
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1082#1083#1072#1076#1082#1091' '#1072#1074#1090#1086#1089#1073#1086#1088#1072
      WordWrap = True
    end
    object Label2: TLabel
      Left = 16
      Top = 99
      Width = 173
      Height = 13
      Caption = #1055#1088#1080#1084#1077#1085#1103#1090#1100' '#1092#1080#1083#1100#1090#1088#1099' '#1087#1088#1080' '#1079#1072#1075#1088#1091#1079#1082#1077
      WordWrap = True
    end
    object Label3: TLabel
      Left = 16
      Top = 270
      Width = 132
      Height = 13
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1088#1077#1078#1080#1084' '#1086#1090#1083#1072#1076#1082#1080
      WordWrap = True
    end
    object Label4: TLabel
      Left = 16
      Top = 118
      Width = 101
      Height = 13
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1072#1074#1090#1086#1089#1073#1086#1088
      WordWrap = True
    end
    object Label5: TLabel
      Left = 16
      Top = 137
      Width = 173
      Height = 16
      Caption = #1057#1073#1086#1088' '#1058#1086#1087'30 '#1084#1072#1088#1082#1077#1090#1087#1083#1077#1081#1089
      WordWrap = True
    end
    object StaticText1: TStaticText
      Left = 16
      Top = 40
      Width = 113
      Height = 17
      Caption = #1055#1091#1090#1100' '#1082' '#1092#1072#1081#1083#1091' '#1089' '#1073#1072#1079#1086#1081
      TabOrder = 0
    end
    object ESDBFilePath: TEdit
      Left = 199
      Top = 36
      Width = 410
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object BSBrowser: TButton
      Left = 615
      Top = 36
      Width = 34
      Height = 21
      Caption = '...'
      TabOrder = 2
      OnClick = BSBrowserClick
    end
    object StaticText2: TStaticText
      Left = 199
      Top = 58
      Width = 342
      Height = 15
      Caption = 
        #1055#1088#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1080' '#1076#1072#1085#1085#1086#1075#1086' '#1087#1072#1088#1072#1084#1077#1090#1088#1072' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1087#1077#1088#1077#1079#1072#1087#1091#1089#1090#1080#1090#1100' '#1087#1088#1080#1083#1086#1083#1078 +
        #1077#1085#1080#1077'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clAppWorkSpace
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object CBShowAGTab: TCheckBox
      Left = 199
      Top = 79
      Width = 22
      Height = 17
      TabOrder = 4
    end
    object CBApplyFiltersOnStart: TCheckBox
      Left = 199
      Top = 98
      Width = 22
      Height = 17
      TabOrder = 5
    end
    object CBDebugMode: TCheckBox
      Left = 199
      Top = 269
      Width = 22
      Height = 17
      TabOrder = 6
    end
    object CBAGOn: TCheckBox
      Left = 199
      Top = 117
      Width = 22
      Height = 17
      TabOrder = 7
    end
    object CBTopMPOn: TCheckBox
      Left = 199
      Top = 136
      Width = 22
      Height = 17
      TabOrder = 8
    end
  end
  object PSButtons: TPanel
    Left = 0
    Top = 304
    Width = 674
    Height = 43
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BSOk: TButton
      AlignWithMargins = True
      Left = 504
      Top = 8
      Width = 65
      Height = 27
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 15
      Margins.Bottom = 8
      Align = alRight
      Caption = #1054#1082
      ImageIndex = 10
      Images = MainForm.ProgImages
      TabOrder = 0
      OnClick = BSOkClick
    end
    object BSCancel: TButton
      AlignWithMargins = True
      Left = 592
      Top = 8
      Width = 67
      Height = 27
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 15
      Margins.Bottom = 8
      Align = alRight
      Caption = #1054#1090#1084#1077#1085#1072
      ImageIndex = 11
      Images = MainForm.ProgImages
      TabOrder = 1
      OnClick = BSCancelClick
    end
  end
  object ODS: TOpenDialog
    Left = 67
    Top = 3
  end
end
