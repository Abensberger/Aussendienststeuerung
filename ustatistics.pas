unit uStatistics;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  TAGraph, TASeries, BCPanel, BCRadialProgressBar;

type

  { TfrmStatistiken }

  TfrmStatistiken = class(TForm)
    BCPanel1: TBCPanel;
    BCPanel2: TBCPanel;
    BCPanel3: TBCPanel;
    BCPanel4: TBCPanel;
    Image1: TImage;
    Image14: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pnlStatistiken: TBCPanel;
    StaticText14: TStaticText;
    StaticText15: TStaticText;
    StaticText16: TStaticText;
    StaticText17: TStaticText;
    StaticText18: TStaticText;
    StaticText26: TStaticText;
    StaticText27: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure Image14Click(Sender: TObject);
  private

  public

  end;

var
  frmStatistiken: TfrmStatistiken;

implementation

uses jwawinuser;

{$R *.lfm}

{ TfrmStatistiken }

procedure TfrmStatistiken.Image14Click(Sender: TObject);
begin
  AnimateWindow(self.Handle, 350, AW_VER_NEGATIVE OR AW_SLIDE OR AW_HIDE);
end;

procedure TfrmStatistiken.FormShow(Sender: TObject);
begin
  AnimateWindow(self.Handle, 350, AW_VER_POSITIVE OR AW_SLIDE OR AW_ACTIVATE);
  AnimateWindow(pnlStatistiken.Handle, 350, AW_VER_POSITIVE OR AW_SLIDE OR AW_ACTIVATE);
end;

end.

