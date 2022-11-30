object SampleList: TSampleList
  Left = 0
  Top = 0
  Caption = 'SampleList'
  ClientHeight = 140
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 379
    Height = 140
    Align = alClient
    ItemHeight = 15
    TabOrder = 0
    OnDblClick = ListBox1DblClick
    ExplicitHeight = 97
  end
end
