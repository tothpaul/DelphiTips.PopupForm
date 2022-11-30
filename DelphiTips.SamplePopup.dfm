object SamplePopup: TSamplePopup
  Left = 0
  Top = 0
  Caption = 'SamplePopup'
  ClientHeight = 125
  ClientWidth = 333
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Edit1: TEdit
    Left = 24
    Top = 24
    Width = 121
    Height = 23
    TabOrder = 0
    Text = 'Edit1'
    OnChange = Edit1Change
    OnKeyDown = Edit1KeyDown
    OnKeyPress = Edit1KeyPress
  end
  object Button1: TButton
    Left = 176
    Top = 23
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 48
    Top = 64
    Width = 97
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 2
  end
end
