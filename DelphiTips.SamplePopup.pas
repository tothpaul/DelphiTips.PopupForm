unit DelphiTips.SamplePopup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Execute.PopupForm,
  DelphiTips.SampleList;

type
  TSamplePopup = class(TPopupForm)
    Edit1: TEdit;
    Button1: TButton;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
    List: TSampleList;
    procedure ShowList;
    procedure DestroyList(Sender: TObject);
  public
    { Déclarations publiques }
  end;

var
  SamplePopup: TSamplePopup;

implementation

{$R *.dfm}

procedure TSamplePopup.Button1Click(Sender: TObject);
begin
  Release;
end;

procedure TSamplePopup.DestroyList(Sender: TObject);
begin
  List := nil;
end;

procedure TSamplePopup.Edit1Change(Sender: TObject);
begin
  if List = nil then
    ShowList;
end;

procedure TSamplePopup.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if List <> nil then
    List.OnKey(Key)
  else
  if Key = VK_F4 then
    ShowList();
end;

procedure TSamplePopup.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #0;
end;

procedure TSamplePopup.ShowList;
begin
  List := TSampleList.Create(Self);
  List.Edit := Edit1;
  List.ListBox1.Items.Text := 'One'#13'Two'#13'Three';
  List.ShowPopup(Self, Edit1);
  List.OnDestroy := DestroyList;
end;

end.
