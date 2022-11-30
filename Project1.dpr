program Project1;

uses
  Vcl.Forms,
  DelphiTips.PopupForm.Main in 'DelphiTips.PopupForm.Main.pas' {Form1},
  Execute.PopupForm in 'Execute.PopupForm.pas',
  DelphiTips.SampleList in 'DelphiTips.SampleList.pas' {SampleList},
  DelphiTips.SamplePopup in 'DelphiTips.SamplePopup.pas' {SamplePopup};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TSampleList, SampleList);
  Application.CreateForm(TSamplePopup, SamplePopup);
  Application.Run;
end.
