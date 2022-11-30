unit DelphiTips.PopupForm.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DelphiTips.SampleList,
  DelphiTips.SamplePopup;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
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
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SamplePopup := TSamplePopup.Create(Self);
  SamplePopup.ShowPopup(Self, Button1);
end;

procedure TForm1.DestroyList(Sender: TObject);
begin
  List := nil;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if List = nil then
    ShowList;
end;

procedure TForm1.ShowList;
begin
  List := TSampleList.Create(Self);
  List.Edit := Edit1;
  List.ListBox1.Items.Text := 'One'#13'Two'#13'Three';
  List.ShowPopup(Self, Edit1);
  List.OnDestroy := DestroyList;
end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if List <> nil then
    List.OnKey(Key)
  else
  if Key = VK_F4 then
    ShowList();
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #0; // don't beep !
end;

end.
