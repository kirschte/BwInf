object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'p'
  ClientHeight = 600
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 100
    Width = 500
    Height = 500
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 500
    Height = 100
    Caption = 'Panel1'
    Color = clActiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBackground
    Font.Height = -11
    Font.Name = 'Vrinda'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 127
      Top = 4
      Width = 40
      Height = 16
      Caption = 'Ameisen'
    end
    object Label2: TLabel
      Left = 127
      Top = 23
      Width = 21
      Height = 16
      Caption = 'Nest'
    end
    object Label3: TLabel
      Left = 127
      Top = 42
      Width = 59
      Height = 16
      Caption = 'Futtermenge'
    end
    object Label4: TLabel
      Left = 127
      Top = 83
      Width = 60
      Height = 16
      Caption = 'Verdunstung'
    end
    object Label5: TLabel
      Left = 127
      Top = 64
      Width = 61
      Height = 16
      Caption = 'Futterquellen'
    end
    object Schritte: TLabel
      Left = 401
      Top = 80
      Width = 6
      Height = 16
      Caption = '0'
    end
    object Label6: TLabel
      Left = 356
      Top = 80
      Width = 39
      Height = 16
      Caption = 'Schritte:'
    end
    object Label7: TLabel
      Left = 356
      Top = 3
      Width = 62
      Height = 16
      Caption = 'Max Schritte'
    end
    object Start: TButton
      Left = 0
      Top = 0
      Width = 100
      Height = 99
      Caption = 'Start'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -27
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = StartClick
    end
    object edAmeisen: TEdit
      Left = 200
      Top = 0
      Width = 150
      Height = 24
      TabOrder = 1
      Text = '500'
    end
    object edFuttermenge: TEdit
      Left = 200
      Top = 39
      Width = 150
      Height = 24
      TabOrder = 2
      Text = '30'
    end
    object edFutterquellen: TEdit
      Left = 200
      Top = 58
      Width = 150
      Height = 24
      TabOrder = 3
      Text = '5000'
    end
    object edVerdunstung: TEdit
      Left = 200
      Top = 80
      Width = 150
      Height = 24
      TabOrder = 4
      Text = '30'
    end
    object edx: TEdit
      Left = 200
      Top = 20
      Width = 75
      Height = 24
      TabOrder = 5
      Text = '250'
    end
    object edy: TEdit
      Left = 275
      Top = 20
      Width = 75
      Height = 24
      TabOrder = 6
      Text = '250'
    end
    object edSchritte: TEdit
      Left = 356
      Top = 20
      Width = 121
      Height = 24
      TabOrder = 7
      Text = '1000000'
    end
  end
end
