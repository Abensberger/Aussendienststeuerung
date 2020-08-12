unit umain;

{$mode objfpc}{$H+}

interface

uses
  Windows, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ActnList, jwawinuser, BGRAVirtualScreen, BCPanel;

type

  { TForm1 }

  TForm1 = class(TForm)
    actAppClose: TAction;
    ActionList1: TActionList;
    BCPanel1: TBCPanel;
    BCPanel10: TBCPanel;
    BCPanel11: TBCPanel;
    BCPanel12: TBCPanel;
    BCPanel13: TBCPanel;
    BCPanel2: TBCPanel;
    BCPanel3: TBCPanel;
    BCPanel4: TBCPanel;
    BCPanel5: TBCPanel;
    BCPanel6: TBCPanel;
    BCPanel7: TBCPanel;
    BCPanel8: TBCPanel;
    BCPanel9: TBCPanel;
    Button1: TButton;
    Image1: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    pnlStart: TBCPanel;
    BGRAVirtualScreen1: TBGRAVirtualScreen;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    StaticText13: TStaticText;
    StaticText14: TStaticText;
    StaticText15: TStaticText;
    StaticText16: TStaticText;
    StaticText17: TStaticText;
    StaticText18: TStaticText;
    StaticText19: TStaticText;
    StaticText20: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    procedure actAppCloseExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OpenStatisticsClick(Sender: TObject);
    procedure OpenKundenClick(Sender: TObject);
    procedure OpenDashboardClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private
    procedure OpenSecondForm(aForm : TForm);

  public

  end;

var
  Form1: TForm1;

implementation

uses udatamodul, ukunden, uStatistics, udashboard;

{$R *.lfm}

procedure AnimateSafe(hWnd: HWND; dwTime: DWord; dwFlags: DWord);
type
  TAnimateProc = function(a: THandle; b, c: DWord): Boolean; stdcall;
var
  LibHandle   : THandle;   // Handle der DLL
  AnimateProc : TAnimateProc;
begin
  try
    LibHandle := LoadLibrary(Pchar('user32.dll'));
    if LibHandle <> 0 then
    begin
      Pointer(AnimateProc) := GetProcAddress(LibHandle, 'AnimateWindow');
      if @AnimateProc <> nil then
      begin
        AnimateProc(hWnd, dwTime, dwFlags);
      end;
    end;
  finally
    // Freigabe des Arbeitsspeichers
    AnimateProc := nil;
    FreeLibrary(LibHandle);
  end;
end;

procedure OpenAnimatedForm(form2 : TForm);

  procedure Delay(msec: Longint);
  var
    start, stop: Longint;
  begin
    start := GetTickCount;
    repeat
      stop := GetTickCount;
      Application.ProcessMessages;
    until (stop - start) >= msec;
  end;
var
  maxx, maxy: Integer;
begin
  maxx         := form2.Width;
  maxy         := form2.Height;
  form2.Width  := form2.Constraints.MinWidth;
  form2.Height := form2.Constraints.MinHeight;
  form2.Left   := (Screen.Width - form2.Width) div 2;
  form2.Top    := (Screen.Height - form2.Height) div 2;
  form2.Show;

  repeat
    if form2.Height + (maxy div 5) >= maxy then
      form2.Height := maxy
    else
      form2.Height := form2.Height + (maxy div 5);

    if form2.Width + (maxx div 5) >= maxx then
      form2.Width := maxx
    else
      form2.Width := form2.Width + (maxx div 5);

    form2.Left := (Screen.Width - form2.Width) div 2;
    form2.Top  := (Screen.Height - form2.Height) div 2;
    delay(30);

  until (form2.Width = maxx) and (form2.Height = maxy);
end;

{ TForm1 }

procedure TForm1.actAppCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i : integer;
begin
  AlphaBlendValue:=0;
  AlphaBlend:=True;
//  Show;

  for i := 1 to 51 do begin
    AlphaBlendValue:=i*5;
    Sleep(15);
  end;

  AlphaBlend:=False;
end;

function max(a,b : integer):integer;
begin
  result := a;
  if b>a then
    result := b;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  AlphaBlend := False;
  AnimateSafe(Handle, 1000, AW_BLEND or AW_HIDE);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//  Self.AlphaBlendValue:=0;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
//  animin(self)
//  AnimateSafe(Handle, 1000, AW_BLEND);
//  Invalidate;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  myFlags : DWORD;
begin
  randomize;
  myFlags := AW_ACTIVATE or AW_SLIDE or (random(2)+1) or  AW_VER_POSITIVE {(random(2)+1)*4};
  AnimateSafe(self.Handle,350, myFlags { AW_ACTIVATE or AW_SLIDE or AW_HOR_POSITIVE or AW_VER_POSITIVE});
  if not DM.IsConnected then
     StaticText14.Font.Color := clRed
  else
     StaticText14.Font.Color := clWhite;
end;

procedure TForm1.OpenStatisticsClick(Sender: TObject);
begin
  OpenSecondForm(uStatistics.frmStatistiken);
end;

procedure TForm1.OpenSecondForm(aForm : TForm);
begin
  aForm.Visible     := false;
  aForm.Parent      := pnlStart;
  aForm.Align       := alClient;
  aForm.Left        := 0;
  aForm.Top         := 0;
  aForm.Width       := pnlStart.Width;
  aForm.Height      := pnlStart.Height;
  aForm.BorderStyle := bsNone;
  aForm.Show;
end;

procedure TForm1.OpenKundenClick(Sender: TObject);
begin
  OpenSecondForm(ukunden.Form2);
end;

procedure TForm1.OpenDashboardClick(Sender: TObject);
begin
  OpenSecondForm(uDashboard.frmDashboard);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
 // OPenAnimatedForm(self)
end;

end.


