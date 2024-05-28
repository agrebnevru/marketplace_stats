object AboutForm: TAboutForm
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'About'
  ClientHeight = 240
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    358
    240)
  PixelsPerInch = 96
  TextHeight = 13
  object Ok: TButton
    Left = 275
    Top = 207
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1082
    TabOrder = 0
    OnClick = OkClick
    ExplicitLeft = 300
    ExplicitTop = 178
  end
  object StaticText1: TStaticText
    Left = 88
    Top = 8
    Width = 136
    Height = 23
    Caption = 'MPStats @ 2015'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object StaticText2: TStaticText
    Left = 8
    Top = 40
    Width = 76
    Height = 17
    Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082': '
    TabOrder = 2
  end
  object StaticText3: TStaticText
    Left = 114
    Top = 40
    Width = 141
    Height = 17
    Caption = #1040#1083#1077#1082#1089#1077#1081' '#1043#1088#1077#1073#1085#1077#1074' AKA MyIE'
    TabOrder = 3
  end
  object StaticText4: TStaticText
    Left = 8
    Top = 63
    Width = 36
    Height = 17
    Caption = 'E-mail:'
    TabOrder = 4
  end
  object StaticText5: TStaticText
    Left = 114
    Top = 63
    Width = 104
    Height = 17
    Caption = 'myietwo@rambler.ru'
    TabOrder = 5
  end
  object StaticText6: TStaticText
    Left = 8
    Top = 104
    Width = 96
    Height = 17
    Caption = #1042#1077#1088#1089#1080#1103' '#1087#1088#1086#1088#1072#1084#1084#1099':'
    TabOrder = 6
  end
  object STAppVersion: TStaticText
    Left = 114
    Top = 104
    Width = 40
    Height = 17
    Caption = '0.0.0.0'
    TabOrder = 7
  end
  object GBAppUpdateLoginAndPass: TGroupBox
    Left = 8
    Top = 127
    Width = 342
    Height = 74
    Caption = #1044#1072#1085#1085#1099#1077' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080' '#1074' '#1088#1072#1079#1076#1077#1083#1077' '#1089#1082#1072#1095#1080#1074#1072#1085#1080#1103' '#1085#1086#1074#1099#1093' '#1074#1077#1088#1089#1080#1081
    TabOrder = 8
    object EditPassord: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 45
      Width = 332
      Height = 21
      Align = alTop
      ReadOnly = True
      TabOrder = 0
      ExplicitLeft = 3
      ExplicitTop = 16
      ExplicitWidth = 121
    end
    object EditLogin: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 332
      Height = 21
      Align = alTop
      ReadOnly = True
      TabOrder = 1
      ExplicitLeft = 3
      ExplicitTop = 16
      ExplicitWidth = 121
    end
  end
end
