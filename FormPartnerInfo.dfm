object ParthnerInfo: TParthnerInfo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1087#1072#1088#1090#1085#1077#1088#1072
  ClientHeight = 372
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
  object PanelFilter: TPanel
    AlignWithMargins = True
    Left = 7
    Top = 80
    Width = 905
    Height = 28
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object DateTimePickerPLInfoFrom: TDateTimePicker
      Left = 56
      Top = 2
      Width = 100
      Height = 21
      Date = 42005.756749780090000000
      Time = 42005.756749780090000000
      TabOrder = 0
    end
    object DateTimePickerPLInfoTo: TDateTimePicker
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
    object StaticTextPLInfoDateFrom: TStaticText
      Left = 0
      Top = 6
      Width = 49
      Height = 17
      Caption = #1044#1072#1090#1072' '#1086#1090':'
      TabOrder = 3
    end
    object ButtonPLInfoFilter: TButton
      AlignWithMargins = True
      Left = 327
      Top = 2
      Width = 75
      Height = 21
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      DoubleBuffered = False
      ParentDoubleBuffered = False
      TabOrder = 4
      OnClick = ButtonPLInfoFilterClick
    end
  end
  object PanelBottom: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 111
    Width = 913
    Height = 258
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object DBGridPLInfo: TDBGrid
      AlignWithMargins = True
      Left = 3
      Top = 0
      Width = 907
      Height = 255
      Margins.Top = 0
      Align = alClient
      DataSource = DataSourcePLInfo
      DrawingStyle = gdsGradient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      PopupMenu = PopMenuPLInfo
      TabOrder = 0
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
          FieldName = 'P_ID'
          Title.Caption = 'ID '#1087#1072#1088#1090#1085#1077#1088#1072
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'P_DATE_INFO'
          Title.Caption = #1044#1072#1090#1072
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'P_COUNT_MODULE'
          Title.Caption = #1052#1086#1076#1091#1083#1077#1081
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'P_COUNT_MODULE_B24'
          Title.Caption = #1052#1086#1076#1091#1083#1077#1081' '#1041'24'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'P_COUNT_EMPLOYEE'
          Title.Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082#1086#1074
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'P_COUNT_CERTIFICATE'
          Title.Caption = #1057#1077#1088#1090#1080#1092#1080#1082#1072#1090#1086#1074
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'P_COUNT_PROJECT'
          Title.Caption = #1055#1088#1086#1077#1082#1090#1086#1074
          Width = 65
          Visible = True
        end>
    end
  end
  object GBPartnerInformation: TGroupBox
    Left = 0
    Top = 0
    Width = 919
    Height = 73
    Align = alTop
    Caption = #1055#1072#1088#1090#1085#1077#1088
    TabOrder = 2
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
        Left = 0
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
        Left = 85
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
  object DataSourcePLInfo: TDataSource
    DataSet = ADOQueryPLInfo
    Left = 24
    Top = 184
  end
  object ADOQueryPLInfo: TADOQuery
    Connection = MainForm.ADOConn
    Parameters = <>
    Left = 24
    Top = 224
  end
  object PopMenuPLInfo: TPopupMenu
    Images = MainForm.ProgImages
    Left = 20
    Top = 266
    object PMPL_Delete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 1
      OnClick = PMPL_DeleteClick
    end
  end
end
