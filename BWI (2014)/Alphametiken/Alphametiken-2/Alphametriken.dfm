object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Alphametiken'
  ClientHeight = 509
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object input: TPanel
    Left = 0
    Top = 0
    Width = 780
    Height = 193
    Align = alTop
    BorderWidth = 5
    BorderStyle = bsSingle
    TabOrder = 0
    object lbinput: TLabel
      Left = 8
      Top = 8
      Width = 30
      Height = 13
      Caption = 'Input:'
    end
    object lbgleich: TLabel
      Left = 272
      Top = 61
      Width = 33
      Height = 21
      Alignment = taCenter
      AutoSize = False
      Caption = '='
    end
    object start: TButton
      Left = 584
      Top = 61
      Width = 99
      Height = 25
      Caption = 'Berechne L'#246'sung'
      Enabled = False
      TabOrder = 4
      OnClick = startClick
    end
    object edeins: TEdit
      Left = 8
      Top = 61
      Width = 105
      Height = 21
      MaxLength = 7
      TabOrder = 0
      OnChange = edeinsChange
      OnKeyPress = edeinsKeyPress
    end
    object edzwei: TEdit
      Left = 167
      Top = 61
      Width = 105
      Height = 21
      MaxLength = 7
      TabOrder = 2
      OnChange = edzweiChange
      OnKeyPress = edzweiKeyPress
    end
    object eddrei: TEdit
      Left = 303
      Top = 61
      Width = 105
      Height = 21
      MaxLength = 8
      TabOrder = 3
      OnChange = eddreiChange
      OnKeyPress = eddreiKeyPress
    end
    object cboperator: TComboBox
      Left = 119
      Top = 61
      Width = 42
      Height = 22
      Style = csOwnerDrawFixed
      ItemHeight = 16
      TabOrder = 1
      OnChange = cboperatorChange
      Items.Strings = (
        '+'
        '-'
        '*'
        '/')
    end
  end
  object output: TPanel
    Left = 0
    Top = 192
    Width = 780
    Height = 317
    Align = alBottom
    BorderWidth = 5
    BorderStyle = bsSingle
    TabOrder = 1
    object lboutput: TLabel
      Left = 8
      Top = 7
      Width = 38
      Height = 13
      Caption = 'Output:'
    end
    object MemoOutput: TMemo
      Left = 104
      Top = 24
      Width = 665
      Height = 281
      TabStop = False
      ReadOnly = True
      TabOrder = 0
    end
  end
end
