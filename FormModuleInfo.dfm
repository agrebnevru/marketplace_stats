object ModuleInfo: TModuleInfo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'ModuleInfo'
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
    ExplicitLeft = -274
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
      object STPDataID: TStaticText
        Left = 86
        Top = 23
        Width = 8
        Height = 17
        Caption = '-'
        TabOrder = 4
      end
      object STPDataCODE: TStaticText
        Left = 310
        Top = 23
        Width = 8
        Height = 17
        Caption = '-'
        TabOrder = 5
      end
      object STPDataNAME: TStaticText
        Left = 86
        Top = 0
        Width = 8
        Height = 17
        Caption = '-'
        TabOrder = 6
      end
      object STPDataSITE: TStaticText
        Left = 536
        Top = 23
        Width = 8
        Height = 17
        Caption = '-'
        TabOrder = 7
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 73
    Width = 919
    Height = 75
    Align = alTop
    Caption = #1052#1086#1076#1091#1083#1100
    TabOrder = 1
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 9
      Top = 22
      Width = 901
      Height = 44
      Margins.Left = 7
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 7
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 11
      ExplicitTop = 24
      ExplicitHeight = 17
      object StaticText1: TStaticText
        Left = 0
        Top = 23
        Width = 68
        Height = 17
        Caption = #1050#1086#1076' '#1084#1086#1076#1091#1083#1103':'
        TabOrder = 0
      end
      object StaticText3: TStaticText
        Left = 1
        Top = 0
        Width = 81
        Height = 17
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        TabOrder = 1
      end
      object STMDataCode: TStaticText
        Left = 86
        Top = 23
        Width = 8
        Height = 17
        Caption = '-'
        TabOrder = 2
      end
      object STMDataName: TStaticText
        Left = 86
        Top = 0
        Width = 8
        Height = 17
        Caption = '-'
        TabOrder = 3
      end
    end
  end
  object DBGridMInfo: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 187
    Width = 913
    Height = 382
    Margins.Top = 0
    Align = alClient
    DataSource = DataSourceMInfo
    PopupMenu = PopMenuMInfo
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
        FieldName = 'M_DATA_INFO'
        Title.Caption = #1044#1072#1090#1072
        Width = 80
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
  object PanelFilter: TPanel
    AlignWithMargins = True
    Left = 7
    Top = 155
    Width = 905
    Height = 25
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 128
    object ButtonMIFilter: TButton
      AlignWithMargins = True
      Left = 327
      Top = 2
      Width = 75
      Height = 21
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      TabOrder = 0
      OnClick = ButtonMIFilterClick
    end
    object DateTimePickerMInfoTo: TDateTimePicker
      Left = 221
      Top = 2
      Width = 100
      Height = 21
      Date = 42370.756749780090000000
      Time = 42370.756749780090000000
      TabOrder = 1
    end
    object StaticTextPLInfoDateTo: TStaticText
      Left = 165
      Top = 6
      Width = 50
      Height = 17
      Caption = #1044#1072#1090#1072' '#1076#1086':'
      TabOrder = 2
    end
    object DateTimePickerMInfoFrom: TDateTimePicker
      Left = 56
      Top = 2
      Width = 100
      Height = 21
      Date = 42005.756749780090000000
      Time = 42005.756749780090000000
      TabOrder = 3
    end
    object StaticTextPLInfoDateFrom: TStaticText
      Left = 0
      Top = 6
      Width = 49
      Height = 17
      Caption = #1044#1072#1090#1072' '#1086#1090':'
      TabOrder = 4
    end
  end
  object DataSourceMInfo: TDataSource
    DataSet = ADOQueryMInfo
    Left = 24
    Top = 184
  end
  object ADOQueryMInfo: TADOQuery
    Connection = MainForm.ADOConn
    Parameters = <>
    Left = 24
    Top = 224
  end
  object PopMenuMInfo: TPopupMenu
    Images = MainForm.ProgImages
    Left = 20
    Top = 266
    object PMPL_Delete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      ImageIndex = 1
    end
  end
end
