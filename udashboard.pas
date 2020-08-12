unit udashboard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  uInfoFrame, TAGraph, TASources, TASeries, TAStyles, TALegendPanel, BCPanel,
  BCListBox, ColorSpeedButton, BCRadialProgressBar, ATPanelSimple, ATPanelColor,
  ECSlider, ECProgressBar, TACustomSeries, TAFuncSeries;

type

  { TfrmDashboard }

  TfrmDashboard = class(TForm)
    BCRadialProgressBar1: TBCRadialProgressBar;
    Chart1: TChart;
    Chart1BarSeries1: TBarSeries;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Image14: TImage;
    LabelsChartSource: TListChartSource;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlDashboard: TBCPanel;
    StaticText22: TStaticText;
    StaticText23: TStaticText;
    StaticText24: TStaticText;
    StaticText25: TStaticText;
    YearChartSource: TRandomChartSource;
    StaticText14: TStaticText;
    StaticText15: TStaticText;
    StaticText16: TStaticText;
    StaticText17: TStaticText;
    StaticText18: TStaticText;
    StaticText19: TStaticText;
    StaticText20: TStaticText;
    StaticText21: TStaticText;
    procedure Chart2PieSeries1GetMark(out AFormattedMark: String;
      AIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure Image14Click(Sender: TObject);
  private

  public

  end;

var
  frmDashboard: TfrmDashboard;

implementation

uses jwawinuser;

{$R *.lfm}

{ TfrmDashboard }

procedure TfrmDashboard.Image14Click(Sender: TObject);
begin
  AnimateWindow(self.Handle, 350, AW_VER_NEGATIVE OR AW_SLIDE OR AW_HIDE);
end;

procedure TfrmDashboard.FormShow(Sender: TObject);
begin
  AnimateWindow(self.Handle, 350, AW_VER_POSITIVE OR AW_SLIDE OR AW_ACTIVATE);
  AnimateWindow(pnlDashboard.Handle, 350, AW_VER_POSITIVE OR AW_SLIDE OR AW_ACTIVATE);
  YearChartSource.RandSeed := Random(MaxInt);
  BCRadialProgressBar1.Value:= Random(100) + 1;
end;

procedure TfrmDashboard.Chart2PieSeries1GetMark(out AFormattedMark: String;
  AIndex: Integer);
begin

end;

end.

