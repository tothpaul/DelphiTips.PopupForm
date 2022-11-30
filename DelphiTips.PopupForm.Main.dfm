object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 250
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 40
    Top = 35
    Width = 229
    Height = 15
    Caption = 'Sample popup form on a TEdit or a TButton'
  end
  object Edit1: TEdit
    Left = 40
    Top = 112
    Width = 121
    Height = 23
    TabOrder = 0
    Text = 'Edit1'
    OnChange = Edit1Change
    OnKeyDown = Edit1KeyDown
    OnKeyPress = Edit1KeyPress
  end
  object Button1: TButton
    Left = 208
    Top = 111
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnMouseDown = Button1MouseDown
  end
end
