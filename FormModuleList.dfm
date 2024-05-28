object ModuleList: TModuleList
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1087#1080#1089#1086#1082' '#1084#1086#1076#1091#1083#1077#1081
  ClientHeight = 572
  ClientWidth = 919
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
  object GBPartnerInformation: TGroupBox
    Left = 0
    Top = 0
    Width = 919
    Height = 73
    Align = alTop
    Caption = #1055#1072#1088#1090#1085#1077#1088
    TabOrder = 0
    object PanelPartnerInfo: TPanel
      AlignWithMargins = True
      Left = 9
      Top = 22
      Width = 901
      Height = 42
      Margins.Left = 7
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 7
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object STPartnerInfoID: TStaticText
        Left = 0
        Top = 23
        Width = 70
        Height = 17
        Caption = 'ID '#1087#1072#1088#1090#1085#1077#1088#1072':'
        TabOrder = 0
      end
      object STPartnerInfoCode: TStaticText
        Left = 225
        Top = 23
        Width = 79
        Height = 17
        Caption = #1050#1086#1076' '#1087#1072#1088#1090#1085#1077#1088#1072':'
        TabOrder = 1
      end
      object STPartnerInfoName: TStaticText
        Left = 1
        Top = 0
        Width = 81
        Height = 17
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        TabOrder = 2
      end
      object STPartnerInfoSite: TStaticText
        Left = 449
        Top = 23
        Width = 33
        Height = 17
        Caption = #1057#1072#1081#1090':'
        TabOrder = 3
      end
      object STDataID: TStaticText
        Left = 86
        Top = 23
        Width = 8
        Height = 17
        Caption = '-'
        TabOrder = 4
      end
      object STDataCODE: TStaticText
        Left = 310
        Top = 23
        Width = 8
        Height = 17
        Caption = '-'
        TabOrder = 5
      end
      object STDataNAME: TStaticText
        Left = 86
        Top = 0
        Width = 8
        Height = 17
        Caption = '-'
        TabOrder = 6
      end
      object STDataSITE: TStaticText
        Left = 536
        Top = 23
        Width = 8
        Height = 17
        Caption = '-'
        TabOrder = 7
      end
    end
  end
  object PanelFilter: TPanel
    AlignWithMargins = True
    Left = 7
    Top = 80
    Width = 905
    Height = 54
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object StaticTextMLName: TStaticText
      Left = 0
      Top = 34
      Width = 56
      Height = 17
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
      TabOrder = 0
    end
    object StaticTextMLCode: TStaticText
      Left = 1
      Top = 6
      Width = 28
      Height = 17
      Caption = #1050#1086#1076':'
      TabOrder = 1
    end
    object ButtonMLInfoFilter: TButton
      AlignWithMargins = True
      Left = 562
      Top = 10
      Width = 75
      Height = 33
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = ButtonMLInfoFilterClick
    end
    object EditMLCode: TEdit
      Left = 59
      Top = 2
      Width = 121
      Height = 21
      TabOrder = 3
      OnKeyPress = EditMLCodeKeyPress
    end
    object EditMLName: TEdit
      Left = 59
      Top = 30
      Width = 121
      Height = 21
      TabOrder = 4
      OnKeyPress = EditMLNameKeyPress
    end
    object StaticText1: TStaticText
      Left = 195
      Top = 6
      Width = 49
      Height = 17
      Caption = #1062#1077#1085#1072' '#1086#1090':'
      TabOrder = 5
    end
    object EditMLPriceFrom: TEdit
      Left = 250
      Top = 2
      Width = 121
      Height = 21
      TabOrder = 6
      OnKeyPress = EditMLPriceFromKeyPress
    end
    object StaticText2: TStaticText
      Left = 195
      Top = 33
      Width = 50
      Height = 17
      Caption = #1062#1077#1085#1072' '#1076#1086':'
      TabOrder = 7
    end
    object EditMLPriceTo: TEdit
      Left = 250
      Top = 30
      Width = 121
      Height = 21
      TabOrder = 8
      OnKeyPress = EditMLPriceToKeyPress
    end
    object StaticText3: TStaticText
      Left = 387
      Top = 6
      Width = 62
      Height = 17
      Caption = #1059#1089#1090#1072#1085#1086#1074#1086#1082':'
      TabOrder = 9
    end
    object CMMLInstallCnt: TComboBox
      Left = 457
      Top = 3
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 10
      Text = #1053#1077' '#1074#1072#1078#1085#1086
      Items.Strings = (
        #1053#1077' '#1074#1072#1078#1085#1086
        #1052#1077#1085#1077#1077' 50'
        '50 - 99'
        '100 - 499'
        '500 - 999'
        #1041#1086#1083#1077#1077' 1000')
    end
  end
  object DBGridMLInfo: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 141
    Width = 913
    Height = 428
    Margins.Top = 0
    Align = alClient
    DataSource = DataSourceML
    DrawingStyle = gdsGradient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopMenuML
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'M_CODE'
        Title.Caption = #1050#1086#1076' '#1084#1086#1076#1091#1083#1103
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'M_NAME'
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'M_FREE'
        Title.Caption = #1041#1077#1089#1087#1083'.'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'M_OLD_PRICE'
        Title.Caption = #1057#1090#1072#1088#1072#1103' '#1094#1077#1085#1072
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'M_PRICE'
        Title.Caption = #1062#1077#1085#1072
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'M_DATE'
        Title.Caption = #1054#1087#1091#1073#1083#1080#1082#1086#1074#1072#1085#1086
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'M_VERSION'
        Title.Caption = #1042#1077#1088#1089#1080#1103
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'M_INSTALL_COUNT'
        Title.Caption = #1059#1089#1090#1072#1085#1086#1074#1086#1082
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'M_DEMO_LINK'
        Title.Caption = #1044#1077#1084#1086
        Width = 125
        Visible = True
      end>
  end
  object ADOQueryML: TADOQuery
    Connection = MainForm.ADOConn
    Parameters = <>
    Left = 24
    Top = 224
  end
  object DataSourceML: TDataSource
    DataSet = ADOQueryML
    Left = 24
    Top = 184
  end
  object PopMenuML: TPopupMenu
    Images = MainForm.ProgImages
    OnPopup = PopMenuMLPopup
    Left = 20
    Top = 266
    object N2: TMenuItem
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1084#1086#1076#1091#1083#1103
      ImageIndex = 7
      OnClick = N2Click
    end
    object PMML_GoToModuleCard: TMenuItem
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1074' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1084#1086#1076#1091#1083#1103' '#1085#1072' marketplace'
      ImageIndex = 14
      OnClick = PMML_GoToModuleCardClick
    end
    object PMML_GoToModuleDemoSite: TMenuItem
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1085#1072' '#1076#1077#1084#1086'-'#1089#1072#1081#1090
      ImageIndex = 15
      OnClick = PMML_GoToModuleDemoSiteClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object PMML_SetAG: TMenuItem
      Caption = #1040#1074#1090#1086#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
      OnClick = PMML_SetAGClick
    end
    object PMML_Refresh: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1091
      ImageIndex = 8
      OnClick = PMML_RefreshClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object PMML_Delete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      ImageIndex = 1
      OnClick = PMML_DeleteClick
    end
  end
end
