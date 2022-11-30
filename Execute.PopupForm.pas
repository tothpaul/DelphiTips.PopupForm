unit Execute.PopupForm;

{

 Easy popup form (c)2022 Paul TOTH <contact@execute.fr>
 https://github.com/tothpaul

}

interface

uses
  System.Types,
  Winapi.Windows,
  Winapi.Messages,
  Vcl.AppEvnts,
  Vcl.Controls,
  Vcl.Forms;

type
  TPopupForm = class(TForm)
  private
  // use a TApplicationEvents to detect when the form should be closed
    FAppEvents: TApplicationEvents;
    procedure OnAppMessage(var Msg: TMsg; var Handled: Boolean);
  // do not activate the form with the mouse
    procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMActivate(var Msg: TWMActivate); message WM_ACTIVATE;
  private
  // allow multiple popup at the same time
    OldPopup: TPopupForm;
    class var ActivePopup: TPopupForm;
  protected
  // force default setting and initialize FAppEvents
    procedure InitializeNewForm; override;
  // add shadow
    procedure CreateParams(var Params: TCreateParams); override;
  public
    destructor Destroy; override;
  // popup the form at the specified position
    procedure ShowPopup(Parent: TCustomForm; const Position: TPoint); overload;
  // popup the form at the bottom left corner of the source control
    procedure ShowPopup(Parent: TCustomForm; Source: TControl); overload;
  end;

implementation

{ TPopupForm }

procedure TPopupForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
// we want a nice shadow effect
  Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
// set parent to 0 or the shadow effect is lost when the form is active
  Params.WndParent := 0;
end;

destructor TPopupForm.Destroy;
begin
// restore old popup
  ActivePopup := OldPopup;
  inherited;
end;

procedure TPopupForm.InitializeNewForm;
begin
  inherited;
// listen to app events
  FAppEvents := TApplicationEvents.Create(Self);
  FAppEvents.OnMessage := OnAppMessage;
// force properties so you don't have to set them at design time
  BorderStyle := bsNone;
  Position := poDesigned;
end;

procedure TPopupForm.OnAppMessage(var Msg: TMsg; var Handled: Boolean);
begin
// to simplify things, the Schrödinger's PopupForm is visible or dead (never hidden)
  case Msg.message of
  // any click event...
    WM_LBUTTONDOWN,
    WM_RBUTTONDOWN,
    WM_MBUTTONDOWN,
    WM_NCLBUTTONDOWN,
    WM_NCRBUTTONDOWN,
    WM_NCMBUTTONDOWN:
    begin
      var Ctrl := FindControl(Msg.hwnd);
    // click on something that is not part of the VCL (what about an ActiveX ? never mind, I never use them)
      if Ctrl = nil then
        Release
      else begin
      // verify that the target form is a TPopupForm, and that it is the active one
      // note that if you have 3 popup, only the last one will be closed even if you click on the 1st one
        var Form := GetParentForm(Ctrl);
        if (not (Form is TPopupForm)) or ({(Form is TPopupForm) and} (Form <> Self) and (Self = ActivePopup)) then
          Release;
      end;
    end;
    CM_DEACTIVATE, // Application is desactived
    WM_SYSCHAR: // Alt+Space for instance
      Release;
  end;
end;

procedure TPopupForm.ShowPopup(Parent: TCustomForm; Source: TControl);
begin
// bottom left corner
  var P := Source.ClientToScreen(TPoint.Create(0, Source.Height));
// verify monitor boundaries
  if P.X + Width > Self.Monitor.Width then
    P.X := Self.Monitor.Width - Width;
  if P.Y + Height > Self.Monitor.Height then
    Dec(P.Y, Source.Height + Height);
// show it
  ShowPopup(Parent, P);
end;

procedure TPopupForm.ShowPopup(Parent: TCustomForm; const Position: TPoint);
begin
// save active popup
  OldPopup := ActivePopup;
  ActivePopup := Self;
// move the form to the desired position
  Left := Position.X;
  Top := Position.Y;
// show the form without activation
  ShowWindow(Handle, SW_SHOWNOACTIVATE);
// VCL sync
  Visible := True;
end;

procedure TPopupForm.WMMouseActivate(var Msg: TWMMouseActivate);
begin
// do not activate the form on a click
// but this is useless when the user click on a child control of the form :/
  Msg.Result := MA_NOACTIVATE;
end;

procedure TPopupForm.WMActivate(var Msg: TWMActivate);
begin
// reactivate the border of the old Window
// required when the user click on a child control (MA_NOACTIVATE will not work)
  if Msg.Active = WA_ACTIVE then
    SendMessage(Msg.ActiveWindow, WM_NCACTIVATE, WPARAM(True), -1);
  Msg.Result := 0;
end;

end.
